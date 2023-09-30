import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class PremiumOffers extends StatefulWidget {
  const PremiumOffers({super.key});

  @override
  State<PremiumOffers> createState() => PremiumStateOffers();
}

class PremiumStateOffers extends State<PremiumOffers> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: Get.width * .7,
      color: Colors.red,
    );
  }
}
