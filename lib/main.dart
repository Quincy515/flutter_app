import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var stack = new Stack(
      alignment: const FractionalOffset(0.5, 0.9),
      children: <Widget>[
        new CircleAvatar(
          backgroundImage: new NetworkImage(
              'https://avatars0.githubusercontent.com/u/7986197?s=460&u=e84e0aa9a4ff4708964ecf365626e6f5a5895b4f&v=4'),
          radius: 100.0,
        ),
        new Container(
          // 容器
          decoration: new BoxDecoration(
            // 修饰器
            color: Colors.lightBlue,
          ),
          padding: EdgeInsets.all(5.0),
          child: Text('Custer 学习 flutter'),
        )
      ],
    );
    return MaterialApp(
      title: 'Row Widget Demo',
      home: Scaffold(
        appBar: new AppBar(title: new Text("垂直方向布局")),
        body: Center(
          child: stack,
        ),
      ),
    );
  }
}
