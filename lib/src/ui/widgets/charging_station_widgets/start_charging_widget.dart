import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

class StartChargingWidget extends StatelessWidget {
  const StartChargingWidget({
    super.key,
    required this.constraints,
    this.onTap,
  });

  final BoxConstraints constraints;

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        right: 5,
        left: 40,
        top: 5,
        bottom: 5,
      ),
      width: constraints.maxWidth - 40,
      height: constraints.maxHeight * 0.12,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Text(
            'Start Charging',
            style: Theme.of(context)
                .textTheme
                .titleLarge
                ?.copyWith(fontWeight: FontWeight.w800, color: Colors.white),
          ),
          const Spacer(),
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: constraints.maxHeight,
              width: 90,
              decoration: BoxDecoration(
                color: AppConsts.black,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        blurRadius: 5,
                        color: AppConsts.red.withOpacity(0.4),
                        spreadRadius: 1,
                        offset: const Offset(0, 3.5),
                      )
                    ],
                  ),
                  child: Image.asset(
                    AssetConsts.charge,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
