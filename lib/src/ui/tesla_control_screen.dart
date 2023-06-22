import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

import 'widgets/widgets.dart';

class TeslaControlScreen extends StatefulWidget {
  const TeslaControlScreen({super.key});

  @override
  State<TeslaControlScreen> createState() => _TeslaControlScreenState();
}

class _TeslaControlScreenState extends State<TeslaControlScreen>
    with TickerProviderStateMixin {
  late AnimationController _teslaController;
  late AnimationController _teslaControlsController;
  late AnimationController _radialController;
  late Animation<double> _teslaRotationAnimation;
  late Animation<double> _teslaSizeAnimation;
  late Animation<double> _teslaControlsAnimation;
  late AnimationController _backgroundColorController;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _searchContainerAnimation;
  late AnimationController _teslaDragController;
  late Animation<double> _teslaCarDragAnimation;
  late Animation<double> _radialOpacityAnimation;

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
    _teslaControlsController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 300));
    _teslaControlsAnimation = Tween<double>(begin: 0, end: 0.6).animate(
      CurvedAnimation(
        parent: _teslaControlsController,
        curve: Curves.easeInOut,
      ),
    );

    _radialController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 200));

    _radialOpacityAnimation =
        _teslaControlsAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _radialController,
        curve: Curves.easeInOut,
      ),
    );

    _teslaController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _teslaControlsController
          ..reset()
          ..forward();
      }
    });

    _teslaDragController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _teslaCarDragAnimation = Tween<double>(begin: 1, end: 0.4).animate(
      CurvedAnimation(
        parent: _teslaDragController,
        curve: Curves.easeInOut,
      ),
    );

    _teslaDragController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _radialController.forward();
      } else if (status == AnimationStatus.reverse) {
        _radialController.reverse(from: 0.7);
      }
    });

    _teslaControlsController.addStatusListener((status) {
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
    _teslaControlsController.dispose();
    _teslaDragController.dispose();
    _radialController.dispose();
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
                _teslaControlsController,
                _teslaDragController,
                _radialController,
              ],
            ),
            builder: (context, _) {
              return AnimatedContainer(
                duration: Duration.zero,
                color: _backgroundColorAnimation.value,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned(
                      top: constraints.maxWidth * 0.4,
                      child: AnimatedOpacity(
                        duration: Duration.zero,
                        opacity: _radialOpacityAnimation.value,
                        child: RadialWidget(
                          constraints: constraints,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 40,
                        left: AppConsts.defaultPadding,
                        right: AppConsts.defaultPadding,
                      ),
                      child: Stack(
                        clipBehavior: Clip.none,
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: constraints.maxHeight,
                            width: constraints.maxWidth,
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: Hero(
                              tag: '1',
                              child: GestureDetector(
                                onTap: () {},
                                child: ProfileWidget(
                                  duration: Duration.zero,
                                  constraints: constraints,
                                  searchContainerColor:
                                      _searchContainerAnimation.value,
                                ),
                              ),
                            ),
                          ),
                          AnimatedPositioned(
                            top: 0,
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
                          AnimatedPositioned(
                            duration:
                                Duration.zero, //AppConsts.defaultDuration,
                            left: constraints.maxWidth * 0.1,
                            right: constraints.maxWidth * 0.1,
                            top: _teslaCarDragAnimation.value < 1
                                ? constraints.maxHeight *
                                    0.4 *
                                    _teslaCarDragAnimation.value
                                : constraints.maxHeight *
                                    4.95 *
                                    _teslaCarDragAnimation.value *
                                    0.1,
                            child: GestureDetector(
                              onVerticalDragUpdate: _onVerticalDragUpdate,
                              child: Transform(
                                alignment: Alignment.topLeft,
                                transform: Matrix4.identity()
                                  ..rotateZ(
                                    (-pi / 2) *
                                        (1 - _teslaRotationAnimation.value),
                                  ),
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
                          AnimatedPositioned(
                            duration: AppConsts.defaultDuration,
                            top: _teslaCarDragAnimation.value < 1
                                ? -constraints.maxHeight *
                                    _teslaCarDragAnimation.value
                                : 80,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              child: _teslaControlsController.value == 0
                                  ? const SizedBox.shrink()
                                  : TeslaControls(
                                      constraints: constraints,
                                      isShakeTransitionFinished:
                                          _teslaControlsController.value == 1,
                                    ),
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            child: Container(
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text.rich(
                                        TextSpan(
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: '2 Mild ',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .titleLarge
                                                  ?.copyWith(
                                                    fontWeight: FontWeight.w800,
                                                  ),
                                            ),
                                            TextSpan(
                                              text: 'Issues',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .headlineSmall,
                                            ),
                                          ],
                                        ),
                                      ),
                                      Text(
                                        'Maintenance',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium
                                            ?.copyWith(
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
                                              color: AppConsts.red
                                                  .withOpacity(0.4),
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
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      }),
    );
  }

  void _onVerticalDragUpdate(DragUpdateDetails details) {
    print(details.delta.dy);
    if (details.delta.dy < 1) {
      _teslaDragController.forward();
    } else {
      _teslaDragController.reverse();
    }
  }
}

