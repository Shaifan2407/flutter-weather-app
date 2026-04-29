import 'package:flutter/material.dart';

class HourlyForecastItem extends StatelessWidget {
  final String time;
  final String temp;
  final String icon;
  const HourlyForecastItem({
    super.key,
    required this.temp,
    required this.time,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      child: Container(
        width: 100,
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              maxLines: 1,
            ),
            const SizedBox(height: 10),
            Text(icon, style: TextStyle(fontSize: 25)),
            const SizedBox(height: 10),
            Text(temp, style: TextStyle(fontSize: 14)),
          ],
        ),
      ),
    );
  }
}
