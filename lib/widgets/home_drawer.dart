import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shake_torch/Functions/login.dart';
import 'package:shake_torch/main.dart';
import 'package:shake_torch/screens/premium_purchase.dart';
import 'package:shake_torch/screens/settings.dart';
import 'package:url_launcher/url_launcher.dart';

FirebaseAuth auth = FirebaseAuth.instance;

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
                if (auth.currentUser != null)
                  ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 20,
                      horizontal: 10,
                    ),
                    title: Text(auth.currentUser!.displayName!),
                    subtitle: Text(
                      auth.currentUser!.email!,
                    ),
                    trailing: Obx(() {
                      return Icon(
                        isPro.isPro.value
                            ? Icons.workspace_premium_rounded
                            : null,
                        color: Theme.of(context).colorScheme.primary,
                      );
                    }),
                    onTap: null,
                    leading: Image(
                      errorBuilder: (context, error, stackTrace) {
                        return Icon(
                          Icons.account_circle_rounded,
                          size: Get.height * .05,
                        );
                      },
                      height: Get.height * .1,
                      image: NetworkImage(
                        auth.currentUser!.photoURL!,
                      ),
                    ),
                  )
                else
                  Card(
                    child: ListTile(
                      onTap: () {
                        signInCheck();
                      },
                      leading: const Icon(
                        Icons.account_circle_rounded,
                        size: 40,
                      ),
                      title: const Center(
                        child: Text(
                          "Login",
                        ),
                      ),
                    ),
                  ),
                const Divider(),
                Obx(() {
                  return isPro.isPro.value != true
                      ? Card(
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
                        )
                      : const SizedBox();
                }),
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
            auth.currentUser != null
                ? Card(
                    child: ListTile(
                      onTap: () async {
                        await auth.signOut();
                        await GoogleSignIn().signOut();
                        sharedPreferences.setBool("isPro", false);
                        isPro.init();
                        await signInCheck();
                      },
                      title: const Center(
                        child: Text(
                          "Logout",
                        ),
                      ),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
