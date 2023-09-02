import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shake_torch/screens/home.dart';
import 'package:torch_controller/torch_controller.dart';

TorchController torchController = TorchController();
Timer? timer;
void toggleSos(bool isSosOn, {required VoidCallback callbackIntent}) {
  torchController.initialize();
  if (isSosOn) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) async {
      await torchController.toggle();
      isTorchOn = !isTorchOn;
      callbackIntent();
    });
  } else {
    timer!.cancel();
  }
}
