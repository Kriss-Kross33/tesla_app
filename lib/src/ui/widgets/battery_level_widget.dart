import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class BatteryLevelWidget extends StatelessWidget {
  const BatteryLevelWidget({
    super.key,
    required this.constraints,
    required this.batteryLevel,
    this.width,
    this.height,
    this.borderRadius,
    this.batteryLevelHeight,
  });

  final BoxConstraints constraints;
  final double batteryLevel;
  final double? batteryLevelHeight;
  final double? width;
  final double? height;
  final double? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width ?? 90,
      padding: const EdgeInsets.only(
        top: 20,
        bottom: 6,
        left: 6,
        right: 6,
      ),
      height: height ?? constraints.maxHeight * 0.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius ?? 40),
        color: Colors.white,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Text(
                    '${batteryLevel.toStringAsFixed(0)}%',
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      fontSize: batteryLevelHeight != null ? 20 : 18,
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    'Battery',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.grey.shade500,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: batteryLevelHeight ?? constraints.maxHeight * 0.18,
              decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(batteryLevelHeight != null ? 50 : 30),
                color: AppConsts.limeGreen,
              ),
            ),
          ),
          Positioned(
            top: 85,
            child: Image.asset(
              AssetConsts.arrowUp,
              height: 10,
              width: 15,
              fit: BoxFit.fill,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
            top: 155,
            child: Image.asset(
              AssetConsts.arrowDown,
              height: 10,
              width: 15,
              fit: BoxFit.fill,
              color: Colors.black.withOpacity(0.5),
            ),
          ),
          Positioned(
              top: 125,
              child: Container(
                width: 20,
                height: 2,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              )),
        ],
      ),
    );
  }
}
