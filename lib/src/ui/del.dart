import 'dart:math';

import 'package:flutter/material.dart';

class TestAnim extends StatefulWidget {
  const TestAnim({super.key});

  @override
  State<TestAnim> createState() => _TestAnimState();
}

class _TestAnimState extends State<TestAnim>
    with SingleTickerProviderStateMixin {
  late AnimationController _flipAnimationController;
  late Animation _flipAnimation;
  @override
  void initState() {
    super.initState();
    _flipAnimationController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _flipAnimation = CurvedAnimation(
        parent: _flipAnimationController, curve: Curves.bounceOut);
  }

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 2), () {
      _flipAnimationController
        ..reset()
        ..forward();
    });

    return Scaffold(
      body: SafeArea(
        child: AnimatedBuilder(
            animation: _flipAnimation,
            builder: (context, _) {
              return Transform(
                alignment: Alignment.center,
                transform: Matrix4.identity()
                  ..rotateZ(
                    -pi / 2 * _flipAnimation.value,
                  ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipPath(
                      clipper: CircleClipPath(clip: CircleClip.left),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(color: Colors.red),
                      ),
                    ),
                    ClipPath(
                      clipper: CircleClipPath(
                        clip: CircleClip.right,
                      ),
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: const BoxDecoration(color: Colors.cyan),
                      ),
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
}

enum CircleClip {
  left,
  right,
}

class CircleClipPath extends CustomClipper<Path> {
  CircleClipPath({required this.clip});
  final CircleClip clip;

  @override
  Path getClip(Size size) {
    final path = Path();
    late bool clockwise;
    late Offset offset;
    switch (clip) {
      case CircleClip.left:
        path.moveTo(size.width, 0);
        clockwise = false;
        offset = Offset(size.width, size.height);

        break;
      case CircleClip.right:
        clockwise = true;
        offset = Offset(0, size.height);
    }

    path.arcToPoint(
      offset,
      radius: Radius.elliptical(size.width / 2, size.width / 2),
      clockwise: clockwise,
    );
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => true;
}
