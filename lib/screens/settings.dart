// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shake_torch/screens/premium_purchase.dart';
import '../services/ad_services.dart';
import '/Functions/data_init.dart';
import '/Functions/terminated_run.dart';
import '/widgets/custom_list_tiles.dart';
import '/main.dart';

bool? background;
bool? auto;
bool isLoaded = false;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    AdServices().interstitialAdLoad(
        interstitialAdId: AdServices.interstitialAdUnitId,
        callback: () {
          setState(() {
            isLoaded = true;
          });
        });
    super.initState();
  }

  @override
  void dispose() {
    AdServices().showInterstitialAd(isLoaded, () {
      setState(() {});
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(
              Icons.verified,
              color: Colors.amber,
            ),
          ),
        ],
        title: const Text(
          'Settings',
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "Shake service Configurations",
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              CustomListTile(
                title: "Shake sensitivity",
                subtitle: Slider(
                  value: threshold!,
                  min: 3,
                  label: threshold.toString(),
                  onChanged: (value) async {
                    threshold = value;

                    setState(() {});
                  },
                  max: 15,
                ),
              ),
              SizedBox(
                height: Get.height * .55,
                child: Stack(
                  children: [
                    Column(
                      children: [
                        CustomListTile(
                          title: "Auto start with phone",
                          trailing: Switch(
                            value: auto!,
                            onChanged: (value) async {
                              auto = value;
                              setState(() {});
                            },
                          ),
                        ),
                        CustomListTile(
                          title: "Hide Notification",
                          trailing: Switch(
                            value: background!,
                            onChanged: (value) async {
                              background = value;

                              setState(() {});
                            },
                          ),
                        ),
                        Text(
                          "SOS Configurations",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        CustomListTile(
                          title: "SoS delay",
                          subtitle: Slider(
                            value: sosDelay!,
                            min: .2,
                            label: (sosDelay!).toStringAsFixed(1),
                            onChanged: (value) async {
                              sosDelay = value;

                              setState(() {});
                            },
                            max: 3,
                          ),
                        ),
                        Text(
                          "Theme",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        CustomListTile(
                          title: "Theme mode",
                          trailing: Switch(
                            thumbIcon: MaterialStatePropertyAll(
                              themeController.dark.value
                                  ? const Icon(Icons.light_mode_outlined)
                                  : const Icon(Icons.dark_mode_rounded),
                            ),
                            value: themeController.dark.value,
                            onChanged: (value) async {
                              themeController.dark.value = value;
                              setState(() {});
                            },
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () {
                        Get.snackbar(
                          "Become Pro",
                          "To use these settings become pro first.",
                          mainButton: TextButton(
                            onPressed: () {
                              Get.to(
                                const PurchasePro(),
                              );
                            },
                            child: const Text(
                              "Become Pro",
                            ),
                          ),
                        );
                      },
                      child: Container(
                        height: Get.height * .55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          color: Theme.of(context)
                              .colorScheme
                              .inversePrimary
                              .withOpacity(.5),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.workspace_premium_outlined,
                            color: Colors.amber.withOpacity(.3),
                            size: Get.height * .3,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: Get.height * .02),
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.onInverseSurface,
                    ),
                    textStyle: MaterialStatePropertyAll(
                      Theme.of(context).textTheme.headlineMedium,
                    ),
                    fixedSize: MaterialStatePropertyAll(
                      Size(
                        Get.height * .25,
                        Get.width * .15,
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await sharedPreferences.setBool(
                        "dark", themeController.dark.value);
                    await sharedPreferences.setDouble("sosDelay", sosDelay!);
                    await sharedPreferences.setDouble("threshold", threshold!);
                    await sharedPreferences.setBool("background", background!);
                    await sharedPreferences.setBool("auto", auto!);
                    Get.changeThemeMode(themeController.dark.value
                        ? ThemeMode.dark
                        : ThemeMode.light);
                    flutterBackgroundService.invoke("save", {
                      "threshold": threshold! + .1,
                      "background": background,
                      "auto": auto
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Saved successfully",
                        ),
                      ),
                    );
                  },
                  child: const Text("Save"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
