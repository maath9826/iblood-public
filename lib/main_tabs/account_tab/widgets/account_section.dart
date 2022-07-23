import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../account_tab.dart';


class AccountSection extends StatefulWidget {
  final List<dynamic>?  items;
  final String label;
  final Widget? customBody;

  const AccountSection({Key? key,
    required this.label,
    this.items,
    this.customBody})
      : super(key: key);

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
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
          children: widget.items != null ? widget.items!.map(
                (el) =>
                Column(
                  children: [
                    el,
                    if (widget.items!.indexOf(el) !=
                        widget.items!.length - 1)
                      const Divider(
                        height: 0,
                      )
                  ],
                ),
          ).toList() : [],
        ),)

      ],
    );
  }
}
