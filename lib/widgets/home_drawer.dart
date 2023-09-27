import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shake_torch/screens/settings.dart';

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
                  trailing: const Icon(
                    Icons.verified,
                    color: Colors.red,
                  ),
                  onTap: () {},
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
                      Icons.home_rounded,
                      size: 40,
                    ),
                    title: const Text("Home"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.account_circle_outlined,
                      size: 40,
                    ),
                    title: const Text("Account"),
                    onTap: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                Card(
                  child: ListTile(
                    leading: const Icon(
                      Icons.workspace_premium_rounded,
                      size: 40,
                    ),
                    title: const Text("Upgrade account"),
                    onTap: () {
                      Navigator.pop(context);
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
                      Icons.support_agent_rounded,
                      size: 40,
                    ),
                    title: const Text("Support"),
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
                      Get.to(const SettingsScreen());
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
