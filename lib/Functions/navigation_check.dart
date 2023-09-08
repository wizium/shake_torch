import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:shake_torch/main.dart';

Future<double> checkNavigation(context) async {
  final devicePixelRatio = MediaQuery.of(context).devicePixelRatio;
  final screenHeight = MediaQuery.of(context).size.height;

  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  final AndroidDeviceInfo androidInfo = await deviceInfoPlugin.androidInfo;
  final deviceHeight = androidInfo.displayMetrics.heightPx;

  final androidNavHeight = deviceHeight / devicePixelRatio - screenHeight;
  return deviceHeight - androidNavHeight;
}

void heightGetter(context, Function voidCallback) async {
  height = await checkNavigation(context);
}
