import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

class ModelWidget extends StatelessWidget {
  const ModelWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Model 2.0 ',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontSize: 26,
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
        ),
        Text(
          'Dura chasis',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: AppConsts.grey,
                fontWeight: FontWeight.w600,
              ),
        ),
      ],
    );
  }
}
