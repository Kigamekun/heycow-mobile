import 'package:flutter/material.dart';

class MPPAlert extends StatelessWidget {
  final String imagePath;
  final String title;
  final String subtitle;

  const MPPAlert({
    Key? key,
    required this.imagePath,
    required this.title,
    required this.subtitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(imagePath),
        const SizedBox(height: 16),
        Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        Text(subtitle, style: const TextStyle(fontSize: 14), textAlign: TextAlign.center,),
      ],
    );
  }
}
