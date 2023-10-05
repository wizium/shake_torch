import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shake_torch/Functions/login.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(const Duration(seconds: 2), () async {
      await signInCheck();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
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
                  "assets/screenGlow.png",
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
