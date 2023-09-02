import 'dart:io';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

Permission permission = Permission.scheduleExactAlarm;
Future askPermission() async {
  if (Platform.isAndroid) {
    AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
    if (int.parse(deviceInfo.version.release) >= 12) {
      PermissionStatus status = await permission.request();
      if (!status.isGranted) {
        await openAppSettings();
      }
    }
  }
}
