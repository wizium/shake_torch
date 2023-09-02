import 'package:flutter/material.dart';
import 'package:shake_torch/main.dart';
import '/Functions/sos.dart';
import '/Functions/terminated_run.dart';

bool? isBackgroundOn = false;
bool isSosOn = false;
bool isTorchOn = false;

class HomePage extends StatefulWidget {
  const HomePage({
    super.key,
  });
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    if (isBackgroundOn == null) {
      isBackgroundOn = false;
      setState(() {});
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Shake to Torch"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              isTorchOn
                  ? Icons.flashlight_on_rounded
                  : Icons.flashlight_off_rounded,
              size: 150,
              color: isTorchOn ? Colors.amber : Colors.black,
              // color: Theme.of(context).colorScheme.inversePrimary,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 100.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Transform.scale(
                    scale: 3,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Switch(
                        value: isBackgroundOn!,
                        onChanged: (value) async {
                          if (isBackgroundOn!) {
                            flutterBackgroundService.invoke("terminate");
                          } else {
                            await flutterBackgroundService.startService();
                            flutterBackgroundService.invoke("start");
                          }
                          setState(() {
                            isBackgroundOn = value;
                          });
                          await sharedPreferences.setBool(
                            "isOn",
                            isBackgroundOn!,
                          );
                        },
                      ),
                    ),
                  ),
                  Transform.scale(
                    scale: 3,
                    child: RotatedBox(
                      quarterTurns: 3,
                      child: Switch(
                        value: isSosOn,
                        onChanged: (value) async {
                          isSosOn = value;
                          setState(() {});
                          toggleSos(isSosOn, callbackIntent: () {
                            setState(() {});
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 100),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Icon(
                    Icons.vibration_rounded,
                    color: Colors.green,
                    size: 60,
                  ),
                  Icon(
                    Icons.sos_outlined,
                    color: Colors.red,
                    size: 60,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
