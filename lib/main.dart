import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shake_torch/services/ad_services.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'Functions/data_init.dart';
import 'Theme/dark_theme.dart';
import 'Theme/light_theme.dart';
import 'Functions/terminated_run.dart';
import 'screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_color/dynamic_color.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UnityAds.init(
    testMode: false,
    gameId: AdServices.appId,
    onComplete: () => debugPrint("Unity gameId is Initialized"),
    onFailed: (error, errorMessage) => debugPrint(errorMessage),
  );
  await serviceInitializer();
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    dataInitialization();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return GetMaterialApp(
          themeMode:
              themeController.dark.value ? ThemeMode.dark : ThemeMode.light,
          title: "Shake torch(FlashLight)",
          theme: lightTheme(lightDynamic, context),
          darkTheme: darkTheme(darkDynamic, context),
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
