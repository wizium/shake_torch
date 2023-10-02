import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

checkBatteryOptimization(context) async {
  Permission permission = Permission.ignoreBatteryOptimizations;
  PermissionStatus status = await permission.request();
  if (status.isGranted || status.isProvisional || status.isLimited) {
    debugPrint("Battery optimization is disabled");
  } else {
    debugPrint("Battery optimization is enabled");
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text(
          """To ensure smooth performance, we recommend disabling battery optimization for this app.
          Press open settings> Select Battery then Select Unrestricted or Don't optimize
          """,
        ),
        actions: [
          TextButton(
            onPressed: () async {
              await openAppSettings();
            },
            child: const Text("Open Settings"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
        ],
      ),
    );
  }
}
