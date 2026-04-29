import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:weather_app/additional_info_item.dart';
import 'package:weather_app/hourly_forecast_item.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/secrets.dart';
import 'package:intl/intl.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key});

  @override
  State<WeatherScreen> createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  late Future<Map<String, dynamic>> weather;

  // double temp = 0;
  // String weather = "";
  // String icon = '';
  // String humidity = "";
  // String windSpeed = "";
  // String pressure = "";

  @override
  void initState() {
    super.initState();
    weather = getCurrentWeather();
  }

  Future<Map<String, dynamic>> getCurrentWeather() async {
    try {
      String city = "Rajkot,in";
      final result = await http.get(
        Uri.parse(
          "https://api.openweathermap.org/data/2.5/forecast?q=$city,uk&APPID=$openWeatherApiKey",
        ),
      );

      final data = jsonDecode(result.body);
      // var abc = data['list'][1]['weather'][0]['main'];
      // print(abc);

      // setState(() {
      //   temp = data['list'][0]['main']['temp'];
      //   weather = data['list'][1]['weather'][0]['main'];
      //   icon = weatherSymbols[weather] ?? "☁️";
      //   humidity = data['list'][0]['main']['humidity'].toString();
      //   pressure = data['list'][0]['main']['pressure'].toString();
      //   windSpeed = data['list'][1]['wind']['speed'].toString();
      // });

      if (data['cod'] != '200') {
        throw 'Something went wrong';
      }

      return data;
    } catch (e) {
      throw e.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'weather app',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              setState(() {
                weather = getCurrentWeather();
              });
            },
            icon: const Icon(Icons.refresh),
          ),
        ],
      ),
      body: FutureBuilder(
        future: weather,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: const CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text(snapshot.error.toString()));
          }

          final data = snapshot.data!;
          final dataPrefix = data['list'];
          final currentTemp = dataPrefix[0]['main']['temp'];
          final currentWeather = dataPrefix[1]['weather'][0]['main'];
          final currentWeatherIcon = weatherSymbols[currentWeather] ?? "☁️";
          final humidity = dataPrefix[0]['main']['humidity'].toString();
          final pressure = dataPrefix[0]['main']['pressure'].toString();
          final windSpeed = dataPrefix[0]['wind']['speed'].toString();

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //main card
                SizedBox(
                  width: double.infinity,
                  child: Card(
                    elevation: 10,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                '$currentTemp K',
                                style: TextStyle(
                                  fontSize: 32,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentWeatherIcon,
                                style: TextStyle(fontSize: 50),
                              ),
                              const SizedBox(height: 10),
                              Text(
                                currentWeather,
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Weather Forecast',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),

                // SingleChildScrollView(
                //   scrollDirection: Axis.horizontal,
                //   child: Row(
                //     children: [
                //       for (int i = 0; i < dataPrefix.length; i++)
                //         HourlyForecastItem(
                //           temp: dataPrefix[i + 1]['main']['temp'].toString(),
                //           time: dataPrefix[i + 1]['dt_txt']
                //               .toString()
                //               .substring(11, 16),
                //           icon:
                //               weatherSymbols[dataPrefix[i]['weather'][0]['main']]
                //                   .toString(),
                //         ),
                //     ],
                //   ),
                // ),
                SizedBox(
                  height: 130,
                  child: ListView.builder(
                    itemCount: dataPrefix.length - 1,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      final hourlyForeCast = data['list'][index + 1];
                      final time = DateTime.parse(hourlyForeCast['dt_txt']);
                      return HourlyForecastItem(
                        temp: hourlyForeCast['main']['temp'].toString(),
                        time: DateFormat.Hm().format(time),
                        icon:
                            weatherSymbols[dataPrefix[index +
                                    1]['weather'][0]['main']]
                                .toString(),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 20),
                const Text(
                  'Additional Information',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInfoItem(
                      icon: '💧',
                      label: 'Humidity',
                      value: humidity,
                    ),
                    AdditionalInfoItem(
                      icon: '🌬️',
                      label: 'Wind Speed',
                      value: windSpeed,
                    ),
                    AdditionalInfoItem(
                      icon: '🌡️',
                      label: 'Pressure',
                      value: pressure,
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
