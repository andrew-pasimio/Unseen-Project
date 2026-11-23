// a widget that slides in when the weather button is pushed
import 'package:flutter/material.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      width: double.infinity,
      height: 200,
      child: Center(
        child: Text('Weather Information'),
      ),
    );
  }
}