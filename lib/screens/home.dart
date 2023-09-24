// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '/Functions/alarm_permission.dart';
import '/Functions/battery_optimization.dart';
import '/Functions/notification_permission.dart';
import '/screens/settings.dart';
import '/services/ad_services.dart';
import '/Functions/sos.dart';
import '/Functions/terminated_run.dart';
import 'screen_torch.dart';

bool isBackgroundOn = false;
bool isSosOn = false;
bool? isTorchOn = false;

bool isLoaded = false;
late BannerAd bannerAd;

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
    load();
    super.initState();
  }

  load() async {
    bannerAd = BannerAd(
      adUnitId: AdServices.bannerAdUnitId,
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          isLoaded = true;
          setState(() {});
        },
        onAdFailedToLoad: (ad, error) {
          debugPrint(error.message);
          ad.dispose();
        },
      ),
      request: const AdRequest(),
    );
    setState(() {});
    await bannerAd.load();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return const SettingsScreen();
                  },
                ),
              );
            },
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          "Shake to Torch",
          style: const TextStyle().merge(
            const TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () async {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ScreenTorch();
                          },
                        ),
                      );
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/screenGlow.png",
                        height: 145,
                        width: 145,
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
                      setState(() {});
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
                      setState(() {});
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
                          notificationPermission(context);
                          alarmPermission(context);
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
                      setState(() {});
                    });
                    setState(() {});
                  },
                  value: isSosOn,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: isLoaded != true
          ? null
          : SizedBox(
              height: bannerAd.size.height.toDouble(),
              width: bannerAd.size.width.toDouble(),
              child: Center(
                child: AdWidget(
                  ad: bannerAd,
                ),
              ),
            ),
    );
  }
}
