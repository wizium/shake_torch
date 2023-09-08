import 'package:flutter/material.dart';
import 'package:shake_torch/main.dart';
import 'package:shake_torch/widget/containers.dart';
import 'package:shake_torch/widget/listview.dart';

bool? isBackgroundOn = false;
bool isSosOn = false;

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
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.settings,
            ),
          )
        ],
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Shake to Torch"),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("Assets/background.jpg"), fit: BoxFit.cover),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer(
                    width: width,
                    height: height,
                  ),
                  CustomContainer(
                    width: width,
                    height: height,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  CustomContainer(
                    width: width,
                    height: height,
                  ),
                  CustomContainer(
                    width: width,
                    height: height,
                  ),
                ],
              ),
              const CustomListView(
                title: "Shake Torch",
                trailing: Icon(
                  Icons.vibration_rounded,
                  color: Colors.white,
                  size: 60,
                ),
              ),
              const CustomListView(
                trailing: Icon(
                  Icons.vibration_rounded,
                  color: Colors.white,
                  size: 60,
                ),
                title: "Screen Torch",
              )
            ],
          ),
        ),
      ),
    );
  }
}
