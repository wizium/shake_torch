import 'package:flutter/material.dart';
import 'package:shake_torch/main.dart';
import '/Functions/sos.dart';
import '/Functions/terminated_run.dart';
import 'screen_torch.dart';

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
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
            ),
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(
          "Shake to Torch",
          style: const TextStyle().merge(
            const TextStyle(
              fontSize: 30,
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                InkWell(
                  onTap: () async {
                    setState(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return const ScreenTorch();
                          },
                        ),
                      );
                    });
                  },
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Image.asset(
                        "assets/screenGlow.png",
                        height: 145,
                        width: 145,
                      ),
                    ),
                  ),
                ),
                Card(
                  child: IconButton(
                    onPressed: () async {
                      torchController.initialize();
                      await torchController.toggle();
                      isTorchOn = !isTorchOn;
                      setState(() {});
                    },
                    icon: Icon(
                      isTorchOn
                          ? Icons.flashlight_on_rounded
                          : Icons.flashlight_off_rounded,
                      size: 150,
                      color: isTorchOn ? Colors.blue : null,
                    ),
                  ),
                ),
              ],
            ),
            Card(
              child: ListTile(
                subtitle: const Text(
                  "Toggle Shake detection",
                ),
                subtitleTextStyle: Theme.of(context).textTheme.titleLarge,
                title: const Text(
                  "Shake",
                ),
                titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                trailing: Switch(
                  value: isBackgroundOn!,
                  onChanged: (value) async {
                    {
                      if (isBackgroundOn!) {
                        flutterBackgroundService.invoke("terminate");
                      } else {
                        await flutterBackgroundService.startService();
                        flutterBackgroundService.invoke("start");
                      }
                      setState(() {
                        isBackgroundOn = !isBackgroundOn!;
                      });
                      await sharedPreferences.setBool(
                        "isOn",
                        isBackgroundOn!,
                      );
                    }
                  },
                ),
              ),
            ),
            Card(
              child: ListTile(
                subtitle: const Text("Emergency sos pattern"),
                subtitleTextStyle: Theme.of(context).textTheme.titleLarge,
                title: const Text(
                  "SOS",
                ),
                titleTextStyle: Theme.of(context).textTheme.headlineLarge,
                trailing: Switch(
                  onChanged: (value) {
                    isSosOn = value;
                    toggleSos(isSosOn, callbackIntent: () {
                      setState(() {});
                    });
                    setState(() {});
                  },
                  value: isSosOn,
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        color: Colors.amber,
      ),
    );
  }
}
