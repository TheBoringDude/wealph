import 'package:dart_myip/dart_myip.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:wealph/src/models/wealph.dart';
import 'package:wealph/src/models/weather.dart';
import 'package:wealph/src/utils/utils.dart';
import 'package:weather/weather.dart';

class WealphCurrentWeather extends StatefulWidget {
  WealphCurrentWeather({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WealphCurrentWeather();
}

class _WealphCurrentWeather extends State<WealphCurrentWeather> {
  late Future<ClientIP> _ip;

  void initState() {
    super.initState();

    _ip = getMyIP();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FutureBuilder<ClientIP>(
        future: _ip,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return fetchCurrentWeather(snapshot.data!.geo.latitude, snapshot.data!.geo.longitude);
          } else if (snapshot.hasError) {
            return Text("There was a problem trying to fetch the client's geolocation.");
          }

          return CircularProgressIndicator();
        },
      ),
    );
  }

  Widget fetchCurrentWeather(String lat, String lon) {
    return Consumer<WealphModel>(builder: (context, wealph, child) {
      final wf = getWF(wealph.token);
      final weather = wf.currentWeatherByLocation(double.parse(lat), double.parse(lon));

      if (wealph.token == "") {
        return Center(
          child: Text("Token is blank."),
        );
      }

      return FutureBuilder<Weather>(
          future: weather,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  child: showCurrentWeather(snapshot.data));
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }

            return CircularProgressIndicator();
          });
    });
  }

  Widget showCurrentWeather(Weather? w) {
    // null check `w != null`
    if (w != null) {
      return SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "${w.areaName}, ${w.country}",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
            Column(
              children: [
                Image.network("http://openweathermap.org/img/wn/${w.weatherIcon}@4x.png"),
                Text(
                  "${w.weatherDescription}",
                  style: TextStyle(fontSize: 18),
                ),
                Container(
                    margin: EdgeInsets.only(top: 14),
                    child: IntrinsicHeight(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "${w.temperature!.celsius!.toStringAsFixed(1)} $DEGREE_SYMBOL",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          VerticalDivider(width: 30, color: Colors.grey),
                          Text(
                            "${w.tempFeelsLike!.celsius!.toStringAsFixed(1)} $DEGREE_SYMBOL",
                            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    )),
              ],
            )
          ],
          mainAxisAlignment: MainAxisAlignment.center,
        ),
      );
    }

    // if `w == null`
    return Center(
      child: Text("No data was received."),
    );
  }
}
