import 'package:flutter/material.dart';

class CapsuleCard extends StatefulWidget {
  final String headerLabel;
  final String footerLabel;
  final Color? headerColor;
  final Color? headerBackgroundColor;

  const CapsuleCard(
      {Key? key,
        required this.footerLabel,
        required this.headerLabel,
        this.headerBackgroundColor,
        this.headerColor})
      : super(key: key);

  @override
  _CapsuleCardState createState() => _CapsuleCardState();
}

class _CapsuleCardState extends State<CapsuleCard> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        child: SizedBox(
          height: 70,
          child: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    widget.headerLabel,
                    style: TextStyle(
                        color: widget.headerColor ?? Theme.of(context).primaryColorDark,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10)),
                    color: widget.headerBackgroundColor ?? Theme.of(context).primaryColorLight,
                  ),
                  alignment: Alignment.center,
                ),
              ),
              Expanded(
                child: Container(
                  alignment: Alignment.center,
                  child: Text(
                    widget.footerLabel,
                    style: const TextStyle(fontSize: 14),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}