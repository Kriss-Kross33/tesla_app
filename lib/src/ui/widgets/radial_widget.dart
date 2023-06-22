import 'package:flutter/material.dart';

class RadialWidget extends StatelessWidget {
  const RadialWidget({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final width = constraints.maxWidth * 1.4;
    final radius = width / 2;

    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
        //   color: Colors.red,

        gradient: const RadialGradient(
          colors: [
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
            Color(0xFFD9D9D9),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
