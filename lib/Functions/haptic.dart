import 'package:flutter/services.dart';
import '../screens/settings.dart';

class Haptic {
  static vibrate() async {
    if (isHapticOn) {
      HapticFeedback.lightImpact();
    }
  }
}
