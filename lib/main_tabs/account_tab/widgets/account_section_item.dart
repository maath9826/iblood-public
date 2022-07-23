import 'package:flutter/material.dart';
import 'package:iblood/others/helpers/functions.dart';

class AccountSectionItem extends StatelessWidget {
  final String label;
  final Color? color;
  final String subtitle;
  final IconData icon;
  final Widget? trailing;
  final void Function()? onTabFunction;

  const AccountSectionItem({

    required this.label,
    required this.subtitle,
    required this.icon,
    this.color,
    this.trailing,
    this.onTabFunction,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(

      onTap: onTabFunction,
      leading: SizedBox(child: Icon(icon,size: 28,),height: double.maxFinite,),
      tileColor: isAssigned(color) ? color : Colors.white,
      title: Text(label,style: const TextStyle(fontWeight: FontWeight.bold),),
      subtitle: Text(subtitle),
      trailing: trailing,
    );
  }
}
