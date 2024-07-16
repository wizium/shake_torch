import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FlatSwitch extends StatefulWidget {
  final bool switch_;
  final VoidCallback toggle;

  const FlatSwitch({
    super.key,
    required this.switch_,
    required this.toggle,
  });

  @override
  State<FlatSwitch> createState() => _FlatSwitchState();
}

class _FlatSwitchState extends State<FlatSwitch> {
  @override
  Widget build(BuildContext context) {
    Color selectedColor = Theme.of(context).colorScheme.inversePrimary;
    Color unSelectedColor = Theme.of(context).colorScheme.onPrimary;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          widget.toggle();
        },
        child: Container(
          width: Get.width,
          height: 70,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: unSelectedColor,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 60,
                width: Get.width * .45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: widget.switch_ ? selectedColor : unSelectedColor,
                ),
                child: Center(
                  child: Text(
                    'Free',
                    style: Theme.of(context).textTheme.headlineSmall!.merge(
                          TextStyle(
                            color: widget.switch_
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                  ),
                ),
              ),
              Container(
                height: 60,
                width: Get.width * .45,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: !widget.switch_ ? selectedColor : unSelectedColor,
                ),
                child: Center(
                  child: Text(
                    'Premium',
                    style: Theme.of(context).textTheme.headlineSmall!.merge(
                          TextStyle(
                            color: !widget.switch_
                                ? Theme.of(context).colorScheme.surface
                                : Theme.of(context).colorScheme.inverseSurface,
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
