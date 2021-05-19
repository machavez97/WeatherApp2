import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:caltrans/pages/WeatherInfo.dart';



class Weather extends StatelessWidget {
  final WeatherData weather;

  Weather({Key key, @required this.weather}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(weather.condition, style: new TextStyle(color: Colors.white, fontSize: 50.0)),
        Text('${weather.temp.toString()}°F',  style: new TextStyle(color: Colors.white, fontSize: 32.0)),
        Image.network(weather.icon.substring(0, weather.icon.indexOf('=')) + '=large'),
        Text(weather.wind + ' ' + weather.direction, style: new TextStyle(color: Colors.white, fontSize: 24.0)),



       Text(new DateFormat.yMMMd().format(new DateTime.now()), style: new TextStyle(color: Colors.white)),
        Text(new DateFormat.jm().format(new DateTime.now()), style: new TextStyle(color: Colors.white)),
      ],
    );
  }
}