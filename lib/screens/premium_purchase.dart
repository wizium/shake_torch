import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '/services/purchases.dart';
import '/widgets/flat_switch.dart';

bool selectedType = true;

class PurchasePro extends StatefulWidget {
  const PurchasePro({super.key});

  @override
  State<PurchasePro> createState() => _PurchaseProState();
}

class _PurchaseProState extends State<PurchasePro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: const Text(
          "Be power User with more control",
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: FlatSwitch(
                  switch_: selectedType,
                  toggle: () {
                    selectedType = !selectedType;
                    setState(() {});
                  }),
            ),
            Container(
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.onPrimary,
                borderRadius: BorderRadius.circular(
                  30,
                ),
              ),
              height: Get.height * .5,
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 30,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: selectedType
                      ? [
                          Text(
                            "Shake Torch",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Emergency SoS",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Screen Torch",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Shake sensitivity control",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ]
                      : [
                          Text(
                            "All free stuff Plus",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Auto start with phone",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Hide Notification",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "sos delay configurations",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "Dark/Light theme mode",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                          Text(
                            "No Ads",
                            style: Theme.of(context).textTheme.headlineMedium,
                          ),
                        ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                style: ButtonStyle(
                  fixedSize: MaterialStatePropertyAll(
                    Size(
                      Get.width * 1,
                      Get.height * .1,
                    ),
                  ),
                ),
                onPressed: () async {
                  buy();
                },
                child: Text(
                  "Buy",
                  style: Theme.of(context).textTheme.headlineMedium,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
