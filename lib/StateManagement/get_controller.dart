import 'package:get/get.dart';
import '/main.dart';

class ThemeController extends GetxController {
  RxBool dark = false.obs;
  changeTheme() {
    dark.value = !dark.value;
  }

  init() {
    dark.value = sharedPreferences.getBool("dark") ?? false;
  }
}

class IsPro extends GetxController {
  RxBool isPro = false.obs;
  init() {
    isPro.value = sharedPreferences.getBool("isPro") ?? false;
  }
}
