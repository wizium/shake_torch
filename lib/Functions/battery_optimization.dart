import 'package:permission_handler/permission_handler.dart';

checkBatteryOptimization() async {
  PermissionStatus status =
      await Permission.ignoreBatteryOptimizations.request();

  if (!status.isGranted) {
    Permission.ignoreBatteryOptimizations.request();
  }
}
