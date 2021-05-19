class WeatherData{
  final String icon;
  final int temp;
  final String wind;
  final String direction;
  final String condition;


  WeatherData({this.icon, this.temp, this.wind, this.direction, this.condition});

  factory WeatherData.fromJson(Map<String, dynamic> json) {
    return WeatherData(
      icon: json['properties']['periods'][0]['icon'] as String,
      temp: json['properties']['periods'][0]['temperature'] as int,
      wind: json['properties']['periods'][0]['windSpeed'] as String,
      direction: json['properties']['periods'][0]['windDirection'] as String,
      condition: json['properties']['periods'][0]['shortForecast'] as String,


    );
  }
}
