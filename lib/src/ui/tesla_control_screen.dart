import 'dart:math';

import 'package:flutter/material.dart';
import 'package:tesla_app/src/ui/testa_screen.dart';
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
  late Animation<double> _teslaRotationAnimation;
  late Animation<double> _teslaSizeAnimation;
  late Animation<double> _teslaControlsAnimation;
  late AnimationController _backgroundColorController;
  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Color?> _searchContainerAnimation;
  late AnimationController _teslaDragController;
  late Animation<double> _teslaCarDragAnimation;

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
    _teslaControlsAnimation = Tween<double>(begin: 0, end: 0.5).animate(
      CurvedAnimation(
        parent: _teslaControlsController,
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
    _teslaCarDragAnimation = Tween<double>(begin: 1, end: 0.5).animate(
      CurvedAnimation(
        parent: _teslaDragController,
        curve: Curves.easeInOut,
      ),
    );

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
                      top: constraints.maxWidth * 0.5,
                      child: CircularBlurWidget(
                        constraints: constraints,
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
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return const TestaScreen();
                                  }));
                                },
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
                          AnimatedPositioned(
                            duration: AppConsts.defaultDuration,
                            top: _teslaCarDragAnimation.value < 1
                                ? -(constraints.maxHeight * 0.7) *
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

class CircularBlurWidget extends StatelessWidget {
  const CircularBlurWidget({
    super.key,
    required this.constraints,
  });

  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    final width = constraints.maxWidth * 1.4;
    final radius = width / 2;

    return Container(
      height: width,
      width: width,
      decoration: BoxDecoration(
        //   color: Colors.red,

        gradient: const RadialGradient(
          colors: [
            Colors.black,
            Colors.black,
            Colors.black,
            Colors.black,
            Color(0xFFD9D9D9),
          ],
        ),
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }
}
