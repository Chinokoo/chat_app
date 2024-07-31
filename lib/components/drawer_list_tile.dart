import 'package:flutter/material.dart';

class DrawerListTile extends StatelessWidget {
  final Icon icon;
  final String listText;
  final Function()? onTap;
  const DrawerListTile(
      {super.key,
      required this.icon,
      required this.onTap,
      required this.listText});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      hoverColor: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: ListTile(
          leading: icon,
          title: Text(
            listText,
            style: TextStyle(color: Theme.of(context).colorScheme.primary),
          ),
        ),
      ),
    );
  }
}
