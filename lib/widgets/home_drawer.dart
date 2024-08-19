import 'dart:io';
import 'package:feedback/feedback.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shake_torch/Functions/login.dart';
import 'package:shake_torch/main.dart';
import 'package:shake_torch/screens/premium_purchase.dart';
import 'package:shake_torch/screens/settings.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';
import '../Functions/feedback.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({super.key});

  @override
  State<HomeDrawer> createState() => HomeDrawerState();
}

class HomeDrawerState extends State<HomeDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(
            left: 5,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (auth.currentUser != null)
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 5,
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
                    leading: CircleAvatar(
                      backgroundImage: FileImage(
                        File("${tempPath!.path}/avatar.png"),
                      ),
                    ),
                  ),
                )
              else
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: ListTile(
                    onTap: () {
                      signInCheck();
                    },
                    leading: FaIcon(
                      FontAwesomeIcons.solidUser,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    title: const Center(
                      child: Text("Login"),
                    ),
                  ),
                ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Column(
                  children: [
                    const Opacity(
                      opacity: 0,
                      child: Divider(
                        height: 2,
                      ),
                    ),
                    Obx(() {
                      return isPro.isPro.value != true
                          ? Column(
                              children: [
                                ListTile(
                                  leading: FaIcon(
                                    FontAwesomeIcons.crown,
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary,
                                  ),
                                  title: const Text("Become VIP"),
                                  subtitle: const Text("Unlock all features"),
                                  onTap: () {
                                    Get.to(() => const PurchasePro());
                                  },
                                  trailing: const Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 20,
                                  ),
                                ),
                                const Divider(
                                  height: 2,
                                ),
                              ],
                            )
                          : const SizedBox();
                    }),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.gear,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      title: const Text("Preferences"),
                      subtitle: const Text("Menage the app settings"),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                      onTap: () {
                        Get.to(() => const SettingsScreen());
                      },
                    ),
                    const Divider(
                      height: 2,
                    ),
                    ListTile(
                      onTap: () async {
                        await launchUrl(
                          Uri.parse(
                            "https://play.google.com/store/apps/details?id=com.wizium.shake_torch&hl=en",
                          ),
                        );
                      },
                      leading: FaIcon(
                        FontAwesomeIcons.solidHeart,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      title: const Text("Rate Us"),
                      subtitle: const Text("Rate us on PlayStore"),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                    ),
                    const Divider(
                      height: 2,
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.solidMessage,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      subtitle: const Text("Report problems"),
                      title: const Text("Feedback"),
                      onTap: () async {
                        BetterFeedback.of(context).show((feedback) async {
                          sendEmail(
                            image: feedback.screenshot,
                            messageText: feedback.text,
                          );
                        });
                      },
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 20),
                    ),
                    const Divider(
                      height: 2,
                    ),
                    ListTile(
                      onTap: () async {
                        await Share.share(
                          "Hay there i am using Shake Torch.\nIts handy to use it.\n\nDownload it here: https://play.google.com/store/apps/details?id=com.wizium.shake_torch&hl=en",
                        );
                      },
                      leading: FaIcon(
                        FontAwesomeIcons.share,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      title: const Text("Share"),
                      subtitle: const Text("Share this app"),
                      trailing:
                          const Icon(Icons.arrow_forward_ios_rounded, size: 20),
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
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: ListTile(
                  leading: const FaIcon(FontAwesomeIcons.circleInfo),
                  title: const Text("About app"),
                  onTap: () {
                    showAboutDialog(
                      context: context,
                      applicationName: "Shake Torch",
                      applicationVersion: "1.1.0+14",
                      applicationIcon: Image.asset(
                        "assets/AppIcon.png",
                        height: 70,
                        width: 70,
                      ),
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            launchUrl(
                              Uri.parse(
                                "https://sites.google.com/view/shaketorch",
                              ),
                            );
                          },
                          child: const Text("Privacy Policy"),
                        )
                      ],
                    );
                  },
                ),
              ),
              auth.currentUser != null
                  ? Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: ListTile(
                        leading: const RotatedBox(
                          quarterTurns: 2,
                          child: FaIcon(
                            FontAwesomeIcons.rightFromBracket,
                          ),
                        ),
                        onTap: () async {
                          await auth.signOut();
                          await GoogleSignIn().signOut();
                          sharedPreferences.remove("endDate");
                          sharedPreferences.setBool("isPro", false);
                          isPro.init();
                          await signInCheck();
                        },
                        title: const Text("Logout"),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
