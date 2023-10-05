import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shake_torch/main.dart';
import 'package:shake_torch/services/ad_services.dart';
import '/Functions/color_picker.dart';
import 'package:wakelock/wakelock.dart';
import 'package:screen_brightness/screen_brightness.dart';

bool isLoaded = false;
TextEditingController controller = TextEditingController();
Color backgroundColor = Colors.white;
late StreamController<Color> colorController;
late Stream<Color> colorStream;
Color? tempColor;
late StreamSubscription<Color>? subscription;

class ScreenTorch extends StatefulWidget {
  const ScreenTorch({super.key});

  @override
  State<ScreenTorch> createState() => _ScreenTorchState();
}

class _ScreenTorchState extends State<ScreenTorch> {
  @override
  void initState() {
    colorController = StreamController<Color>();
    colorStream = colorController.stream.asBroadcastStream();
    subscription = colorStream.listen((event) {
      setState(() {
        tempColor = event;
      });
    });
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );
    Wakelock.enable();
    ScreenBrightness().setScreenBrightness(1.0);
    if (isPro.isPro.value != true) {
      AdServices().interstitialAdLoad(
        interstitialAdId: AdServices.interstitialAdUnitId,
        callback: () {
          isLoaded = true;
          setState(() {});
        },
      );
    }
    super.initState();
  }

  @override
  void dispose() {
    colorController.close();
    subscription!.cancel();
    ScreenBrightness().resetScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom,
    ]);
    Wakelock.disable();
    if (isPro.isPro.value != true) {
      AdServices().showInterstitialAd(isLoaded, () {
        setState(() {});
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
              await showDialog(
                context: context,
                builder: (context) {
                  return SimpleDialog(
                    title: const Text(
                      "Configure",
                    ),

                    children: [
                      ListTile(
                        onTap: () {
                          colorPicker(
                            context: context,
                          );
                        },
                        trailing: StreamBuilder(
                          initialData: backgroundColor,
                          stream: colorStream,
                          builder: (context, snapshot) => CircleAvatar(
                            backgroundColor: snapshot.hasData
                                ? snapshot.data
                                : backgroundColor,
                          ),
                        ),
                        title: const Text(
                          "Color",
                        ),
                      ),
                      ListTile(
                        title: TextFormField(
                          decoration: InputDecoration(
                            border: const UnderlineInputBorder(),
                            helperText: "Center emoji",
                            helperStyle: Theme.of(context).textTheme.bodyMedium,
                            hintText: "Emojis only",
                            prefixIcon: const Icon(
                              Icons.emoji_emotions_rounded,
                            ),
                          ),
                          maxLength: 1,
                          controller: controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(
                              RegExp(
                                r'^[\p{Emoji}]+$',
                                unicode: true,
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Cancel",
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              backgroundColor = tempColor!;
                              setState(() {});
                              Navigator.pop(context);
                            },
                            child: const Text(
                              "Ok",
                            ),
                          ),
                        ],
                      ),
                    ],
                    //   ),
                  );
                },
              );
            },
            icon: const Icon(
              Icons.mode_edit_outline_rounded,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: Center(
        child: Text(
          controller.text,
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: backgroundColor,
    );
  }
}
