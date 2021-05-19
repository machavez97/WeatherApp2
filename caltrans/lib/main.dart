import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:caltrans/pages/WeatherInfo.dart';
import 'package:caltrans/pages/WeatherWidget.dart';
import 'package:flutter/material.dart';

//https://medium.com/flutter-community/finding-users-location-in-flutter-831d40f49c08
//https://dragosholban.com/2018/07/01/how-to-build-a-simple-weather-app-in-flutter/


void main()  => runApp(new MyApp());

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new MyAppState();
  }
}

 class MyAppState extends State<MyApp> {

   static Position _location = Position(latitude: 0.0, longitude: 0.0);

   WeatherData weatherData;



   @override
   void initState() {
     super.initState();
     fetchWeather();
   }

   @override
   Widget build(BuildContext context) {
     return MaterialApp(
         title: 'Weather Page',
         theme: ThemeData(
           primarySwatch: Colors.blue,
         ),
         home: Scaffold(
             backgroundColor: Colors.blueGrey,
             appBar: AppBar(
               title: Text('Weather'),
             ),
             body: Center(
                 child: Column(
                     mainAxisSize: MainAxisSize.min,
                     children: <Widget>[
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child:  weatherData != null ? Weather(weather: weatherData) : Container(),
                       ),
                       Padding(
                         padding: const EdgeInsets.all(8.0),
                         child: IconButton(
                           icon: new Icon(Icons.refresh),
                           tooltip: 'Refresh',
                           onPressed:  fetchWeather,

                           color: Colors.white,
                         ),
                       ),
                     ],
                 ),
             ),
         ),



     );

   }
   fetchWeather() async {
     final location = await Geolocator().getCurrentPosition(
         desiredAccuracy: LocationAccuracy.high);
     setState(() {
       _location = location;
     });

     final url = 'https://api.weather.gov/points/${_location.latitude},${_location.longitude}';
     final response = await http.get(url);
     if (response.statusCode != 200)
       throw Exception();
     final mainUrl = json.decode(response.body)['properties']['forecastHourly'];
     final mainResponse = await http.get(mainUrl);
     if (mainResponse.statusCode != 200)
       throw Exception();
     return setState(() {
       weatherData =  new WeatherData.fromJson(json.decode(mainResponse.body));

     });
   }
 }
