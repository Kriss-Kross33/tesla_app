import 'package:flutter/material.dart';

class ChargeStationController extends ChangeNotifier {
  bool isStartCharging = false;
  void startChargingTesla() {
    isStartCharging = true;
    notifyListeners();
  }

  void stopChargingTesla() {
    isStartCharging = false;
    notifyListeners();
  }
}
