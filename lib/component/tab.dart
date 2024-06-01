import 'package:flutter/material.dart';

class TabPage extends StatefulWidget {
  const TabPage({Key? key, required this.texts}) : super(key: key);

  final texts;

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(widget.texts),
    );
  }
}
