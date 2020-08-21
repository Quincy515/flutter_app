import 'package:flutter/material.dart';

class ToolTipDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('tool tips demo')),
      body: Center(
        child: Tooltip(
          message: '你碰到我了',
          child: Icon(Icons.all_inclusive),
        ),
      ),
    );
  }
}
