import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shake_torch/Functions/subscription_check.dart';
import 'package:shake_torch/services/ad_services.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '/main.dart';
import '/screens/home.dart';
import '/Functions/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    UnityAds.init(
      testMode: false,
      gameId: AdServices.appId,
      onComplete: () => debugPrint("Unity gameId is Initialized"),
      onFailed: (error, errorMessage) => debugPrint(errorMessage),
    );
    Timer(const Duration(seconds: 2), () async {
      try {
        final Timestamp endDate = Timestamp.fromDate(
          DateTime.parse(
            sharedPreferences.getString("endDate")!,
          ),
        );
        debugPrint(endDate.toDate().toString());
        subscriptionCheck(endDate);
      } catch (e) {
        debugPrint(e.toString());
        sharedPreferences.setBool("isPro", false);
      }
      final isFirstTime = sharedPreferences.getBool("isFirstTime");
      if (isFirstTime == null) {
        await sharedPreferences.setBool("isFirstTime", false);
        signInCheck();
      } else {
        Get.offAll(
          () => const HomePage(),
        );
      }
    });
    AdServices().interstitialAdLoad();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: Get.width * .05,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .15,
              ),
              child: Center(
                child: Image.asset(
                  "assets/AppIcon.png",
                  height: Get.height * .35,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                vertical: Get.height * .1,
              ),
              child: Text(
                "Welcome To shake Torch",
                style: Theme.of(context).textTheme.headlineLarge!.merge(
                      TextStyle(
                        color: Theme.of(context).colorScheme.surface,
                      ),
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
