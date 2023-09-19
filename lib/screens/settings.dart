// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shake_torch/Functions/data_init.dart';
import 'package:shake_torch/Functions/terminated_run.dart';
import 'package:shake_torch/widgets/custom_list_tiles.dart';

import '../main.dart';

bool? background;
bool? auto;

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              "Shake service Configurations",
              style: Theme.of(context).textTheme.headlineSmall,
            ),
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
            CustomListTile(
              title: "Shake sensitivity",
              subtitle: Slider(
                value: threshold!,
                min: 3,
                divisions: 12,
                label: threshold.toString(),
                onChanged: (value) async {
                  threshold = value;

                  setState(() {});
                },
                max: 15,
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
                divisions: 10,
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
            Align(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                onLongPress: () {
                  Tooltip(
                    child: const Text("Save configurations"),
                  );
                },
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
    );
  }
}
