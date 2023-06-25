import 'package:flutter/material.dart';

class CustomSlideTransition extends PageRouteBuilder {
  CustomSlideTransition({
    required this.child,
    required this.slideFrom,
  }) : super(pageBuilder: (context, animation, secondaryAnimation) => child);

  final Widget child;
  final SlideDirection slideFrom;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    Offset begin = _getOffsetStart();
    return SlideTransition(
      position: Tween<Offset>(
        begin: begin,
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }

  Offset _getOffsetStart() {
    return switch (slideFrom) {
      SlideDirection.left => const Offset(-1, 0),
      SlideDirection.right => const Offset(1, 0),
      SlideDirection.top => const Offset(0, -1),
      SlideDirection.bottom => const Offset(0, 1),
    };
  }
}

enum SlideDirection {
  left,
  right,
  top,
  bottom,
}
