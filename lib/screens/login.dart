import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shake_torch/screens/home.dart';
import 'package:shake_torch/widgets/home_drawer.dart';
import '/Functions/login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 10),
            child: ElevatedButton.icon(
              onPressed: () {
                auth.signOut();
                GoogleSignIn().signOut();
                Get.offAll(() => const HomePage());
              },
              icon: const FaIcon(FontAwesomeIcons.arrowRightLong),
              label: const Text("Skip"),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            Center(
              child: Column(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image(
                      image: const AssetImage('assets/appIcon.png'),
                      height: Get.height * .3,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 40),
                    child: Text(
                      "ShakeTorch",
                      style: Theme.of(context).textTheme.headlineLarge!.merge(
                            TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                          ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: Text(
                      "Lets get started",
                      style: Theme.of(context).textTheme.headlineLarge!.merge(
                            TextStyle(
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.only(
                top: Get.height * .15,
              ),
              child: SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await SignIn().googleSignIn();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/google.png",
                        height: 30,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        "Signin with Google",
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                    ],
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
