import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlatSwitch extends StatefulWidget {
  final bool switch_;
  final VoidCallback toggle;

  const FlatSwitch({super.key, required this.switch_, required this.toggle});

  @override
  State<FlatSwitch> createState() => _FlatSwitchState();
}

class _FlatSwitchState extends State<FlatSwitch> {
  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).colorScheme.inversePrimary;
    Color unSelectedColor = Theme.of(context).colorScheme.onPrimary;
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        //toggle switch
        widget.toggle();
      },
      child: Container(
        width: Get.width * .9,
        height: Get.height * .08,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: unSelectedColor,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: Get.height * .07,
              width: Get.width * .44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: widget.switch_ ? selectedColor : unSelectedColor,
              ),
              child: Center(
                child: Text(
                  'Free',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
            Container(
              height: Get.height * .07,
              width: Get.width * .44,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: !widget.switch_ ? selectedColor : unSelectedColor,
              ),
              child: Center(
                child: Text(
                  'Pro',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
