import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'archive_section_item.dart';

class ArchiveSection extends StatefulWidget {
  final ArchiveSectionItem archiveSectionItem;
  final String label;
  final Widget? customBody;

  const ArchiveSection(
      {Key? key,
      required this.label,
      required this.archiveSectionItem,
      this.customBody})
      : super(key: key);

  @override
  State<ArchiveSection> createState() => _ArchiveSectionState();
}

class _ArchiveSectionState extends State<ArchiveSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 20),
          child: Text(
            widget.label.toUpperCase(),
            style: const TextStyle(
              color: CupertinoColors.systemGrey,
            ),
          ),
        ),
        widget.customBody != null
            ? Container(
                color: Colors.white,
                child: widget.customBody!,
              )
            : widget.archiveSectionItem
      ],
    );
  }
}
