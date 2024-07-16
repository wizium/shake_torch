import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../Functions/haptic.dart';
import '/services/ad_services.dart';
import '/Functions/data_init.dart';
import '/Functions/terminated_run.dart';
import '/widgets/custom_list_tiles.dart';
import '/main.dart';
import 'premium_purchase.dart';

bool? background;
bool? auto;
bool isHapticOn = false;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    if (!isLoaded) {
      AdServices().interstitialAdLoad();
    }

    super.initState();
  }

  @override
  void dispose() {
    if (isLoaded) {
      AdServices().showInterstitialAd(() {
        AdServices().interstitialAdLoad();
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "Shake",
                    style: Theme.of(context).textTheme.titleMedium!.merge(
                          const TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      const Opacity(
                        opacity: 0,
                        child: Divider(height: 2),
                      ),
                      CustomListTile(
                        isFree: true,
                        title: "Shake hardness",
                        subtitle: Slider(
                          value: threshold!,
                          min: 3,
                          max: 10,
                          onChanged: (value) {
                            threshold = value;
                            setState(() {});
                          },
                        ),
                      ),
                      const Divider(
                        height: 2,
                      ),
                      CustomListTile(
                        title: "Auto start with phone",
                        trailing: Switch(
                          value: auto!,
                          onChanged: (value) async {
                            if (isPro.isPro.value == false) {
                              Get.defaultDialog(
                                  contentPadding: const EdgeInsets.all(20),
                                  content: const Text(
                                      "You might need to be a premium user in order to modify this setting"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Close"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => const PurchasePro());
                                        },
                                        child: const Text("Become Pro"))
                                  ]);
                            } else {
                              Haptic.vibrate();
                              auto = value;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      const Divider(
                        height: 2,
                      ),
                      CustomListTile(
                        title: "Hide Notification",
                        trailing: Switch(
                          value: background!,
                          onChanged: (value) async {
                            if (isPro.isPro.value == false) {
                              Get.defaultDialog(
                                  contentPadding: const EdgeInsets.all(20),
                                  content: const Text(
                                      "You might need to be a premium user in order to modify this setting"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Close"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => const PurchasePro());
                                        },
                                        child: const Text("Become Pro"))
                                  ]);
                            } else {
                              Haptic.vibrate();
                              background = value;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      const Opacity(
                        opacity: 0,
                        child: Divider(
                          height: 2,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "SOS",
                    style: Theme.of(context).textTheme.titleMedium!.merge(
                          const TextStyle(color: Colors.grey),
                        ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      const Opacity(
                        opacity: 0,
                        child: Divider(
                          height: 2,
                        ),
                      ),
                      CustomListTile(
                        isFree: true,
                        title: "SOS delay",
                        subtitle: Slider(
                          value: sosDelay!,
                          min: .2,
                          onChanged: (value) async {
                            sosDelay = value;
                            setState(() {});
                          },
                          max: 5,
                        ),
                      ),
                      const Opacity(
                        opacity: 0,
                        child: Divider(
                          height: 2,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(left: 15),
                  child: Text(
                    "App",
                    style: Theme.of(context).textTheme.titleMedium!.merge(
                          const TextStyle(color: Colors.grey),
                        ),
                  ),
                ),
                Card(
                  child: Column(
                    children: [
                      const Opacity(
                        opacity: 0,
                        child: Divider(
                          height: 2,
                        ),
                      ),
                      CustomListTile(
                        title: "Theme mode",
                        trailing: Switch(
                          thumbIcon: WidgetStatePropertyAll(
                            !themeController.dark.value
                                ? const Icon(Icons.light_mode_outlined)
                                : const Icon(Icons.dark_mode_rounded),
                          ),
                          value: themeController.dark.value,
                          onChanged: (value) async {
                            if (isPro.isPro.value == false) {
                              Get.defaultDialog(
                                  contentPadding: const EdgeInsets.all(20),
                                  content: const Text(
                                      "You might need to be a premium user in order to modify this setting"),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: const Text("Close"),
                                    ),
                                    const SizedBox(
                                      width: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () {
                                          Get.to(() => const PurchasePro());
                                        },
                                        child: const Text("Become Pro"))
                                  ]);
                            } else {
                              Haptic.vibrate();
                              themeController.dark.value = value;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      const Divider(
                        height: 2,
                      ),
                      CustomListTile(
                        isFree: true,
                        title: "Haptic Feedback",
                        trailing: Switch(
                            value: isHapticOn,
                            onChanged: (value) {
                              isHapticOn = value;
                              setState(() {});
                            }),
                      ),
                      const Opacity(
                        opacity: 0,
                        child: Divider(height: 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              height: 50,
              width: Get.width,
              child: ElevatedButton(
                onPressed: () async {
                  Haptic.vibrate();
                  await sharedPreferences.setBool(
                    "dark",
                    themeController.dark.value,
                  );
                  await sharedPreferences.setDouble("sosDelay", sosDelay!);
                  await sharedPreferences.setDouble("threshold", threshold!);
                  await sharedPreferences.setBool("background", background!);
                  await sharedPreferences.setBool("auto", auto!);
                  await sharedPreferences.setBool("haptic", isHapticOn);

                  Get.changeThemeMode(
                    themeController.dark.value
                        ? ThemeMode.dark
                        : ThemeMode.light,
                  );
                  flutterBackgroundService.invoke("save", {
                    "threshold": threshold,
                    "background": background,
                    "auto": auto
                  });
                  Fluttertoast.showToast(msg: "Saved successfully");
                },
                child: Text(
                  "Save",
                  style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
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
