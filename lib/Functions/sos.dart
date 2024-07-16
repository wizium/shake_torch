import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '/Functions/terminated_run.dart';
import '/screens/home.dart';
import 'package:torch_controller/torch_controller.dart';

import 'haptic.dart';

TorchController torchController = TorchController();
Timer? timer;
void toggleSos(bool isSosOn, {required VoidCallback callbackIntent}) {
  torchController.initialize();
  if (isSosOn) {
    timer = Timer.periodic(
        Duration(
          milliseconds: (sosDelay! * 1000).toInt(),
        ), (timer) async {
      await torchController.toggle();
      isTorchOn = await torchController.isTorchActive;
      callbackIntent();
      Haptic.vibrate();
    });
  } else {
    timer!.cancel();
  }
}
