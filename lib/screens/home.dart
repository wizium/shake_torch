import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake_torch/main.dart';
import '/services/ad_services.dart';
import '/widgets/Home_Drawer.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '/Functions/alarm_permission.dart';
import '/Functions/battery_optimization.dart';
import '/Functions/notification_permission.dart';
import '/screens/settings.dart';
import '/Functions/sos.dart';
import '/Functions/terminated_run.dart';
import 'screen_torch.dart';

GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
bool isBackgroundOn = false;
bool isSosOn = false;
bool? isTorchOn = false;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    flutterBackgroundService.on("toggled").listen((event) async {
      isTorchOn = event!["on"];
      setState(() {});
    });
    alarmPermission(context).then((value) {
      checkBatteryOptimization(context).then((value) {
        notificationPermission(context);
      });
    });
    if (!isLoaded) {
      AdServices().interstitialAdLoad();
    }
    super.initState();
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
            icon: const Icon(
              Icons.menu_rounded,
            ),
            onPressed: () {
              scaffoldKey.currentState!.openDrawer();
            },
          ),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          centerTitle: true,
          title: Text(
            "Shake torch",
            style: const TextStyle().merge(
              const TextStyle(
                fontSize: 30,
              ),
            ),
          ),
        ),
        body: OrientationBuilder(
          builder: (context, orientation) {
            return orientation == Orientation.portrait
                ? homeBody(context, () {
                    setState(() {});
                  })
                : SingleChildScrollView(
                    child: homeBody(context, () {
                      setState(() {});
                    }),
                  );
          },
        ),
        bottomNavigationBar: isPro.isPro.value
            ? UnityBannerAd(
                size: BannerSize.standard,
                placementId: AdServices.bannerAdUnitId,
                onLoad: (placementId) {
                  debugPrint("$placementId is loaded");
                },
                onFailed: (placementId, error, errorMessage) {
                  debugPrint(
                    "$placementId is failed to load for $errorMessage",
                  );
                },
              )
            : null,
      ),
    );
  }
}

homeBody(context, VoidCallback callback) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () async {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const ScreenTorch();
                  },
                ),
              );
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Image.asset(
                  "assets/screenGlow.png",
                  height: 150,
                  width: 150,
                ),
              ),
            ),
          ),
          Card(
            child: IconButton(
              onPressed: () async {
                torchController.initialize();
                await torchController.toggle();
                isTorchOn = await torchController.isTorchActive;
                callback();
              },
              icon: Icon(
                isTorchOn!
                    ? Icons.flashlight_on_rounded
                    : Icons.flashlight_off_rounded,
                size: 150,
                color: isTorchOn! ? Colors.blue : null,
              ),
            ),
          ),
        ],
      ),
      Padding(
        padding: EdgeInsets.only(
          top: MediaQuery.of(context).size.height * .08,
          bottom: MediaQuery.of(context).size.height * .02,
        ),
        child: Card(
          child: ListTile(
            subtitle: const Text(
              "Toggle Shake detection",
            ),
            subtitleTextStyle: Theme.of(context).textTheme.titleLarge,
            title: const Text(
              "Shake",
            ),
            titleTextStyle: Theme.of(context).textTheme.headlineLarge,
            trailing: Switch(
              value: isBackgroundOn,
              onChanged: (value) async {
                isBackgroundOn = value;
                callback();
                if (!isBackgroundOn) {
                  flutterBackgroundService.invoke("terminate");
                } else {
                  try {
                    await flutterBackgroundService.startService();
                    flutterBackgroundService.invoke("start", {
                      "threshold": threshold! + .1,
                      "background": background,
                      "auto": auto
                    });
                  } catch (e) {
                    alarmPermission(context)
                        .then((value) => notificationPermission(context));
                  }
                }
              },
            ),
          ),
        ),
      ),
      Card(
        child: ListTile(
          subtitle: const Text("Emergency sos pattern"),
          subtitleTextStyle: Theme.of(context).textTheme.titleLarge,
          title: const Text(
            "SOS",
          ),
          titleTextStyle: Theme.of(context).textTheme.headlineLarge,
          trailing: Switch(
            onChanged: (value) {
              isSosOn = value;
              toggleSos(isSosOn, callbackIntent: () {
                callback();
              });
              callback();
            },
            value: isSosOn,
          ),
        ),
      ),
    ],
  );
}
