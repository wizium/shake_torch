import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../main.dart';

class CustomListTile extends StatefulWidget {
  final String title;
  final Widget? trailing;
  final Widget? subtitle;
  final bool? isFree;
  const CustomListTile(
      {super.key,
      required this.title,
      this.trailing,
      this.subtitle,
      this.isFree});

  @override
  State<CustomListTile> createState() => _CustomListTileState();
}

class _CustomListTileState extends State<CustomListTile> {
  @override
  Widget build(
    BuildContext context,
  ) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.title,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  widget.trailing ?? const SizedBox(),
                ],
              ),
              widget.subtitle ?? const SizedBox(),
            ],
          ),
        ),
        if ((widget.isFree ?? false) == false && isPro.isPro.value == false)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FaIcon(
              FontAwesomeIcons.crown,
              size: 15,
              color: Theme.of(context).colorScheme.primary,
            ),
          )
      ],
    );
  }
}
