import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

class MaintenanceWidet extends StatelessWidget {
  const MaintenanceWidet({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 40,
        right: 30,
      ),
      width: constraints.maxWidth - 40,
      height: constraints.maxHeight * 0.12,
      decoration: BoxDecoration(
        color: AppConsts.pinkDuet,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text.rich(
                TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: '2 Mild ',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.w800,
                          ),
                    ),
                    TextSpan(
                      text: 'Issues',
                      style: Theme.of(context).textTheme.headlineSmall,
                    ),
                  ],
                ),
              ),
              Text(
                'Maintenance',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.grey,
                    ),
              )
            ],
          ),
          const Spacer(),
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
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
                  AssetConsts.alarmAlt,
                  height: 20,
                  width: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
