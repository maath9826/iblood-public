import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:iblood/others/helpers/functions.dart';

class ArchiveSectionItem extends StatelessWidget {
  final String label;
  final String? subtitle;
  final Widget icon;
  final int? numberOfBags;
  final Color tileColor;
  final void Function()? onTabFunction;

  const ArchiveSectionItem({
    required this.label,
    required this.icon,
    required this.tileColor,
    this.subtitle,
    this.numberOfBags,
    this.onTabFunction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      onTap: onTabFunction,
      leading: SizedBox(
        child: icon,
        height: double.maxFinite,
      ),
      tileColor: tileColor,
      title: Text(
        label,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: isAssigned(subtitle) ? Text(subtitle!) : null,
      trailing: numberOfBags == null ? null : RichText(
        text: TextSpan(
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: '$numberOfBags',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const TextSpan(
              text: ' bags',
            ),
          ],
        ),
      ),
    );
  }
}
