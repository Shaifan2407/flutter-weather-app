import 'package:flutter/material.dart';

class AdditionalInfoItem extends StatelessWidget {
  final String icon;
  final String label;
  final String value;
  const AdditionalInfoItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 8),
        Text(icon, style: TextStyle(fontSize: 32)),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(fontSize: 16)),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
