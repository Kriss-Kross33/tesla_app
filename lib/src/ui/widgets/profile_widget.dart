import 'package:flutter/material.dart';
import 'package:tesla_app/src/utils/utils.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({
    super.key,
    required this.duration,
    required this.constraints,
    this.animationValue,
    this.searchContainerColor,
  });

  final Duration duration;
  final BoxConstraints constraints;
  final double? animationValue;
  final Color? searchContainerColor;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 110,
      height: 51,
      child: Stack(
        children: [
          Positioned(
            right: 0,
            child: Container(
              height: 50.42,
              width: 53.58,
              decoration: BoxDecoration(
                color: searchContainerColor ?? AppConsts.black,
                borderRadius: BorderRadius.circular(20.23),
              ),
              child: Center(
                child: Image.asset(
                  AssetConsts.search,
                  color: searchContainerColor == Colors.black
                      ? Colors.white
                      : Colors.black,
                  height: 15.22,
                  width: 14.56,
                ),
              ),
            ),
          ),
          AnimatedPositioned(
            duration: duration,
            right: animationValue == null
                ? constraints.maxWidth * 0.1
                : constraints.maxWidth * 0.1 * animationValue!,
            child: Image.asset(
              AssetConsts.profilePic,
              height: 50.42,
              width: 53.58,
              fit: BoxFit.fill,
            ),
          ),
        ],
      ),
    );
  }
}
