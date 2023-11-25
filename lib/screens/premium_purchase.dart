import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:shake_torch/main.dart';
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
      body: OrientationBuilder(builder: (context, orientation) {
        return Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 10,
          ),
          child: orientation == Orientation.portrait
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: body(orientation, context, () {
                    setState(() {});
                  }),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: body(orientation, context, () {
                    setState(() {});
                  }),
                ),
        );
      }),
    );
  }
}

body(orientation, context, VoidCallback callback) {
  return [
    FlatSwitch(
        switch_: selectedType,
        isPortrait: orientation == Orientation.portrait,
        toggle: () {
          selectedType = !selectedType;
          callback();
        }),
    Container(
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onPrimary,
        borderRadius: BorderRadius.circular(
          30,
        ),
      ),
      height: orientation == Orientation.portrait
          ? Get.height * .5
          : Get.height * .75,
      width: orientation == Orientation.portrait
          ? double.infinity
          : Get.width * .6,
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
      padding: EdgeInsets.symmetric(
        vertical: Get.height * .01,
      ),
      child: OutlinedButton(
        onPressed: () async {
          Get.bottomSheet(
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadiusDirectional.only(
                  topEnd: Radius.circular(20),
                  topStart: Radius.circular(20),
                ),
                color: Theme.of(context).colorScheme.tertiaryContainer,
              ),
              height: Get.height * .45,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: Get.width * .02,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        buy(product: products[0]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(
                            65,
                          ),
                        ),
                        height: Get.height * .15,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: Get.width * .1,
                            left: Get.width * .05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.star_rate_rounded,
                                color: Colors.white,
                                size: Get.height * .1,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    products[0].description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                  Text(
                                    "Best Value",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    products[0].price,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                  Text(
                                    "One Time",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        buy(product: products[1]);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.purple,
                          borderRadius: BorderRadius.circular(
                            65,
                          ),
                        ),
                        height: Get.height * .15,
                        child: Padding(
                          padding: EdgeInsets.only(
                            right: Get.width * .1,
                            left: Get.width * .05,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Icon(
                                Icons.workspace_premium_outlined,
                                color: Colors.white,
                                size: Get.height * .1,
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    products[1].description,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                  Text(
                                    "Most Popular",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    products[1].price,
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                  Text(
                                    "One Time",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineSmall!
                                        .merge(
                                          const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // buy(product: products[0]);
          );
        },
        child: Text(
          "Buy",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    ),
  ];
}
