import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

import 'widgets/widgets.dart';

class TeslaControl extends StatefulWidget {
  const TeslaControl({super.key});

  @override
  State<TeslaControl> createState() => _TeslaControlState();
}

class _TeslaControlState extends State<TeslaControl>
    with TickerProviderStateMixin {
  late AnimationController _teslaController;
  late Animation<double> _teslaRotationAnimation;
  late Animation<double> _teslaSizeAnimation;
  late AnimationController _backgroundColorController;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _searchContainerAnimation;

  @override
  void initState() {
    super.initState();
    _teslaController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _teslaRotationAnimation =
        CurvedAnimation(parent: _teslaController, curve: const Interval(0, 1));
    _teslaSizeAnimation = CurvedAnimation(
        parent: _teslaController, curve: const Interval(0.7, 1));
    _teslaController.forward();

    _backgroundColorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _backgroundColorAnimation = ColorTween(
      begin: Colors.white,
      end: Colors.black,
    ).animate(_backgroundColorController);
    _searchContainerAnimation = ColorTween(
      begin: Colors.black,
      end: Colors.white,
    ).animate(_backgroundColorController);

    _teslaController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _backgroundColorController
          ..reset()
          ..forward();
      }
    });
  }

  @override
  void dispose() {
    _teslaController.dispose();
    _backgroundColorController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return AnimatedBuilder(
            animation: Listenable.merge(
              [
                _teslaRotationAnimation,
                _backgroundColorController,
              ],
            ),
            builder: (context, _) {
              return AnimatedContainer(
                duration: Duration.zero,
                color: _backgroundColorAnimation.value,
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                    left: AppConsts.defaultPadding,
                    right: AppConsts.defaultPadding,
                  ),
                  child: Stack(
                    children: [
                      SizedBox(
                        height: constraints.maxHeight,
                        width: constraints.maxWidth,
                      ),
                      Positioned(
                        right: 0,
                        child: Hero(
                          tag: '1',
                          child: ProfileWidget(
                            duration: Duration.zero,
                            constraints: constraints,
                            searchContainerColor:
                                _searchContainerAnimation.value,
                          ),
                        ),
                      ),
                      AnimatedPositioned(
                        duration: Duration.zero,
                        left: 60,
                        child: Column(
                          children: [
                            Text(
                              'Model 2.0 ',
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w800,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      // Transform(
                      //   transform: Matrix4.identity()..rotateZ(pi / 2),
                      //   child:
                      // AnimatedPositioned(
                      //   duration: AppConsts.defaultDuration,
                      //   left: constraints.maxWidth * 0.6,
                      //   width: constraints.maxWidth * 0.56,
                      //   height: constraints.maxHeight * 0.6,
                      //   child: Transform(
                      //     transform: Matrix4.identity()
                      //       ..rotateZ(
                      //         (-pi / 2) * (1 - _teslaRotationAnimation.value),
                      //       ),
                      //     //  ..translate(-100.0, 0.0, 0.0),
                      //     child: RotatedTesla(
                      //       duration: AppConsts.defaultDuration,
                      //       constraints: constraints,
                      //       //   rotationZ:
                      //       //       (pi / 2) * (1 - _teslaRotationAnimation.value),
                      //     ),
                      //   ),
                      // ),
                      Positioned(
                        //  duration: AppConsts.defaultDuration,
                        left: constraints.maxWidth * 0.1,
                        right: constraints.maxWidth * 0.1,
                        top: constraints.maxWidth * 0.95,
                        child: GestureDetector(
                          onTap: () {},
                          child: Transform(
                            alignment: Alignment.topLeft,
                            transform: Matrix4.identity()
                              ..rotateZ(
                                (-pi / 2) * (1 - _teslaRotationAnimation.value),
                              )
                            // ..rotateZ(
                            //   (-pi / 2) * (1 - _teslaRotationAnimation.value),
                            // ),
                            ,
                            child: SizedBox(
                              width: constraints.maxWidth * 0.56,
                              height: constraints.maxHeight * 0.6,
                              child: Image.asset(
                                AssetConsts.tesla,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 80,
                        left: 0,
                        right: 0,
                        child: Row(
                          children: [
                            Expanded(
                              child: ShakeTransition(
                                offset: 100,
                                isLeft: true,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.easeInOut,
                                child: BatteryLevelWidget(
                                  batteryLevel: 60,
                                  constraints: constraints,
                                  height: constraints.maxHeight * 0.28 + 10,
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
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    child: Container(
                                      width: constraints.maxWidth,
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 6,
                                        left: 6,
                                        right: 6,
                                      ),
                                      height: constraints.maxHeight * 0.16,
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
                                            Container(
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
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    child: Container(
                                      width: constraints.maxWidth,
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 6,
                                        left: 6,
                                        right: 6,
                                      ),
                                      height: constraints.maxHeight * 0.12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: AppConsts.black,
                                      ),
                                      child: Column(
                                        children: [
                                          Image.asset(
                                            AssetConsts.unlocked,
                                            height: 35,
                                            width: 35,
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            'climate',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                    color: AppConsts.grey),
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
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    child: Container(
                                      width: constraints.maxWidth,
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 6,
                                        left: 6,
                                        right: 6,
                                      ),
                                      height: constraints.maxHeight * 0.12,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40),
                                        color: AppConsts.grey,
                                      ),
                                      child: Column(
                                        children: [
                                          Stack(
                                            children: [
                                              Positioned(
                                                child: Image.asset(
                                                  AssetConsts.vect1,
                                                  height: 35,
                                                  width: 35,
                                                ),
                                              ),
                                              Positioned(
                                                child: Image.asset(
                                                  AssetConsts.vect2,
                                                  height: 35,
                                                  width: 35,
                                                ),
                                              ),
                                              Positioned(
                                                child: Image.asset(
                                                  AssetConsts.vect3,
                                                  height: 35,
                                                  width: 35,
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
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.easeInOut,
                                    child: Container(
                                      width: constraints.maxWidth,
                                      padding: const EdgeInsets.only(
                                        top: 20,
                                        bottom: 6,
                                        left: 6,
                                        right: 6,
                                      ),
                                      height: constraints.maxHeight * 0.16,
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
                        ),
                      ),
                      // Positioned(
                      //   left: constraints.maxWidth,
                      //   width: constraints.maxWidth * 0.56,
                      //   height: constraints.maxHeight * 0.6,
                      //   bottom: -constraints.maxHeight * 0.25,
                      //   child: Hero(
                      //     tag: '2',
                      //     child: GestureDetector(
                      //       onTap: () {

                      //       },
                      //       child: Transform(
                      //         transform: Matrix4.identity()..rot,
                      //         child: Image.asset(
                      //           AssetConsts.tesla,
                      //           fit: BoxFit.fill,
                      //         ),
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              );
            });
      }),
    );
  }
}
