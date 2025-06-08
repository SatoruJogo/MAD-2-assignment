import 'package:flutter/foundation.dart';
import 'package:battery_plus/battery_plus.dart';

class BatteryProvider with ChangeNotifier {
  final Battery _battery = Battery();
  int _batteryLevel = 100;

  int get batteryLevel => _batteryLevel;

  BatteryProvider() {
    _getBatteryLevel();
    _battery.onBatteryStateChanged.listen((_) => _getBatteryLevel());
  }

  Future<void> _getBatteryLevel() async {
    try {
      final level = await _battery.batteryLevel;
      _batteryLevel = level;
      notifyListeners();
    } catch (e) {
      if (kDebugMode) {
        print("Failed to get battery level: $e");
      }
    }
  }
}
