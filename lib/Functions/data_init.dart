import 'package:get/instance_manager.dart';
import 'package:shake_torch/Functions/sos.dart';
import 'package:shake_torch/Functions/terminated_run.dart';
import 'package:shake_torch/StateManagement/get_controller.dart';
import 'package:shake_torch/main.dart';
import 'package:shake_torch/screens/home.dart';
import 'package:shake_torch/screens/settings.dart';

ThemeController themeController = Get.put(ThemeController());
void dataInitialization() async {
  isBackgroundOn = await flutterBackgroundService.isRunning();
  background = sharedPreferences.getBool("background") ?? false;
  threshold = sharedPreferences.getDouble("threshold") ?? 3.1;
  auto = sharedPreferences.getBool("auto") ?? false;
  themeController.init();
  sosDelay = sharedPreferences.getDouble("sosDelay") ?? 1.0;
  isTorchOn = await torchController.isTorchActive;
}
