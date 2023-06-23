import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

class NearestStationScreen extends StatelessWidget {
  const NearestStationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return Stack(
          children: [
            Image.asset(
              AssetConsts.baseMapLg,
              fit: BoxFit.fitHeight,
              width: constraints.maxHeight,
              height: constraints.maxHeight,
            ),
            Positioned(
              top: 55,
              right: 40,
              child: Image.asset(
                AssetConsts.profilePic,
                height: 50.42,
                width: 53.58,
              ),
            ),
            Positioned(
              top: 55,
              left: 20,
              child: Container(
                padding: const EdgeInsets.only(
                  left: 20,
                ),
                height: 55,
                width: constraints.maxWidth * 0.68,
                decoration: BoxDecoration(
                  color: AppConsts.onyx,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Image.asset(
                      AssetConsts.search,
                      color: Colors.white,
                      height: 20,
                      width: 20,
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    const Text(
                      'Search...',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              bottom: constraints.maxHeight * 0.36,
              left: constraints.maxWidth * 0.385,
              child: Image.asset(
                AssetConsts.batteryCharge,
                height: 70,
                width: 60,
                fit: BoxFit.fill,
              ),
            ),
            Positioned(
              bottom: 30,
              left: 30,
              right: 30,
              child: Container(
                padding: const EdgeInsets.only(
                  top: 30,
                  right: 30,
                  left: 30,
                ),
                height: constraints.maxHeight * 0.3,
                width: constraints.maxWidth,
                decoration: BoxDecoration(
                  color: AppConsts.onyx,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Text(
                          'Nearest Station',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.grey,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 38,
                          width: 75,
                          decoration: BoxDecoration(
                            color: AppConsts.lightBlue,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: Text(
                              '12 km',
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    ChargingInfo(
                      icon: Image.asset(
                        AssetConsts.location,
                        height: 20,
                        width: 16,
                        fit: BoxFit.fill,
                      ),
                      location: '7622 Highway 9 Felton, CA',
                      powerInfo: '90% energy left on station',
                    ),
                    const Padding(
                      padding: EdgeInsets.only(left: 30),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: SizedBox(
                          height: 20,
                          width: 1,
                          child: VerticalDottedWidget(),
                        ),
                      ),
                    ),
                    ChargingInfo(
                      icon: Image.asset(
                        AssetConsts.location2,
                        height: 16,
                        width: 16,
                        fit: BoxFit.fill,
                      ),
                      location: '878 Minauo Heights',
                      powerInfo: '60% energy left on car',
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}

class ChargingInfo extends StatelessWidget {
  const ChargingInfo({
    super.key,
    required this.icon,
    required this.location,
    required this.powerInfo,
  });

  final Widget icon;
  final String location;
  final String powerInfo;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 60,
          width: 60,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: AppConsts.black,
          ),
          child: Center(
            child: icon,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Column(
          children: [
            Text(
              location,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                  ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              powerInfo,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.grey,
                  ),
            ),
          ],
        )
      ],
    );
  }
}

class VerticalDottedWidget extends StatelessWidget {
  const VerticalDottedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: VerticalDashPainter(),
    );
  }
}

class VerticalDashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    double dashHeight = 3, dashSpace = 3, startX = 0;
    final paint = Paint()
      ..isAntiAlias = true
      ..strokeWidth = 1
      ..color = Colors.grey;
    while (startX < size.height) {
      canvas.drawLine(Offset(0, startX), Offset(0, startX + dashHeight), paint);
      startX += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(VerticalDashPainter oldDelegate) => false;
}
