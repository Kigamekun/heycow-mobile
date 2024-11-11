import 'package:flutter/material.dart';

class MPPImage extends StatelessWidget {
  final double width;
  final double height;

  const MPPImage({
    super.key,
    this.width = 100,
    this.height = 100,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/MPP_depok.jpeg',
      width: width,
      height: height,
    );
  }
}
