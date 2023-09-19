// ignore_for_file: depend_on_referenced_packages

import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart'
    show AndroidServiceInstance;
import '/Functions/sos.dart';
import 'package:shake/shake.dart';

double? sosDelay;
double? threshold;
ShakeDetector? shake;
FlutterBackgroundService flutterBackgroundService = FlutterBackgroundService();
@pragma("vm:entry-point")
Future<void> onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on("terminate").listen((event) async {
      if (shake != null) {
        shake!.stopListening();
      }
      await service.stopSelf();
    });
    service.on("start").listen((event) async {
      event!["background"] == true
          ? await service.setAsBackgroundService()
          : await service.setAsForegroundService();
      await service.setAutoStartOnBootMode(event["auto"]);

      shake = ShakeDetector.waitForStart(
        onPhoneShake: () async {
          torchController.initialize();
          await torchController.toggle();
          service
              .invoke("toggled", {"on": await torchController.isTorchActive});
        },
        shakeThresholdGravity: event["threshold"],
      );

      debugPrint("${event["threshold"]}\n");
      shake!.startListening();
    });
    service.on("save").listen((event) async {
      if (shake != null) {
        shake!.stopListening();
      }
      event!["background"] == true
          ? await service.setAsBackgroundService()
          : await service.setAsForegroundService();
      await service.setAutoStartOnBootMode(event["auto"]);

      shake = ShakeDetector.waitForStart(
        onPhoneShake: () async {
          torchController.initialize();
          await torchController.toggle();
          service
              .invoke("toggled", {"on": await torchController.isTorchActive});
        },
        shakeThresholdGravity: event["threshold"],
      );
      debugPrint("${event["threshold"]}\n");
      shake!.startListening();
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
      autoStartOnBoot: false,
      initialNotificationContent: "Detecting Shake...",
      initialNotificationTitle: "Shake to Torch",
      isForegroundMode: true,
    ),
  );
}
