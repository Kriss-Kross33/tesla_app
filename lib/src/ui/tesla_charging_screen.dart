import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

class TeslaChargingScreen extends StatefulWidget {
  const TeslaChargingScreen({super.key});

  @override
  State<TeslaChargingScreen> createState() => _TeslaChargingScreenState();
}

class _TeslaChargingScreenState extends State<TeslaChargingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: AppConsts.defaultDuration,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConsts.black,
      body: LayoutBuilder(builder: (context, constraints) {
        return AnimatedBuilder(
            animation: _controller,
            builder: (context, _) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  ),
                  Positioned(
                    top: -constraints.maxHeight * 0.1,
                    child: Hero(
                      tag: '3',
                      child: Image.asset(
                        AssetConsts.tesla2,
                        width: constraints.maxWidth * 0.76,
                        height: constraints.maxHeight * 0.76,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              );
            });
      }),
    );
  }
}
