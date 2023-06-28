import 'package:flutter/material.dart';
import 'package:tesla_app/src/ui/tesla_control_screen.dart';
import 'package:tesla_app/src/utils/utils.dart';

import 'widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _profilePictureAnimation;
  late Animation<double> _teslaForwardAnimation;
  late Animation<double> _greetingTextAnimation;
  late Animation<double> _teslaInfoContainerAnimation;
  late AnimationController _chargingPercentController;
  late Animation<double> _chargingPercentageAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: AppConsts.defaultDuration,
    );

    _profilePictureAnimation = CurvedAnimation(
        parent: _animationController, curve: const Interval(0, 0.5));

    _teslaForwardAnimation = CurvedAnimation(
        parent: _animationController, curve: const Interval(0.6, 0.8));

    _greetingTextAnimation = CurvedAnimation(
        parent: _animationController, curve: const Interval(0.4, 1));

    _teslaInfoContainerAnimation = CurvedAnimation(
        parent: _animationController, curve: const Interval(0.1, 0.4));
    _chargingPercentController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 700),
    );
    _chargingPercentageAnimation =
        Tween<double>(begin: 0, end: 60).animate(_chargingPercentController);
    _animationController.forward();
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _chargingPercentController.forward();
      }
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _animationController.removeStatusListener((status) {});
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConsts.scaffoldBgColor,
      body: Padding(
        padding: const EdgeInsets.only(
          left: AppConsts.defaultPadding,
          right: AppConsts.defaultPadding,
        ),
        child: LayoutBuilder(builder: (context, constraints) {
          return AnimatedBuilder(
              animation: Listenable.merge([
                _animationController,
                _chargingPercentController,
              ]),
              builder: (context, _) {
                return Stack(
                  children: [
                    SizedBox(
                      height: constraints.maxHeight,
                      width: constraints.maxWidth,
                    ),
                    Positioned(
                      top: 25 * (1 - _greetingTextAnimation.value),
                      child: AnimatedOpacity(
                        duration: Duration.zero,
                        opacity: _greetingTextAnimation.value,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 80.0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: 'Hello ',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                                TextSpan(
                                  text: 'Jyani',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineSmall
                                      ?.copyWith(
                                        fontWeight: FontWeight.w800,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      top: constraints.maxHeight * 0.08,
                      child: Hero(
                        tag: '1',
                        child: ProfileWidget(
                          searchContainerColor: Colors.black,
                          duration: AppConsts.defaultDuration,
                          animationValue: _profilePictureAnimation.value,
                          constraints: constraints,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: const Duration(milliseconds: 300),
                      left: 0,
                      right: 0,
                      top: (constraints.maxHeight * 0.19) *
                          (1 - _teslaInfoContainerAnimation.value * 0.1),
                      child: AnimatedOpacity(
                        duration: Duration.zero,
                        opacity: _teslaInfoContainerAnimation.value,
                        child: PinkTeslaModelContainer(
                          constraints: constraints,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: constraints.maxHeight * 0.34,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: RichText(
                          text: TextSpan(
                            children: <TextSpan>[
                              TextSpan(
                                text: 'Charging ',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w800,
                                    ),
                              ),
                              TextSpan(
                                text: 'Stations',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: AppConsts.defaultDuration,
                      top: 100,
                      left: constraints.maxWidth *
                          1.7 *
                          (1 - _teslaForwardAnimation.value * 0.7),
                      width: constraints.maxWidth * 0.56,
                      height: constraints.maxHeight * 0.6,
                      child: RotatedTesla(
                        duration: AppConsts.defaultDuration,
                        constraints: constraints,
                        animationValue: _teslaForwardAnimation.value,
                      ),
                    ),
                    Positioned(
                      bottom: 20,
                      left: 0,
                      right: 0,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) =>
                                        const TeslaControlScreen(),
                                    transitionDuration:
                                        const Duration(seconds: 2),
                                    reverseTransitionDuration: Duration.zero,
                                  ),
                                );
                              },
                              child: Container(
                                width: constraints.maxWidth,
                                height: constraints.maxHeight * 0.3,
                                decoration: BoxDecoration(
                                  color: AppConsts.black,
                                  borderRadius: BorderRadius.circular(35),
                                ),
                                child: Stack(
                                  children: [
                                    Image.asset(
                                      AssetConsts.baseMap2,
                                      fit: BoxFit.cover,
                                    ),
                                    Positioned(
                                      left: 20,
                                      top: 20,
                                      child: Container(
                                        height: 36,
                                        width: 76,
                                        foregroundDecoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(47),
                                          border: Border.all(
                                            width: 2,
                                            color: const Color(0xFFD9D9D9)
                                                .withOpacity(0.2),
                                          ),
                                          gradient: LinearGradient(
                                            begin: Alignment.centerLeft,
                                            end: Alignment.centerRight,
                                            colors: [
                                              const Color(0xFFD9D9D9)
                                                  .withOpacity(0.25),
                                              const Color(0xFFD9D9D9)
                                                  .withOpacity(0.2),
                                            ],
                                          ),
                                        ),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(47),
                                          color: Colors.black,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '12 km',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge
                                                ?.copyWith(
                                                  color: Colors.white,
                                                ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      top: 30,
                                      right: 40,
                                      child: Text(
                                        'Nearest Station',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                              color: Colors.white,
                                            ),
                                      ),
                                    ),
                                    Positioned(
                                      left: 40,
                                      bottom: 60,
                                      child: Image.asset(
                                        AssetConsts.batteryCharge,
                                        height: 55,
                                        width: 48,
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          BatteryLevelWidget(
                            batteryLevel: _chargingPercentageAnimation.value,
                            constraints: constraints,
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              });
        }),
      ),
    );
  }
}
