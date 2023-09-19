import 'package:flutter/material.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final Widget? trailing;
  final Widget? subtitle;
  const CustomListTile({
    super.key,
    required this.title,
    this.trailing,
    this.subtitle,
  });

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        contentPadding:
            EdgeInsets.all(MediaQuery.of(context).size.height * .01),
        title: Text(
          widget.title,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        trailing: widget.trailing,
        subtitle: widget.subtitle,
      ),
    );
  }
}
