import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shake_torch/screens/login.dart';
import '/widgets/home_drawer.dart';
import '/main.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;
listenToPurchase(List<PurchaseDetails> purchaseDetails) async {
  for (var element in purchaseDetails) {
    if (element.status == PurchaseStatus.pending) {
      debugPrint("Purchase pending");
    } else if (element.status == PurchaseStatus.error) {
      debugPrint("Error Buying");
    } else if (element.status == PurchaseStatus.purchased) {
      await firestore
          .collection("subscription_details")
          .doc(auth.currentUser!.uid)
          .set({"isPro": true});
      sharedPreferences.setBool("isPro", true);
      isPro.init();
      debugPrint("purchased");
    }
  }
}

initStore(VoidCallback callback) async {
  ProductDetailsResponse productDetailsResponse =
      await inAppPurchase.queryProductDetails(kProductIds);
  if (productDetailsResponse.error == null) {
    products = productDetailsResponse.productDetails;
  } else {
    debugPrint(productDetailsResponse.error.toString());
  }
  callback();
}

buy() async {
  if (auth.currentUser == null) {
    Get.snackbar(
      "Error",
      "Please login first",
      mainButton: TextButton(
        onPressed: () {
          Get.to(
            const LoginScreen(),
          );
        },
        child: const Text("Login"),
      ),
    );
  } else {
    PurchaseParam purchaseParam = PurchaseParam(productDetails: products[0]);
    debugPrint(products[0].price);
    await inAppPurchase.buyConsumable(
      purchaseParam: purchaseParam,
    );
  }
}
