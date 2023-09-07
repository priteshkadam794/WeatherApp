import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CurrentForecastCard extends StatelessWidget {
  final double temp;
  final String weatherCondition;
  const CurrentForecastCard(
      {super.key, required this.temp, required this.weatherCondition});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 8,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(children: [
                // temperature outside
                Text(
                  "${(temp - 273.15).toStringAsFixed(2)} °C",
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 14,
                ),
                FaIcon(
                  weatherCondition == "Clear"
                      ? Icons.sunny
                      : weatherCondition == "Rain"
                          ? FontAwesomeIcons.cloudRain
                          : weatherCondition == "Clouds"
                              ? FontAwesomeIcons.cloudSun
                              : FontAwesomeIcons.cloudSunRain,
                  size: 70,
                ),
                // type of weather
                const SizedBox(
                  height: 14,
                ),
                Text(
                  weatherCondition,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w500),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
