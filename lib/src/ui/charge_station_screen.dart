import 'package:flutter/material.dart';
import 'package:tesla_app/src/ui/widgets/widgets.dart';
import 'package:tesla_app/src/utils/utils.dart';

class ChargeStationScreen extends StatefulWidget {
  const ChargeStationScreen({super.key});

  @override
  State<ChargeStationScreen> createState() => _ChargeStationScreenState();
}

class _ChargeStationScreenState extends State<ChargeStationScreen>
    with TickerProviderStateMixin {
  late AnimationController _swipeLeftController;
  late Animation<double> _mildIssuesAnimation;
  late Animation<double> _startChargingAnimation;

  @override
  void initState() {
    super.initState();
    _swipeLeftController = AnimationController(
      vsync: this,
      duration: const Duration(
        milliseconds: 300,
      ),
    );
    _mildIssuesAnimation = Tween
  }

  @override
  void dispose() {
    _swipeLeftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConsts.scaffoldDarkColor,
      body: AnimatedBuilder(
          animation: Listenable.merge(_swipeLeftController),
          builder: (context, _) {
            return LayoutBuilder(builder: (context, constraints) {
              return Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: constraints.maxHeight,
                    width: constraints.maxWidth,
                  ),
                  Positioned(
                    top: 50,
                    right: 30,
                    child: ProfileWidget(
                      duration: Duration.zero,
                      constraints: constraints,
                      searchContainerColor: Colors.white,
                    ),
                  ),
                  const Positioned(
                    top: 50,
                    left: 70,
                    child: ModelWidget(),
                  ),
                  Positioned(
                    top: constraints.maxHeight * 0.17,
                    child: RadialWidget(
                      constraints: constraints,
                    ),
                  ),
                  Image.asset(
                    AssetConsts.tesla2,
                    height: constraints.maxHeight * 0.55,
                    width: constraints.maxWidth * 0.55,
                    fit: BoxFit.fill,
                  ),
                  Positioned(
                    left: 20,
                    right: 20,
                    bottom: 30,
                    child: MaintenanceWidet(
                      constraints: constraints,
                    ),
                  ),
                  Positioned(
                    left: 30,
                    top: 70,
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Image.asset(
                        AssetConsts.arrowBack,
                        height: 20,
                        width: 20,
                      ),
                    ),
                  ),
                ],
              );
            });
          }),
    );
  }
}
