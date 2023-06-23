import 'package:flutter/material.dart';

class CustomScalePageTransition extends PageRouteBuilder {
  CustomScalePageTransition({required this.child})
      : super(
          transitionDuration: const Duration(milliseconds: 300),
          pageBuilder: (context, animation, secondaryAnimation) => child,
        );
  final Widget child;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) =>
      ScaleTransition(
        scale: animation,
        child: child,
      );
}
