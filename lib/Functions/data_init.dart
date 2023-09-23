import 'package:get/instance_manager.dart';
import '/Functions/sos.dart';
import '/Functions/terminated_run.dart';
import '/StateManagement/get_controller.dart';
import '/main.dart';
import '/screens/home.dart';
import '/screens/settings.dart';

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
