import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

class TeslaIssueWarningWidget extends StatefulWidget {
  const TeslaIssueWarningWidget({super.key});

  @override
  State<TeslaIssueWarningWidget> createState() =>
      _TeslaIssueWarningWidgetState();
}

class _TeslaIssueWarningWidgetState extends State<TeslaIssueWarningWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _issueController;
  late Animation<double> _issueanimation;
  late Animation<double> _warningIconAnimation;

  @override
  void initState() {
    super.initState();
    _issueController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 600,
      ),
    );
    _issueanimation = CurvedAnimation(
      parent: _issueController,
      curve: const Interval(0.0, 0.7),
    );
    _warningIconAnimation = CurvedAnimation(
      parent: _issueController,
      curve: const Interval(
        0.6,
        1.0,
        curve: Curves.elasticInOut,
      ),
    );

    _issueController.forward(from: 0.3);
    _issueController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(milliseconds: 1500), () {
          if (mounted) {
            _issueController
              ..reset()
              ..forward();
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _issueController.removeStatusListener((status) {});
    _issueController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ScaleTransition(
          scale: _issueanimation,
          child: Container(
            height: 30,
            width: 30,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 5,
                  blurRadius: 3,
                  color: Colors.red.withOpacity(0.9),
                ),
              ],
            ),
          ),
        ),
        ScaleTransition(
          scale: _warningIconAnimation,
          child: Image.asset(
            AssetConsts.warning,
            height: 20,
            width: 8,
            color: Colors.white,
            fit: BoxFit.fill,
          ),
        ),
      ],
    );
  }
}
