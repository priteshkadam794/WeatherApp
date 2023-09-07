import 'package:flutter/material.dart';

class AdditionalInformation extends StatelessWidget {
  final IconData icon;
  final String weatherCondition;
  final double value;
  const AdditionalInformation(
      {super.key,
      required this.icon,
      required this.weatherCondition,
      required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Icon(
        icon,
        size: 35,
      ),
      const SizedBox(
        height: 10,
      ),
      Text(
        weatherCondition,
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      const SizedBox(
        height: 6,
      ),
      Text(
        value.toString(),
        style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 17),
      )
    ]);
  }
}
