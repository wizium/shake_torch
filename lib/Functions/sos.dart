import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shake_torch/Functions/terminated_run.dart';
import 'package:shake_torch/screens/home.dart';
import 'package:torch_controller/torch_controller.dart';

TorchController torchController = TorchController();
Timer? timer;
void toggleSos(bool isSosOn, {required VoidCallback callbackIntent}) {
  torchController.initialize();
  if (isSosOn) {
    timer = Timer.periodic(
        Duration(
          milliseconds: (sosDelay!*1000).toInt(),
        ), (timer) async {
      await torchController.toggle();
      isTorchOn = await torchController.isTorchActive;
      callbackIntent();
    });
  } else {
    timer!.cancel();
  }
}
