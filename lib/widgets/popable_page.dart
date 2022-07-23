import 'package:flutter/material.dart';

class PoppablePage extends StatefulWidget {
  final String label;
  final Widget body;
  const PoppablePage({required this.label,required this.body});

  @override
  _PoppablePageState createState() => _PoppablePageState();
}

class _PoppablePageState extends State<PoppablePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
      ),
      body: widget.body,
    );
  }
}
