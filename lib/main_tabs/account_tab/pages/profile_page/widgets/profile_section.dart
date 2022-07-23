import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../profile_page.dart';

class ProfileSection extends StatefulWidget {
  final List<PieceOfInfo>? info;
  final String label;
  final Widget? customBody;

  const ProfileSection({Key? key,
    required this.label,
    this.info,
    this.customBody})
      : super(key: key);

  @override
  State<ProfileSection> createState() => _ProfileSectionState();
}

class _ProfileSectionState extends State<ProfileSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Text(
            widget.label.toUpperCase(),
            style: const TextStyle(color: CupertinoColors.systemGrey),
          ),
        ),
        widget.customBody != null
            ? Container(color: Colors.white, child: widget.customBody!,)
            : Container(color: Colors.white, child: Column(
          children: widget.info != null ? widget.info!.map(
                (el) =>
                Column(
                  children: [
                    ListTile(
                      tileColor: Colors.white,
                      title: Text(el.label,style: const TextStyle(fontWeight: FontWeight.bold),),
                      trailing: el.icon != null ? Icon(el.icon,color:Colors.red,) : el.content,
                    ),
                    if (widget.info!.indexOf(el) !=
                        widget.info!.length - 1)
                      const Divider(
                        thickness: 0,
                      )
                  ],
                ),
          ).toList() : [],
        ),)

      ],
    );
  }
}
