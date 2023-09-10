import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:wakelock/wakelock.dart';
import 'package:screen_brightness/screen_brightness.dart';

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
    super.initState();
    Wakelock.enable();
    ScreenBrightness().setScreenBrightness(1.0);
  }

  @override
  void dispose() {
    super.dispose();
    ScreenBrightness().resetScreenBrightness();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    Wakelock.disable();
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
          ),
        ),
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.mode_edit_outline_rounded,
            ),
          )
        ],
      ),
      extendBodyBehindAppBar: true,
      backgroundColor: Colors.white,
    );
  }
}
