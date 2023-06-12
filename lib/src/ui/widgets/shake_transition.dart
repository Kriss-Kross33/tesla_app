import 'package:flutter/material.dart';

class ShakeTransition extends StatelessWidget {
  const ShakeTransition({
    super.key,
    required this.child,
    this.duration,
    required this.offset,
    required this.isLeft,
    required this.curve,
  });

  final Widget child;
  final Duration? duration;
  final double offset;
  final bool isLeft;
  final Curve curve;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 1.0, end: 0.0),
      duration: duration ?? const Duration(milliseconds: 300),
      child: child,
      builder: (context, value, child) {
        return Transform.translate(
          offset:
              isLeft ? Offset(-value * offset, 0) : Offset(value * offset, 0),
          child: child,
        );
      },
    );
  }
}
