import 'package:flutter/material.dart';
import 'package:shake_torch/Functions/notification_permission.dart';
import 'package:shake_torch/Theme/dark_theme.dart';
import 'package:shake_torch/Theme/light_theme.dart';
import 'Functions/alarm_permission.dart';
import 'Functions/terminated_run.dart';
import 'screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_color/dynamic_color.dart';

late SharedPreferences sharedPreferences;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
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
    super.initState();
    alarmPermission();
    notificationPermission();
    isBackgroundOn = sharedPreferences.getBool("isOn");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          title: "Shake torch",
          theme: lightTheme(lightDynamic),
          darkTheme: darkTheme(darkDynamic),
          home: const HomePage(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
