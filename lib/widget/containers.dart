import 'package:flutter/material.dart';

class CustomContainer extends StatelessWidget {
  final double width;
  final double height;
  const CustomContainer({super.key, required this.width, required this.height});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width * 0.47,
      height: height * 0.2,
      child: const Card(
        elevation: 10,
        // color: Colors.white.withOpacity(.5),
      ),
    );
  }
}
