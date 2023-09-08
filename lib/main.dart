import 'package:flutter/material.dart';
import 'Functions/aos12permission.dart';
import 'Functions/terminated_run.dart';
import 'screens/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

late double height;
late double width;
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
    askPermission();
    isBackgroundOn = sharedPreferences.getBool("isOn");
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return MaterialApp(
      title: "Shake torch",
      darkTheme: ThemeData(
        primarySwatch: Colors.amber,
        useMaterial3: true,
      ),
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFD3A2F6),
          primary: const Color(0xFFD3A2F6),
          surface: const Color(0xff6ADF16).withOpacity(.8),
          secondary: const Color(0xFFF9CCC7),
          background: const Color(0xffE8FBFD),
        ),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            fontFamily: "caveat",
            color: Colors.white,
            fontSize: 45,
          ),
        ),
        useMaterial3: true,
      ),
      home: const HomePage(),
    );
  }
}
