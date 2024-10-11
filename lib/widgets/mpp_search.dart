import 'package:flutter/material.dart';
import 'package:heycowmobileapp/app/theme.dart';

class MPPSearch extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onSuffixIconTapped;

  const MPPSearch({super.key, 
    required this.controller,
    required this.onSuffixIconTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100.0),
        color: MPPColorTheme.brokenWhiteColor,
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: 'Search ...',
          contentPadding: const EdgeInsets.all(16.0),
          suffixIcon: GestureDetector(
            onTap: onSuffixIconTapped,
            child: const Icon(Icons.search),
          ),
        ),
      ),
    );
  }
}
