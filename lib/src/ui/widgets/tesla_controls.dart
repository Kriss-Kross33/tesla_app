import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tesla_app/src/ui/widgets/widgets.dart';
import 'package:tesla_app/src/utils/utils.dart';

class TeslaControls extends StatefulWidget {
  const TeslaControls({
    super.key,
    required this.constraints,
    required this.isShakeTransitionFinished,
  });

  final BoxConstraints constraints;
  final bool isShakeTransitionFinished;

  @override
  State<TeslaControls> createState() => _TeslaControlsState();
}

class _TeslaControlsState extends State<TeslaControls>
    with SingleTickerProviderStateMixin {
  late AnimationController _teslaControlIconController;
  late Animation<double> _teslaControlsIconAnimation;
  late Animation<double> _teslaNavigationIconAnimation;

  @override
  void initState() {
    super.initState();
    _teslaControlIconController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );

    _teslaControlsIconAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _teslaControlIconController,
        curve: Curves.easeInOut,
      ),
    );
    _teslaNavigationIconAnimation = Tween<double>(begin: 1, end: 0).animate(
      CurvedAnimation(
        parent: _teslaControlIconController,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _teslaControlIconController.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant TeslaControls oldWidget) {
    if (widget.isShakeTransitionFinished) {
      _teslaControlIconController.forward();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 400);
    // print(20 * (1 - _teslaNavigationIconAnimation.value));
    return AnimatedBuilder(
        animation: _teslaControlIconController,
        builder: (context, _) {
          return Row(
            children: [
              Expanded(
                child: ShakeTransition(
                  offset: 100,
                  isLeft: true,
                  duration: duration,
                  curve: Curves.easeInOut,
                  child: BatteryLevelWidget(
                    batteryLevel: 60,
                    constraints: widget.constraints,
                    height: widget.constraints.maxHeight * 0.28 + 10,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    ShakeTransition(
                      offset: 100,
                      isLeft: true,
                      duration: duration,
                      curve: Curves.easeInOut,
                      child: Container(
                        width: widget.constraints.maxWidth,
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 6,
                          left: 6,
                          right: 6,
                        ),
                        height: widget.constraints.maxHeight * 0.16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppConsts.lightBlue,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              Text(
                                '24\u2103',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                'climate',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodySmall
                                    ?.copyWith(),
                              ),
                              const Spacer(),
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.identity()
                                  ..rotateZ(
                                    3 *
                                        -pi *
                                        (1 - _teslaControlsIconAnimation.value),
                                  ),
                                child: Container(
                                  height: 40,
                                  width: 40,
                                  decoration: const BoxDecoration(
                                    image: DecorationImage(
                                      image: AssetImage(
                                        AssetConsts.sun,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ShakeTransition(
                      offset: 100,
                      isLeft: false,
                      duration: duration,
                      curve: Curves.easeInOut,
                      child: Container(
                        width: widget.constraints.maxWidth,
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 6,
                          left: 6,
                          right: 6,
                        ),
                        height: widget.constraints.maxHeight * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppConsts.black,
                        ),
                        child: Column(
                          children: [
                            Transform(
                              alignment: Alignment.center,
                              transform: Matrix4.identity()
                                ..rotateY(pi /
                                    2 *
                                    (1 - _teslaControlIconController.value)),
                              child: Image.asset(
                                AssetConsts.unlocked,
                                height: 35,
                                width: 35,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'unlocked',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: AppConsts.grey),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  children: [
                    ShakeTransition(
                      offset: 100,
                      isLeft: false,
                      duration: duration,
                      curve: Curves.easeInOut,
                      child: Container(
                        width: widget.constraints.maxWidth,
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 6,
                        ),
                        height: widget.constraints.maxHeight * 0.12,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppConsts.grey,
                        ),
                        child: Column(
                          children: [
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                SizedBox(
                                  width: widget.constraints.maxWidth,
                                ),
                                Transform(
                                  transform: Matrix4.identity()
                                    ..translate(
                                      14 *
                                          (1 -
                                              _teslaNavigationIconAnimation
                                                  .value),
                                      0.0,
                                      0.0,
                                    ),
                                  alignment: Alignment.center,
                                  child: Image.asset(
                                    AssetConsts.vect1,
                                    height: 30,
                                    width: 10,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                                Image.asset(
                                  AssetConsts.vect2,
                                  height: 30,
                                  width: 10,
                                  fit: BoxFit.fill,
                                ),
                                Transform(
                                  alignment: Alignment.center,
                                  transform: Matrix4.identity()
                                    ..translate(
                                      -7 *
                                          (1 +
                                              _teslaControlsIconAnimation
                                                  .value),
                                      0.0,
                                      0.0,
                                    ),
                                  child: Image.asset(
                                    AssetConsts.vect3,
                                    height: 30,
                                    width: 10,
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Navigation',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppConsts.black,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ShakeTransition(
                      offset: 100,
                      isLeft: false,
                      duration: duration,
                      curve: Curves.easeInOut,
                      child: Container(
                        width: widget.constraints.maxWidth,
                        padding: const EdgeInsets.only(
                          top: 20,
                          bottom: 6,
                          left: 6,
                          right: 6,
                        ),
                        height: widget.constraints.maxHeight * 0.16,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: AppConsts.pinkDuet,
                        ),
                        child: Column(
                          children: [
                            Text(
                              '2 Mild',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text(
                              'Maintenance',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                    color: AppConsts.black,
                                  ),
                            ),
                            Image.asset(
                              AssetConsts.alarm,
                              height: 35,
                              width: 35,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
