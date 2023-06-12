import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tesla_app/src/tesla_app.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom]);
  // binding.addPostFrameCallback((_) {
  //   final context = binding.rootElement;
  //   for (var asset in AssetConsts.allAssets()) {
  //     precacheImage(AssetImage(asset), context);
  //   }
  // });
  runApp(const TeslaApp());
}
