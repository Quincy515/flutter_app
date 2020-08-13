import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Row Widget Demo',
      home: Scaffold(
        appBar: new AppBar(title: new Text("垂直方向布局")),
        body: Center(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.center, // 对齐方式
            mainAxisAlignment: MainAxisAlignment.center,

            children: <Widget>[
              Text("I am Custer"),
              Expanded(child: Text("I study Flutter,haha")),
              Text("I love Code"),
            ],
          ),
        ),
      ),
    );
  }
}
