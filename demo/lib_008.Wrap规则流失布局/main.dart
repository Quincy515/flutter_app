import 'package:flutter/material.dart';
import 'warp_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fullter Demo',
      theme: ThemeData.light(),
      home: WarpDemo(),
    );
  }
}
