import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:wealph/src/error.dart';

class CurrentWeather {
  static String url =
      'https://api.openweathermap.org/data/2.5/weather?lat=55.5&lon=37.5&cnt=10&appid=';
  Coord coord;
  List<WeatherAlpha> weather;
  String base;
  Main main;
  int visibility;
  Wind wind;
  Clouds clouds;
  int dt;
  Sys sys;
  int timezone;
  int id;
  String name;
  int cod;

  CurrentWeather({
    required this.coord,
    required this.weather,
    required this.base,
    required this.main,
    required this.visibility,
    required this.wind,
    required this.clouds,
    required this.dt,
    required this.sys,
    required this.timezone,
    required this.id,
    required this.name,
    required this.cod,
  });

  factory CurrentWeather.fromJson(Map<String, dynamic> json) {
    return CurrentWeather(
        coord: json['coord'],
        weather: json['weather'],
        base: json['base'],
        main: json['main'],
        visibility: json['visibility'],
        wind: json['wind'],
        clouds: json['clouds'],
        dt: json['dt'],
        sys: json['sys'],
        timezone: json['timezone'],
        id: json['id'],
        name: json['name'],
        cod: json['cod']);
  }

  static Future<String> fetch() async {
    return "";
  }

  // static Future<Map<String, dynamic>> fetch() async {
  //   final response = await http.get(Uri.parse(
  //       'https://alpha-weather.vercel.app/api/weather?url=${Uri.encodeComponent(CurrentWeather.url)}'));

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw FailedRequest("Request failed.");
  //   }
  // }
}

class Clouds {
  int all;

  Clouds({
    required this.all,
  });
}

class Coord {
  double lon;
  double lat;

  Coord({
    required this.lon,
    required this.lat,
  });
}

class Main {
  double temp;
  double feelsLike;
  double tempMin;
  double tempMax;
  int pressure;
  int humidity;

  Main({
    required this.temp,
    required this.feelsLike,
    required this.tempMin,
    required this.tempMax,
    required this.pressure,
    required this.humidity,
  });
}

class Sys {
  int type;
  int id;
  double message;
  String country;
  int sunrise;
  int sunset;

  Sys({
    required this.type,
    required this.id,
    required this.message,
    required this.country,
    required this.sunrise,
    required this.sunset,
  });
}

class WeatherAlpha {
  int id;
  String main;
  String description;
  String icon;

  WeatherAlpha({
    required this.id,
    required this.main,
    required this.description,
    required this.icon,
  });
}

class Wind {
  double speed;
  int deg;

  Wind({
    required this.speed,
    required this.deg,
  });
}
