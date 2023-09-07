import 'package:flutter/material.dart';
import 'package:weather_app/home_screen_body.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: const Text(
            "Weather Forecast",
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.w500,
            ),
          ),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {
                  setState(() {});
                },
                icon: const Icon(Icons.refresh)),
          ],
        ),
        body: const Body(),
      ),
    );
  }
}
