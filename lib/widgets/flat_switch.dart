import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlatSwitch extends StatefulWidget {
  final bool switch_;
  final VoidCallback toggle;
  final bool isPortrait;

  const FlatSwitch(
      {super.key,
      required this.switch_,
      required this.toggle,
      required this.isPortrait});

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
        widget.toggle();
      },
      child: Container(
        width: widget.isPortrait ? Get.width * .92 : Get.width * .1,
        height: widget.isPortrait ? Get.height * .08 : Get.height * .7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: unSelectedColor,
        ),
        child: widget.isPortrait
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height * .07,
                    width:
                        widget.isPortrait ? Get.width * .43 : Get.width * .08,
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
                    height:
                        widget.isPortrait ? Get.height * .07 : Get.height * .1,
                    width:
                        widget.isPortrait ? Get.width * .43 : Get.width * .08,
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
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: Get.height * .34,
                    width: Get.width * .08,
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
                    height: Get.height * .34,
                    width: Get.width * .08,
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
