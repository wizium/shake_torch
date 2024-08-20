import 'dart:async';
import 'dart:io';
import 'package:feedback/feedback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import '/StateManagement/get_controller.dart';
import '/firebase_options.dart';
import '/screens/splash.dart';
import '/services/purchases.dart';
import 'Functions/data_init.dart';
import 'Functions/terminated_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

late StreamSubscription inAppPurchaseSubscription;
List<ProductDetails> products = [];
const Set<String> kProductIds = {"test_product", "life_time"};
IsPro isPro = Get.put(IsPro());
bool isLoaded = false;
late SharedPreferences sharedPreferences;
InAppPurchase inAppPurchase = InAppPurchase.instance;
Directory? tempPath;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await serviceInitializer();
  tempPath =await getApplicationDocumentsDirectory();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  sharedPreferences = await SharedPreferences.getInstance();
  runApp(const BetterFeedback(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    Stream purchaseUpdate = inAppPurchase.purchaseStream;
    inAppPurchaseSubscription = purchaseUpdate.listen(
      (event) {
        listenToPurchase(event);
      },
      onDone: () {
        inAppPurchaseSubscription.cancel();
      },
    );
    initStore(() {
      setState(() {});
    });
    dataInitialization();
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      themeMode: themeController.dark.value ? ThemeMode.dark : ThemeMode.light,
      theme: ThemeData(
        fontFamily: "Margarine",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFcc7c36),
          brightness: Brightness.light,
        ).copyWith(
          primary: const Color(0xFFcc7c36),
        ),
      ).copyWith(
        listTileTheme: ListTileThemeData(
          iconColor: ColorScheme.fromSeed(
            seedColor: const Color(0xFFcc7c36),
          ).inversePrimary,
        ),
        switchTheme: SwitchThemeData(
          trackColor: WidgetStatePropertyAll(
            ColorScheme.fromSeed(
              seedColor: const Color(0xFFcc7c36),
            ).inversePrimary,
          ),
          trackOutlineWidth: const WidgetStatePropertyAll(0),
          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
          thumbColor: WidgetStatePropertyAll(
            ColorScheme.fromSeed(seedColor: const Color(0xFFcc7c36)).primary,
          ),
          thumbIcon: const WidgetStatePropertyAll(
            Icon(
              Icons.abc,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      darkTheme: ThemeData(
        fontFamily: "Margarine",
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFcc7c36),
          brightness: Brightness.dark,
        ),
      ).copyWith(
        switchTheme: SwitchThemeData(
          trackColor: WidgetStatePropertyAll(
            ColorScheme.fromSeed(
              seedColor: const Color(0xFFcc7c36),
            ).inversePrimary,
          ),
          trackOutlineWidth: const WidgetStatePropertyAll(0),
          trackOutlineColor: const WidgetStatePropertyAll(Colors.transparent),
          thumbColor: WidgetStatePropertyAll(
            ColorScheme.fromSeed(seedColor: const Color(0xFFcc7c36)).primary,
          ),
          thumbIcon: const WidgetStatePropertyAll(
            Icon(
              Icons.abc,
              color: Colors.transparent,
            ),
          ),
        ),
      ),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
