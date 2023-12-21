import 'dart:async';
import 'package:feedback/feedback.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '/StateManagement/get_controller.dart';
import '/firebase_options.dart';
import '/screens/splash.dart';
import '/services/purchases.dart';
import 'Functions/data_init.dart';
import 'Theme/dark_theme.dart';
import 'Theme/light_theme.dart';
import 'Functions/terminated_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

late StreamSubscription inAppPurchaseSubscription;
List<ProductDetails> products = [];
const Set<String> kProductIds = {"test_product", "life_time"};
IsPro isPro = Get.put(IsPro());
bool isLoaded = false;
late SharedPreferences sharedPreferences;
InAppPurchase inAppPurchase = InAppPurchase.instance;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await serviceInitializer();
  sharedPreferences = await SharedPreferences.getInstance();

  runApp(
    const BetterFeedback(
      child: MyApp(),
    ),
  );
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
      onError: (e) {
        debugPrint(
          "Purchase stream got error $e",
        );
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
    return DynamicColorBuilder(
      builder: (lightDynamic, darkDynamic) {
        return GetMaterialApp(
          themeMode:
              themeController.dark.value ? ThemeMode.dark : ThemeMode.light,
          title: "Shake torch(FlashLight)",
          theme: lightTheme(lightDynamic, context),
          darkTheme: darkTheme(darkDynamic, context),
          home: const SplashScreen(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}
