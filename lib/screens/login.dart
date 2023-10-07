import 'package:flutter/material.dart';
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
        title: const Text('Sign in to Continue'),
        actions: [
          TextButton(
            onPressed: () {
              auth.signOut();
              GoogleSignIn().signOut();
              Get.offAll(
                const HomePage(),
              );
            },
            child: Text(
              "Skip",
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: Get.height * .03),
                  child: Text(
                    "Welcome to Shake Torch",
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Get.height * .15,
                  ),
                  child: Container(
                    height: Get.height * .3,
                    width: Get.width,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: const DecorationImage(
                        image: AssetImage('assets/AppIcon.png'),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    top: Get.width * .35,
                  ),
                  child: InkWell(
                    onTap: () async {
                      await SignIn().googleSignIn();
                    },
                    child: Container(
                      height: Get.height * .08,
                      width: Get.width * .9,
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue with Google",
                              style: Theme.of(context)
                                  .textTheme
                                  .headlineSmall!
                                  .merge(
                                    const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                            ),
                            const Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Icon(
                                Icons.login_outlined,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
