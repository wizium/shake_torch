import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_arc_text/flutter_arc_text.dart';
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

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ],
    );
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _controller.forward();

    UnityAds.init(
      testMode: false,
      gameId: AdServices.appId,
    );

    Timer(const Duration(seconds: 3), () async {
      try {
        final Timestamp endDate = Timestamp.fromDate(
          DateTime.parse(
            sharedPreferences.getString("endDate")!,
          ),
        );
        subscriptionCheck(endDate);
      } catch (e) {
        sharedPreferences.setBool("isPro", false);
      }
      final isFirstTime = sharedPreferences.getBool("isFirstTime");
      if (isFirstTime == null) {
        await sharedPreferences.setBool("isFirstTime", false);
        signInCheck();
      } else {
        Get.offAll(() => const HomePage());
      }
    });

    AdServices().interstitialAdLoad();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: Get.height * .15,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Center(
                child: ScaleTransition(
                  scale: _animation,
                  child: CircleAvatar(
                    radius: 130,
                    backgroundColor: Theme.of(context)
                        .colorScheme
                        .inversePrimary
                        .withOpacity(.3),
                    child: CircleAvatar(
                      backgroundColor: Theme.of(context)
                          .colorScheme
                          .inversePrimary
                          .withOpacity(.5),
                      radius: 120,
                      child: CircleAvatar(
                        radius: 110,
                        backgroundColor:
                            Theme.of(context).colorScheme.inversePrimary,
                        child: CircleAvatar(
                          backgroundColor: Colors.transparent,
                          backgroundImage: const Image(
                            image: AssetImage(
                              "assets/icon.png",
                            ),
                          ).image,
                          radius: 100,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              FadeTransition(
                opacity: _animation,
                child: ArcText(
                  radius: 140,
                  startAngle: 5.4,
                  text: "Welcome to Shake torch",
                  textStyle: Theme.of(context).textTheme.headlineSmall!.merge(
                        TextStyle(
                          color: Theme.of(context).colorScheme.surface,
                        ),
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
