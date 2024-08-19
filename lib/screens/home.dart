import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shake_torch/main.dart';
import '../Functions/haptic.dart';
import '../widgets/custom_icon_button.dart';
import '/services/ad_services.dart';
import '/widgets/Home_Drawer.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '/Functions/alarm_permission.dart';
import '/Functions/battery_optimization.dart';
import '/Functions/notification_permission.dart';
import '/Functions/sos.dart';
import '/Functions/terminated_run.dart';
import 'screen_torch.dart';
import 'settings.dart';

bool isBackgroundOn = false;
bool isSosOn = false;
bool? isTorchOn = false;

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    flutterBackgroundService.on("toggled").listen((event) async {
      isTorchOn = event?["on"];
      setState(() {});
    });

    alarmPermission().then((value) {
      checkBatteryOptimization().then((value) {
        notificationPermission();
      });
    });

    if (!isLoaded) {
      AdServices().interstitialAdLoad();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (isLoaded) {
          await AdServices().showInterstitialAd(() {
            SystemNavigator.pop();
          });
        } else {
          SystemNavigator.pop();
        }
        return false;
      },
      child: Scaffold(
        key: scaffoldKey,
        drawer: const HomeDrawer(),
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.menu_rounded),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          centerTitle: true,
          title: const Text("Shake torch"),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(10),
          child: GridView.count(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            crossAxisCount: 2,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            children: [
              CustomIconButton(
                isActive: isBackgroundOn,
                onPressed: () async {
                  isBackgroundOn = !isBackgroundOn;
                  setState(() {});
                  if (!isBackgroundOn) {
                    flutterBackgroundService.invoke("terminate");
                  } else {
                    try {
                      await flutterBackgroundService.startService();
                      flutterBackgroundService.invoke("start", {
                        "threshold": threshold!,
                        "background": background,
                        "auto": auto
                      });
                    } catch (e) {
                      alarmPermission()
                          .then((value) => notificationPermission());
                    }
                  }
                },
                assetPath: "assets/shake.png",
              ),
              CustomIconButton(
                isActive: isTorchOn ?? false,
                onPressed: () async {
                  torchController.initialize();
                  await torchController.toggle();
                  isTorchOn = await torchController.isTorchActive;
                  Haptic.vibrate();
                  setState(() {});
                },
                assetPath: "assets/torch.png",
              ),
              CustomIconButton(
                isActive: isSosOn,
                onPressed: () {
                  isSosOn = !isSosOn;
                  toggleSos(isSosOn, callbackIntent: () {
                    setState(() {});
                  });
                  setState(() {});
                },
                assetPath: "assets/sos.png",
              ),
              CustomIconButton(
                isActive: false,
                onPressed: () {
                  Get.to(() => const ScreenTorch());
                },
                assetPath: "assets/innovation.png",
              ),
            ],
          ),
        ),
        bottomNavigationBar: !isPro.isPro.value
            ? UnityBannerAd(
                size: BannerSize.standard,
                placementId: AdServices.bannerAdUnitId,
              )
            : null,
      ),
    );
  }
}
