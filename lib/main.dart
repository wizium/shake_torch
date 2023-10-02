import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'screens/home.dart';
import 'services/ad_services.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import 'Functions/data_init.dart';
import 'Theme/dark_theme.dart';
import 'Theme/light_theme.dart';
import 'Functions/terminated_run.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dynamic_color/dynamic_color.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

buy() async {
  PurchaseParam purchaseParam = PurchaseParam(productDetails: products[0]);
  debugPrint(products[0].price);
  await inAppPurchase.buyConsumable(
    purchaseParam: purchaseParam,
  );
}

late StreamSubscription inAppPurchaseSubscription;
List<ProductDetails> products = [];
const Set<String> kProductIds = {
  "test_product",
};
late SharedPreferences sharedPreferences;
late InAppPurchase inAppPurchase;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await UnityAds.init(
    testMode: false,
    gameId: AdServices.appId,
    onComplete: () => debugPrint("Unity gameId is Initialized"),
    onFailed: (error, errorMessage) => debugPrint(errorMessage),
  );
  inAppPurchase = InAppPurchase.instance;
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
    initStore();
    dataInitialization();
    setState(() {});
    super.initState();
  }

  listenToPurchase(List<PurchaseDetails> purchaseDetails) async {
    for (var element in purchaseDetails) {
      if (element.status == PurchaseStatus.pending) {
        debugPrint("Purchase pending");
      } else if (element.status == PurchaseStatus.error) {
        debugPrint("Error Buying");
      } else if (element.status == PurchaseStatus.purchased) {
        debugPrint("purchased");
      }
    }
  }

  initStore() async {
    ProductDetailsResponse productDetailsResponse =
        await inAppPurchase.queryProductDetails(kProductIds);
    if (productDetailsResponse.error == null) {
      products = productDetailsResponse.productDetails;
    } else {
      debugPrint(productDetailsResponse.error.toString());
    }
    setState(() {});
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
