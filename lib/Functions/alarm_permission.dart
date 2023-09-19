import 'dart:io';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

Permission permission = Permission.scheduleExactAlarm;
Future alarmPermission(context) async {
  if (Platform.isAndroid) {
    AndroidDeviceInfo deviceInfo = await DeviceInfoPlugin().androidInfo;
    if (int.parse(deviceInfo.version.release) > 11) {
      PermissionStatus status = await permission.request();
      if (!status.isGranted) {
        await permission.request();
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: const Text(
                """Shake Torch requires Alarm permissions to work optimally.
1. Tap Goto settings.
2. Scroll down and select Alarm & Reminders.
3. Toggle on Alarm and Reminders.
By enabling these permissions, you'll enjoy the full functionality of our app.
""",
              ),
              actions: [
                TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    await openAppSettings();
                  },
                  child: const Text("Goto Settings"),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"),
                ),
              ],
            );
          },
        );
      } else {
        debugPrint("Alarm Permission Granted");
      }
    }
  }
}
