import 'package:flutter/material.dart';
import 'bottom_app_bar_demo.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      // 自定义主题样本
      theme: ThemeData(
        primaryColor: Colors.lightBlue,
      ),
      home: BottomAppBarDemo(),
    );
  }
}
