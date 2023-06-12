import 'package:flutter/material.dart';

import '../../utils/utils.dart';

class BatteryLevelWidget extends StatelessWidget {
  const BatteryLevelWidget({
    super.key,
    required this.constraints,
    required this.batteryLevel,
    this.width,
    this.height,
  });

  final BoxConstraints constraints;
  final double batteryLevel;
  final double? width;
  final double? height;

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
        borderRadius: BorderRadius.circular(40),
        color: AppConsts.grey,
      ),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Column(
              children: [
                Text(
                  '${batteryLevel.toStringAsFixed(0)}%',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
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
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              height: constraints.maxHeight * 0.18,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                gradient: LinearGradient(
                  colors: [
                    AppConsts.limeGreen,
                    AppConsts.limeGreen.withOpacity(0.1),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
