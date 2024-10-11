import 'package:flutter/material.dart';

class MPPCard extends StatelessWidget {
  final Widget child;

  const MPPCard({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15.0)),
        boxShadow: [
          BoxShadow(
            color: Color.fromRGBO(79, 76, 76, 0.25),
            offset: Offset(0, 0),
            blurRadius: 4.0,
            spreadRadius: 0,
          ),
        ],
      ),
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: child,
      ),
    );
  }
}
