import 'package:flutter/material.dart';
import 'package:tesla_app/src/controllers/controllers.dart';
import 'package:tesla_app/src/ui/tesla_charging_screen.dart';
import 'package:tesla_app/src/ui/widgets/widgets.dart';
import 'package:tesla_app/src/utils/utils.dart';

class ChargeStationScreen extends StatefulWidget {
  const ChargeStationScreen({super.key});

  @override
  State<ChargeStationScreen> createState() => _ChargeStationScreenState();
}

class _ChargeStationScreenState extends State<ChargeStationScreen>
    with TickerProviderStateMixin {
  late ChargeStationController _chargeStationController;
  late AnimationController _swipeLeftController;
  late AnimationController _backgroundColorController;
  late AnimationController _teslaChargingController;

  late Animation<Offset> _swipeLeftAnimation;
  late Animation<Offset> _teslaChargingAnimation;
  late Animation<Offset> _teslaDetailsChargingShiftAnimation;
  late Animation<Offset> _radialWidgetAnimation;

  late Animation<Color?> _backgroundColorAnimation;
  late Animation<Offset> _batteryInfoAnimation;

  bool teslaShited = false;

  @override
  void initState() {
    super.initState();
    _chargeStationController = ChargeStationController();
    _swipeLeftController =
        AnimationController(vsync: this, duration: AppConsts.defaultDuration);
    _backgroundColorController = AnimationController(
      vsync: this,
      duration: AppConsts.defaultDuration,
    );

    _teslaChargingController = AnimationController(
      vsync: this,
      duration: AppConsts.defaultDuration,
    );

    _swipeLeftAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.5, 0),
    ).animate(_swipeLeftController);

    _teslaChargingAnimation =
        Tween<Offset>(begin: const Offset(0.5, 0), end: const Offset(0, -0.35))
            .animate(_teslaChargingController);

    _teslaDetailsChargingShiftAnimation =
        Tween<Offset>(begin: const Offset(0, 0), end: const Offset(-1.5, 0))
            .animate(_teslaChargingController);

    _radialWidgetAnimation =
        Tween<Offset>(begin: Offset.zero, end: const Offset(0.5, 0))
            .animate(_swipeLeftController);

    _batteryInfoAnimation =
        Tween<Offset>(begin: const Offset(-1.5, 0), end: const Offset(0.1, 0))
            .animate(_swipeLeftController);

    _backgroundColorAnimation = ColorTween(
      begin: AppConsts.scaffoldDarkColor,
      end: const Color(0xFFF6F6F6),
    ).animate(_backgroundColorController);
    _swipeLeftController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _backgroundColorController.forward();
      } else if (status == AnimationStatus.reverse) {
        _backgroundColorController.reverse();
      }
    });
  }

  @override
  void dispose() {
    _swipeLeftController.dispose();
    _backgroundColorController.dispose();
    _chargeStationController.dispose();
    _teslaChargingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: Listenable.merge(
          [
            _chargeStationController,
            _swipeLeftController,
            _backgroundColorController,
            _teslaChargingController,
          ],
        ),
        builder: (context, _) {
          return LayoutBuilder(builder: (context, constraints) {
            bool isTelsaCharging = _chargeStationController.isStartCharging;
            print('IS TESLA CHARGING===> $isTelsaCharging');
            return GestureDetector(
              onHorizontalDragUpdate: _onHorizontalDragUpdate,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  AnimatedContainer(
                    duration: Duration.zero,
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                    decoration: BoxDecoration(
                      color: _backgroundColorAnimation.value,
                    ),
                  ),
                  Positioned(
                    top: 37,
                    right: 60,
                    child: ProfileWidget(
                      duration: Duration.zero,
                      constraints: constraints,
                      searchContainerColor: Colors.white,
                    ),
                  ),
                  ModelTitleWidget(
                    teslaShited: teslaShited,
                    teslaDetailsChargingShiftAnimation:
                        _teslaDetailsChargingShiftAnimation,
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.18,
                    child: AnimatedScale(
                      duration: AppConsts.defaultDuration,
                      scale: teslaShited ? 0.5 : 1.0,
                      child: SlideTransition(
                        position: isTelsaCharging
                            ? Tween<Offset>(
                                    begin: const Offset(0.5, 0),
                                    end: Offset.zero)
                                .animate(_swipeLeftController)
                            : Tween<Offset>(
                                    begin: Offset.zero,
                                    end: const Offset(0.5, 0))
                                .animate(_swipeLeftController),

                        //    _radialWidgetAnimation,
                        child: ChargingStationRadialWidget(
                          constraints: constraints,
                          isCharging: isTelsaCharging,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    child: AnimatedScale(
                      alignment: Alignment.center,
                      duration: AppConsts.defaultDuration,
                      scale: teslaShited ? 1.26 : 1.0,
                      child: SlideTransition(
                        position: isTelsaCharging
                            ? _teslaChargingAnimation
                            : _swipeLeftAnimation,
                        child: Image.asset(
                          AssetConsts.tesla2,
                          height: constraints.maxHeight * 0.6,
                          width: constraints.maxWidth * 0.6,
                          fit: BoxFit.fill,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.3,
                    left: constraints.maxWidth * 0.2,
                    child: AnimatedOpacity(
                      duration: Duration.zero,
                      opacity: teslaShited ? 0.0 : 1.0,
                      child: const TeslaIssueWarningWidget(),
                    ),
                  ),
                  Positioned(
                    bottom: constraints.maxHeight * 0.28,
                    right: constraints.maxWidth * 0.2,
                    child: AnimatedOpacity(
                      duration: Duration.zero,
                      opacity: teslaShited ? 0.0 : 1.0,
                      child: const TeslaIssueWarningWidget(),
                    ),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.14,
                    left: 20,
                    child: TeslaChargingInfo(
                      teslaDetailsChargingShiftAnimation:
                          _teslaDetailsChargingShiftAnimation,
                      batteryInfoAnimation: _batteryInfoAnimation,
                      constraints: constraints,
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.easeInOut,
                    duration: AppConsts.defaultDuration,
                    left: 20,
                    right: 20,
                    bottom: teslaShited ? -100 : 25,
                    child: MaintenanceWidet(
                      constraints: constraints,
                    ),
                  ),
                  AnimatedPositioned(
                    curve: Curves.easeOut,
                    duration: AppConsts.defaultDuration,
                    left: 20,
                    right: 20,
                    bottom: teslaShited ? 25 : -100,
                    child: StartChargingWidget(
                      constraints: constraints,
                      onTap: () {
                        _chargeStationController.startChargingTesla();
                        _teslaChargingController.forward();
                        _backgroundColorController.reverse(from: 0.7);
                        // setState(() {
                        //   teslaShited = false;
                        // });
                      },
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 60,
                    child: AnimatedOpacity(
                      duration: AppConsts.defaultDuration,
                      opacity: teslaShited ? 0.0 : 1.0,
                      child: GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Image.asset(
                          AssetConsts.arrowBack,
                          height: 20,
                          width: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          });
        },
      ),
    );
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (details.delta.dx > 0) {
      _swipeLeftController.forward();
      setState(() {
        teslaShited = true;
      });
    }
    if (details.delta.dx < 1) {
      _swipeLeftController.reverse();
      setState(() {
        teslaShited = false;
      });
    }
  }
}

class TeslaChargingInfo extends StatelessWidget {
  const TeslaChargingInfo({
    super.key,
    required Animation<Offset> teslaDetailsChargingShiftAnimation,
    required Animation<Offset> batteryInfoAnimation,
    required this.constraints,
  })  : _teslaDetailsChargingShiftAnimation =
            teslaDetailsChargingShiftAnimation,
        _batteryInfoAnimation = batteryInfoAnimation;

  final Animation<Offset> _teslaDetailsChargingShiftAnimation;
  final Animation<Offset> _batteryInfoAnimation;
  final BoxConstraints constraints;

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _teslaDetailsChargingShiftAnimation,
      child: SlideTransition(
        position: _batteryInfoAnimation,
        child: Column(
          children: [
            BatteryLevelWidget(
              batteryLevel: 60,
              borderRadius: 55,
              constraints: constraints,
              batteryLevelHeight: constraints.maxHeight * 0.22,
              height: constraints.maxHeight * 0.4,
              width: constraints.maxHeight * 0.17,
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: constraints.maxHeight * 0.27,
              width: constraints.maxHeight * 0.17,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(45),
                color: AppConsts.lightBlue,
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Positioned(
                    top: 30,
                    child: Column(
                      children: [
                        Text(
                          'CHAdeMo',
                          style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                          ),
                        ),
                        SizedBox(
                          height: 15,
                        ),
                        Text(
                          '\$3.60/kWt',
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Image.asset(
                      AssetConsts.exhaust,
                      height: constraints.maxHeight * 0.16,
                      width: constraints.maxHeight * 0.17,
                      fit: BoxFit.fill,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ModelTitleWidget extends StatefulWidget {
  const ModelTitleWidget({
    super.key,
    required this.teslaShited,
    required Animation<Offset> teslaDetailsChargingShiftAnimation,
  }) : _teslaDetailsChargingShiftAnimation = teslaDetailsChargingShiftAnimation;

  final bool teslaShited;
  final Animation<Offset> _teslaDetailsChargingShiftAnimation;

  @override
  State<ModelTitleWidget> createState() => _ModelTitleWidgetState();
}

class _ModelTitleWidgetState extends State<ModelTitleWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: AppConsts.defaultDuration,
      top: 37,
      left: widget.teslaShited ? 30 : 70,
      child: SlideTransition(
        position: widget._teslaDetailsChargingShiftAnimation,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AnimatedDefaultTextStyle(
              duration: AppConsts.defaultDuration,
              style: Theme.of(context).textTheme.headlineMedium!.copyWith(
                    fontSize: 26,
                    color: widget.teslaShited ? Colors.black : Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
              child: const Text(
                'Model 2.0 ',
              ),
            ),
            AnimatedDefaultTextStyle(
              duration: AppConsts.defaultDuration,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: widget.teslaShited ? Colors.grey : AppConsts.grey,
                    fontWeight: FontWeight.w600,
                  ),
              child: const Text(
                'Dura chasis',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
