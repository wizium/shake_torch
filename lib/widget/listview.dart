import 'package:flutter/material.dart';

class CustomListView extends StatelessWidget {
  final String title;
  final Widget trailing;
  const CustomListView({
    super.key,
    required this.title,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Card(
        elevation: 5,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 40),
          child: ListTile(
            textColor: Colors.white,
            title: Text(
              title,
            ),
            trailing: trailing,
          ),
        ),
      ),
    );
  }
}
