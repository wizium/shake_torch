// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';

import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart'
    show AndroidServiceInstance;
import 'package:shake_torch/Functions/sos.dart';
// import 'package:torch_light/torch_light.dart';
import 'package:shake/shake.dart';

import '/screens/home.dart';

ShakeDetector shake = ShakeDetector.waitForStart(
  onPhoneShake: () async {
    torchController.initialize();
    await torchController.toggle();
    isTorchOn = !isTorchOn;
  },
  shakeThresholdGravity: 3.2,
);
FlutterBackgroundService flutterBackgroundService = FlutterBackgroundService();
@pragma("vm:entry-point")
Future<void> onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on("terminate").listen((event) async {
      shake.stopListening();
      await service.stopSelf();
    });
    service.on("start").listen((event) async {
      shake.startListening();
    });
  }
}

Future<void> serviceInitializer() async {
  DartPluginRegistrant.ensureInitialized();
  await flutterBackgroundService.configure(
    iosConfiguration: IosConfiguration(),
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: false,
      autoStartOnBoot: true,
      initialNotificationContent: "Detecting Shake...",
      initialNotificationTitle: "Shake to Torch",
      isForegroundMode: true,
    ),
  );
}
