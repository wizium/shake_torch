import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart';
import 'package:shake_torch/main.dart';
import 'package:shake_torch/screens/home.dart';
import 'package:shake_torch/screens/login.dart';
import 'package:shake_torch/services/purchases.dart';
import '/widgets/home_drawer.dart';
import 'subscription_check.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
Future<void> signInCheck() async {
  if (_auth.currentUser == null) {
    Get.offAll(() => const LoginScreen());
  } else {
    Get.offAll(() => const HomePage());
  }
}

class SignIn {
  Future<void> googleSignIn() async {
    try {
      final googleSignIn = await GoogleSignIn().signIn();
      final auth = await googleSignIn!.authentication;
      await _auth.signInWithCredential(
        GoogleAuthProvider.credential(
          idToken: auth.idToken,
          accessToken: auth.accessToken,
        ),
      );
      await firestore
          .collection("subscription_details")
          .doc(
            FirebaseAuth.instance.currentUser!.uid,
          )
          .get()
          .then((value)async {
        final Timestamp endDate = value.get("endDate");
        sharedPreferences.setString(
          "endDate",
          endDate.toDate().toString(),
        );
        subscriptionCheck(endDate);
        final response = await get(
          Uri.parse(
            _auth.currentUser!.photoURL!,
          ),
        );
        if (response.statusCode == 200) {
          final file = File("${tempPath!.path}/avatar.png");
          await file.writeAsBytes(response.bodyBytes);
        }
      }).onError((error, stackTrace) {
        sharedPreferences.setBool("isPro", false);
        isPro.init();
      });

      await signInCheck();
      Fluttertoast.showToast(msg: 'Sign in successful');
    } catch (e) {
      auth.signOut();
      GoogleSignIn().signOut();
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
