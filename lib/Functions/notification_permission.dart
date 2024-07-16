import 'package:permission_handler/permission_handler.dart';

notificationPermission() async {
  Permission notificationPermission = Permission.notification;
  final status = await notificationPermission.request();
  if (!status.isGranted) {
    await notificationPermission.request();
  }
}
