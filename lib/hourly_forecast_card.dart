import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HourlyForecastCard extends StatelessWidget {
  final String time;
  final String weatherCondition;
  final double temp;
  const HourlyForecastCard(
      {super.key,
      required this.time,
      required this.weatherCondition,
      required this.temp});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
        child: Column(
          children: [
            //time
            Text(
              time,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
            ),
            const SizedBox(
              height: 8,
            ),
            FaIcon(
              weatherCondition == "Clear"
                  ? Icons.sunny
                  : weatherCondition == "Rain"
                      ? FontAwesomeIcons.cloudRain
                      : weatherCondition == "Clouds"
                          ? FontAwesomeIcons.cloudSun
                          : FontAwesomeIcons.cloudSunRain,
              size: 40,
            ),
            const SizedBox(
              height: 10,
            ),
            // temperature
            Text(
              "${(temp - 273.15).toStringAsFixed(2)} °C",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
