import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

class PinkTeslaModelContainer extends StatelessWidget {
  const PinkTeslaModelContainer({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: constraints.maxWidth,
      height: constraints.maxHeight * 0.45,
      decoration: BoxDecoration(
        color: AppConsts.pinkDuet,
        borderRadius: BorderRadius.circular(50),
      ),
      child: Stack(
        //   alignment: Alignment.center,
        children: [
          Positioned(
            left: 35,
            top: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Model 2.0 ',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  'DURA chassis',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        color: Colors.grey.shade500,
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
