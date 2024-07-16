import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:interactive_slider/interactive_slider.dart';
import 'package:shake_torch/main.dart';
import 'package:shake_torch/services/ad_services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:screen_brightness/screen_brightness.dart';
import 'package:flex_color_picker/flex_color_picker.dart';

Color backgroundColor = Colors.red;
double brightness = 1.0;

class ScreenTorch extends StatefulWidget {
  const ScreenTorch({super.key});

  @override
  State<ScreenTorch> createState() => _ScreenTorchState();
}

class _ScreenTorchState extends State<ScreenTorch> {
  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    Wakelock.enable();
    brightness = 1;
    ScreenBrightness().setScreenBrightness(brightness);
    if (!isLoaded) {
      AdServices().interstitialAdLoad();
    }
    super.initState();
  }

  @override
  void dispose() {
    ScreenBrightness().resetScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    Wakelock.disable();
    if (isLoaded) {
      AdServices().showInterstitialAd(() {
        AdServices().interstitialAdLoad();
      });
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.black,
            ),
          ),
          backgroundColor: Colors.transparent,
          actions: [
            IconButton(
              onPressed: () async {
                ColorPicker(
                  pickersEnabled: const {
                    ColorPickerType.accent: false,
                  },
                  onColorChanged: (Color value) {},
                  onColorChangeEnd: (value) {
                    backgroundColor = value;
                    setState(() {});
                  },
                  actionButtons: const ColorPickerActionButtons(
                    closeButton: false,
                    dialogActionButtons: false,
                    okButton: true,
                  ),
                ).showPickerDialog(context);
              },
              icon: const Icon(
                Icons.mode_edit_outline_rounded,
                color: Colors.black,
              ),
            )
          ],
        ),
        body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: Get.height * .5,
                child: RotatedBox(
                  quarterTurns: 3,
                  child: InteractiveSlider(
                    unfocusedOpacity: 1,
                    initialProgress: brightness,
                    focusedHeight: 100,
                    unfocusedHeight: 100,
                    min: 0.0,
                    max: 1.0,
                    backgroundColor: Colors.white.withOpacity(.5),
                    foregroundColor: Colors.white,
                    onChanged: (value) {
                      brightness = value;
                      ScreenBrightness().setScreenBrightness(brightness);
                      setState(() {});
                    },
                  ),
                ),
              ),
            ]),
        extendBodyBehindAppBar: true,
        backgroundColor: backgroundColor);
  }
}
