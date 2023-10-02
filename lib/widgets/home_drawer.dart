import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shake_torch/screens/premium_purchase.dart';
import 'package:shake_torch/screens/settings.dart';
import 'package:url_launcher/url_launcher.dart';

import '../screens/login.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => HomeDrawerState();
}

class HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  title: const Text("I AM KING"),
                  subtitle: const Text(
                    "QSSSOFTNIC@GMAIL.COM",
                  ),
                  trailing: Icon(
                    Icons.verified,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  onTap: () {
                    Get.to(
                      const LoginScreen(),
                    );
                  },
                  leading: const Image(
                    height: 100,
                    image: AssetImage(
                      "assets/screenGlow.png",
                    ),
                  ),
                ),
                const Divider(),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.workspace_premium_rounded,
                      size: 40,
                    ),
                    title: const Text("Become ViP"),
                    onTap: () {
                      Get.to(
                        const PurchasePro(),
                      );
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.settings_suggest_rounded,
                      size: 40,
                    ),
                    title: const Text("Preferences"),
                    onTap: () {
                      Get.to(const SettingsScreen());
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.feedback_rounded,
                      size: 40,
                    ),
                    title: const Text("Feedback"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.info_outline_rounded,
                      size: 40,
                    ),
                    title: const Text("About app"),
                    onTap: () {
                      showAboutDialog(
                        context: context,
                        applicationName: "Shake Torch",
                        applicationVersion: "1.0.2",
                        applicationIcon: Image.asset(
                          "assets/screenGlow.png",
                          height: 50,
                          width: 50,
                        ),
                        children: [
                          RichText(
                            text: TextSpan(
                              text: "Developed by: ",
                              style: Theme.of(context).textTheme.bodyLarge,
                              children: [
                                TextSpan(
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      if (!await launchUrl(
                                        Uri.parse(
                                          "https://github.com/AbubakarL",
                                        ),
                                      )) {
                                        throw Exception('Could not launch');
                                      }
                                    },
                                  text: "Muhammad Abubakar\n",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                ),
                                const TextSpan(
                                  text: "Contact us at ",
                                ),
                                TextSpan(
                                  text: "Qsssoftnic@gmail.com ",
                                  style: const TextStyle(
                                    color: Colors.blue,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      launchUrl(
                                        Uri.parse(
                                          "mailto:Qsssoftnic@gmail.com",
                                        ),
                                      );
                                    },
                                ),
                                const TextSpan(text: "for Business queries.")
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
                const Divider(),
              ],
            ),
            const Card(
              child: ListTile(
                title: Center(
                  child: Text(
                    "Logout",
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
