import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:tesla_app/src/ui/nearest_station_screen.dart';
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
  late Animation<double> _pinkContainerShrinkAnimation;

  @override
  void initState() {
    super.initState();
    _teslaController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 600));
    _teslaRotationAnimation =
        CurvedAnimation(parent: _teslaController, curve: const Interval(0, 1));

    _pinkContainerShrinkAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
        CurvedAnimation(
            parent: _teslaController, curve: const Interval(0.4, 1.0)));

    _teslaSizeAnimation = CurvedAnimation(
        parent: _teslaController, curve: const Interval(0.7, 1));
    _teslaController.forward();

    _backgroundColorController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _backgroundColorAnimation = ColorTween(
      begin: Colors.white,
      end: AppConsts.scaffoldDarkColor,
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
                    Positioned(
                      top: constraints.maxHeight * 0.15,
                      child: Container(
                        width: constraints.maxWidth *
                            _pinkContainerShrinkAnimation.value,
                        child: PinkTeslaModelContainer(
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
                          const AnimatedPositioned(
                            top: 0,
                            duration: Duration.zero,
                            left: 60,
                            child: ModelWidget(),
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
                          AnimatedPositioned(
                            duration: const Duration(milliseconds: 300),
                            bottom: _teslaCarDragAnimation.value == 1
                                ? -120.0
                                : 30.0,
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    CustomScalePageTransition(
                                      child: const NearestStationScreen(),
                                    )
                                    // MaterialPageRoute(
                                    //   builder: (context) {
                                    //     return const NearestStationScreen();
                                    //   },
                                    // ),
                                    );
                              },
                              child: MaintenanceWidet(
                                constraints: constraints,
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
