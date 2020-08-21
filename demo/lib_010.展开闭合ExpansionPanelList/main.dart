import 'package:flutter/material.dart';
import 'expansion_pane_list.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.dark(),
      home: ExpansionPaneListDemo(),
    );
  }
}
