import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
        backgroundColor: Colors.transparent,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: const Text("Become VIP"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        child: Column(children: [
          FlatSwitch(
              switch_: selectedType,
              toggle: () {
                selectedType = !selectedType;
                setState(() {});
              }),
          Container(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onPrimary,
              borderRadius: BorderRadius.circular(30),
            ),
            height: 380,
            width: Get.width,
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
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Emergency SoS",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Screen Torch",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Shake sensitivity control",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ]
                    : [
                        Text(
                          "All free stuff plus",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Auto start with phone",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Hide notification",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "Dark/Light theme mode",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                        Text(
                          "No ads",
                          style: Theme.of(context).textTheme.headlineSmall,
                        ),
                      ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: Get.width,
            child: ElevatedButton(
              onPressed: () async {
                Get.bottomSheet(
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadiusDirectional.only(
                        topEnd: Radius.circular(20),
                        topStart: Radius.circular(20),
                      ),
                      color: Theme.of(context).colorScheme.primary,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                borderRadius: BorderRadius.circular(65),
                              ),
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                  left: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const FaIcon(
                                      FontAwesomeIcons.solidStar,
                                      color: Colors.white,
                                      size: 40,
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
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary,
                                borderRadius: BorderRadius.circular(65),
                              ),
                              height: 100,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                  right: 20,
                                  left: 20,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const FaIcon(FontAwesomeIcons.crown,
                                        color: Colors.white, size: 40),
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
                );
              },
              child: Text(
                "Buy",
                style: Theme.of(context).textTheme.bodyLarge!.merge(
                      TextStyle(color: Theme.of(context).colorScheme.primary),
                    ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
