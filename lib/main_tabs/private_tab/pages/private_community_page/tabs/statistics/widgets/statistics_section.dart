import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../statistics.dart';

class StatisticsSection extends StatefulWidget {
  final List<Statistic>? statistics;
  final String label;
  final Widget? customBody;

  const StatisticsSection(
      {Key? key,
      required this.label,
      this.statistics,
      this.customBody})
      : super(key: key);

  @override
  State<StatisticsSection> createState() => _StatisticsSectionState();
}

class _StatisticsSectionState extends State<StatisticsSection> {
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
            ? Container(color: Colors.white,child: widget.customBody!,)
            : Column(
          children: widget.statistics != null ? widget.statistics!.map(
                (el) => Column(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  title: Text(
                    el.label,
                  ),
                  leading: el.icon != null
                      ? Icon(
                    el.icon,
                  )
                      : null,
                  trailing: Text('${el.count}'),
                ),
                if (widget.statistics!.indexOf(el) !=
                    widget.statistics!.length - 1)
                  const Divider(
                    height: 0,
                  )
              ],
            ),
          ).toList() : [],
        ),
      ],
    );
  }
}
