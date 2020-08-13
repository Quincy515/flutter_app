import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      home: Scaffold(
        // 脚手架组件
        appBar: new AppBar(title: new Text("ListView Widget")),
        body: GridView.count(
          padding: const EdgeInsets.all(20.0),
          crossAxisSpacing: 10.0,
          crossAxisCount: 3,
          children: <Widget>[
            const Text("I am Custer"),
            const Text("I love Go"),
            const Text("做个产品"),
            const Text("爱猫人士"),
            const Text("技术菜"),
            const Text("笨，学不会"),
          ],
        ),
      ),
    );
  }
}
