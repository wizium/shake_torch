import 'package:flutter/material.dart';
import 'package:unity_ads_plugin/unity_ads_plugin.dart';

class AdServices {
  static String appId = "5431494";
  static String bannerAdUnitId = "Banner_Android";
  static String interstitialAdUnitId = "Interstitial_Android";
  interstitialAdLoad(
      {required interstitialAdId, required VoidCallback callback}) async {
    await UnityAds.load(
      placementId: interstitialAdId,
      onComplete: (placementId) {
        debugPrint(
          "$placementId is loaded",
        );
        callback();
      },
      onFailed: (placementId, error, errorMessage) {
        debugPrint(
          "$placementId id failed to load for $errorMessage",
        );
      },
    );
  }

  showInterstitialAd(bool loadNotifier, VoidCallback callback) async {
    if (loadNotifier) {
      await UnityAds.showVideoAd(
        placementId: AdServices.interstitialAdUnitId,
      );
      loadNotifier = false;
      callback();
    }
  }
}
