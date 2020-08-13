import 'package:flutter/material.dart';

void main() => runApp(MyApp(
    // items: List<String>(1000), // 固定长度和非固定长度的数组,固定类型，直接传内容【1，2，3】
    items: new List<String>.generate(1000, (index) => "Item $index")));

class MyApp extends StatelessWidget {
  final List<String> items;
  MyApp({Key key, @required this.items}) : super(key: key); // super 调用父类
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Flutter Demo",
      home: Scaffold(
        // 脚手架组件
        appBar: new AppBar(title: new Text("ListView Widget")),
        body: new ListView.builder(
          itemCount: items.length, // 传递过来参数的长度
          itemBuilder: (context, index) {
            return new ListTile(title: new Text("${items[index]}"));
          },
        ),
      ),
    );
  }
}
