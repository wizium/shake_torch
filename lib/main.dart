import 'package:flutter/material.dart';
import 'Functions/aos12permission.dart';
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
    askPermission();
    isBackgroundOn = sharedPreferences.getBool("isOn");
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return MaterialApp(
          title: "Shake torch",
          theme: ThemeData(
            colorScheme: lightDynamic,
            useMaterial3: true,
          ),
          home: const HomePage(),
        );
      },
    );
  }
}

Future<Color?> dynamicColor() async {
  return await DynamicColorPlugin.getAccentColor();
}
