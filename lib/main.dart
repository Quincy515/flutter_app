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
        new Positioned(
          top: 10.0,
          left: 60.0,
          child: new Text('Custer 学习 '),
        ),
        new Positioned(
          bottom: 10.0,
          right: 10.0,
          child: new Text('flutter'),
        ),
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
