import 'package:flutter/material.dart';
import 'package:heycowmobileapp/app/theme.dart';

class MPPBasePage extends StatelessWidget {
  final IconData headerIcon;
  final String headerTitle;
  final List<Widget> children;

  const MPPBasePage({
    Key? key,
    required this.headerIcon,
    required this.headerTitle,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Stack(
        children: [
          Container(
              decoration: BoxDecoration(
                  color: MPPColorTheme.redColor,
                  borderRadius: const BorderRadius.all(Radius.circular(15.0))),
              height: 163,
              width: double.infinity),
          Padding(
            padding: const EdgeInsets.only(
              left: 18.0,
              right: 18.0,
              top: 50,
              bottom: 50,
            ),
            child: Column(
              children: [
                Icon(
                  headerIcon,
                  color: MPPColorTheme.brokenWhiteColor,
                  size: 42,
                ),
                Text(headerTitle,
                    style: TextStyle(
                      fontWeight: FontWeight.w700,
                      color: MPPColorTheme.brokenWhiteColor,
                      fontSize: 16.0)),
                const SizedBox(height: 20),
                ...children,
                const SizedBox(height: 50),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
