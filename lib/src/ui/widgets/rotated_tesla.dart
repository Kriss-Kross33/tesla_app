import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tesla_app/src/ui/tesla_control_screen.dart';
import 'package:tesla_app/src/utils/utils.dart';

class RotatedTesla extends StatelessWidget {
  const RotatedTesla({
    super.key,
    required this.duration,
    required this.constraints,
    this.animationValue,
    this.rotationZ = 0,
  });

  final Duration duration;
  final BoxConstraints constraints;
  final double? animationValue;
  final double? rotationZ;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: '2',
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const TeslaControlScreen();
              },
            ),
          );
        },
        child: Transform(
          alignment: Alignment.center,
          transform: Matrix4.identity()
            ..rotateZ(-pi / 2)
            ..rotateZ(rotationZ!),
          child: Image.asset(
            AssetConsts.tesla2,
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }
}
