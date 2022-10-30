import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

void main() {
  runApp(MaterialApp(
    title: "Weather App",
    home: Home(),
  ));
}

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  var temp;
  var description;
  var currently;
  var humidity;
  var windSpeed;

  Future getWeather() async {
    http.Response response = await http.get(Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=Pune&units=imperial&appid=4e0708871111ddef6a03429f3374ab2b"));
    var results = jsonDecode(response.body);
    setState(() {
      this.temp = results['main']['temp'];
      this.description = results['weather'][0]['description'];
      this.currently = results['weather'][0]['main'];
      this.humidity = results['main']['humidity'];
      this.windSpeed = results['wind']['speed'];
    });
  }

  @override
  void initState() {
    super.initState();
    this.getWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: <Widget>[
        Container(
          height: MediaQuery.of(context).size.height / 3,
          width: MediaQuery.of(context).size.width,
          color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              const Padding(
                padding: EdgeInsets.only(bottom: 10.0),
                child: Text(
                  "Currently in Pune",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Text(
                temp != null ? temp.toString() + "\u00B0" : "Loading",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 40.0,
                    fontWeight: FontWeight.w600),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  currently != null ? currently.toString() : "Loading",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14.0,
                      fontWeight: FontWeight.w600),
                ),
              )
            ],
          ),
        ),
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: <Widget>[
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.thermometer),
                title: const Text("Temperature"),
                trailing: Text(temp != null ? "$temp\u00B0" : "Loading"),
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.cloud),
                title: const Text("Weather"),
                trailing: Text(
                    description != null ? description.toString() : "Loading"),
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.sun),
                title: const Text("Humidity"),
                trailing:
                    Text(humidity != null ? humidity.toString() : "Loading"),
              ),
              ListTile(
                leading: const FaIcon(FontAwesomeIcons.wind),
                title: const Text("Wind Speed"),
                trailing:
                    Text(windSpeed != null ? windSpeed.toString() : "Loading"),
              ),
            ],
          ),
        ))
      ]),
    );
  }
}
