import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final bool isActive;
  final VoidCallback onPressed;
  final String assetPath;
  final double height;

  const CustomIconButton({
    required this.isActive,
    required this.onPressed,
    required this.assetPath,
    this.height = 100,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: Colors.grey.shade300,
          width: 2,
          strokeAlign: BorderSide.strokeAlignInside,
          style: BorderStyle.solid,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: IconButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              isActive
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.inversePrimary,
            ),
          ),
          onPressed: onPressed,
          icon: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Image.asset(
              assetPath,
              height: height,
            ),
          ),
        ),
      ),
    );
  }
}
