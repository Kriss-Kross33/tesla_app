import 'package:flutter/material.dart';
import 'package:tesla_app/src/ui/ui.dart';

class TeslaApp extends StatelessWidget {
  const TeslaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'PlusJakartaSans'),
      home: const HomeScreen(),
    );
  }
}
