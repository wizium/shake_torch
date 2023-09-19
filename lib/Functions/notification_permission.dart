import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

notificationPermission(context) async {
  Permission notificationPermission = Permission.notification;
  final status = await notificationPermission.request();
  if (!status.isGranted) {
    await notificationPermission.request();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text(
            """In for app to work properly please allow notification permission in settings
            Press open settings> Select Notifications then Toggle on the notifications permission""",
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
    debugPrint("Notification Permission Granted");
  }
}
