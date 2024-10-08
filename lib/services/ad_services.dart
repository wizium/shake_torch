import 'package:unity_ads_plugin/unity_ads_plugin.dart';
import '/main.dart';

class AdServices {
  static String appId = "5431494";
  static String bannerAdUnitId = "Banner_Android";
  static String interstitialAdUnitId = "Interstitial_Android";

  void interstitialAdLoad() async {
    if (!isPro.isPro.value) {
      await UnityAds.load(
        placementId: interstitialAdUnitId,
        onComplete: (placementId) {
          
          isLoaded = true;
        },
      );
    }
  }

  Future<void> showInterstitialAd(Function onComplete) async {
      if (!isPro.isPro.value) {
        await UnityAds.showVideoAd(
          placementId: AdServices.interstitialAdUnitId,
          onComplete: (placementId) {
            onComplete();
          },
          onSkipped: (placementId) {
            onComplete();
          },
          onFailed: (placementId, error, errorMessage) {
            onComplete();
          },
        );
        isLoaded = false;
      }
  }
}
