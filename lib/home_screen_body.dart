import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:weather_app/additional_information_card.dart';
import 'package:http/http.dart' as http;
import 'package:weather_app/api.dart';
import 'package:weather_app/current_forecast_card.dart';
import 'package:weather_app/hourly_forecast_card.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  String cityName = "Mumbai";
  double currTemp = 0;
  double humidity = 0;
  double windSpeed = 0;
  double pressure = 0;
  String city = "Location";
  String weatherCondition = "";

  Future getData(String cityName) async {
    String location = cityName;
    String url =
        "https://api.openweathermap.org/data/2.5/forecast?q=$location&appid=$openWeatherApiKey";

    try {
      final res = await http.get(Uri.parse(url));
      final data = jsonDecode(res.body);
      if (data["cod"] != '200') {
        throw "An unexpected error occured";
      }
      return data;
    } catch (e) {
      throw (e.toString());
    }
  }

  // @override
  // void initState() {
  //   super.initState();
  //   getData(cityName);
  // }

  final TextEditingController textEditingController = TextEditingController();
  final OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(18),
      borderSide: const BorderSide(
        width: 3,
        color: Color.fromARGB(255, 20, 17, 17),
      ));
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getData(cityName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }
        if (snapshot.hasError) {
          return Center(
              child: Text(
            snapshot.error.toString(),
            style: const TextStyle(fontSize: 28),
          ));
        }

        final data = snapshot.data!;
        city = data["city"]["name"];
        weatherCondition = data["list"][0]["weather"][0]["main"];
        final objPart = data['list'][0]['main'];
        currTemp = objPart["temp"];
        humidity = (objPart['humidity']).toDouble();
        pressure = (objPart['pressure']).toDouble();
        windSpeed = (data['list'][0]['wind']['speed']).toDouble();

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // SearchBox(),
                TextField(
                  controller: textEditingController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.location_on,
                      size: 26,
                    ),
                    suffixIcon: IconButton(
                        onPressed: () {
                          cityName = textEditingController.text.toString();

                          setState(() {});
                        },
                        icon: const Icon(Icons.search_rounded, size: 26)),
                    hintText: "Enter a location...",
                    enabledBorder: outlineInputBorder,
                    focusedBorder: outlineInputBorder,
                    border: outlineInputBorder,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18)),
                    elevation: 6,
                    child: Align(
                        alignment: Alignment.center,
                        child: Text(city,
                            style: const TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.w500,
                            ))),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                CurrentForecastCard(
                  temp: currTemp,
                  weatherCondition: weatherCondition,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Weather Forecast",
                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                // forecast card.
                SizedBox(
                  height: 150,
                  child: ListView.builder(
                    itemCount: 5,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, index) {
                      double temp = data["list"][index + 1]["main"]["temp"];
                      String hourlyTime = data["list"][index + 1]["dt_txt"];
                      final time = DateTime.parse(hourlyTime);
                      return HourlyForecastCard(
                        time: DateFormat.j().format(time),
                        weatherCondition: weatherCondition,
                        temp: temp,
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Additional Information',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    AdditionalInformation(
                        icon: Icons.water_drop,
                        weatherCondition: "Humidity",
                        value: humidity),
                    AdditionalInformation(
                        icon: Icons.wind_power,
                        weatherCondition: "Wind Speed",
                        value: windSpeed),
                    AdditionalInformation(
                        icon: Icons.beach_access,
                        weatherCondition: "Pressure",
                        value: pressure),
                  ],
                )
              ],

              // forecast for next 24 hours

              // other parameters
            ),
          ),
        );
      },
    );
  }
}
