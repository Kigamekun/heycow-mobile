import 'package:flutter/material.dart';

class MPPBadge extends StatelessWidget {
  final String text;
  final Color color;

const MPPBadge({
  Key? key,
  required this.text,
  required this.color,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal:16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w400,
          fontSize: 8.0
        ),
      ),
    );
  }
}