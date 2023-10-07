import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:shake_torch/Functions/subscription_check.dart';
import 'package:shake_torch/screens/login.dart';
import '/widgets/home_drawer.dart';
import '/main.dart';
late PurchaseParam purchaseParam;
FirebaseFirestore firestore = FirebaseFirestore.instance;
listenToPurchase(List<PurchaseDetails> purchaseDetails) async {
  for (PurchaseDetails element in purchaseDetails) {
    if (element.status == PurchaseStatus.pending) {
      debugPrint("Purchase pending");
    } else if (element.status == PurchaseStatus.error) {
      Timestamp? endDate;
      if (purchaseParam.productDetails.id == products[1].id) {
        endDate = Timestamp.fromDate(
          DateTime.now().add(
            const Duration(days: 365),
          ),
        );
      } else if (purchaseParam.productDetails.id == products[0].id) {
        endDate = Timestamp.fromDate(
          DateTime.now().add(
            const Duration(days: 365 * 100),
          ),
        );
      }
      await firestore
          .collection("subscription_details")
          .doc(auth.currentUser!.uid)
          .set(
        {"endDate": endDate},
      );
      sharedPreferences.setString(
        "endDate",
        endDate!.toDate().toString(),
      );
      subscriptionCheck(
        Timestamp.fromDate(
          DateTime.now().add(
            const Duration(days: 365),
          ),
        ),
      );
      debugPrint("Error Buying");
    } else if (element.status == PurchaseStatus.purchased) {
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

buy({required ProductDetails product}) async {
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
    purchaseParam = PurchaseParam(productDetails: product);
    await inAppPurchase.buyConsumable(
      purchaseParam: purchaseParam,
    );
  }
}
