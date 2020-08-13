import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Row Widget Demo',
        home: Scaffold(
          appBar: new AppBar(title: new Text("水平方向布局")),
          body: new Row(
            // 横向列表
            children: <Widget>[
              // Expanded(
              //   child:
              new RaisedButton(
                  onPressed: () {},
                  color: Colors.redAccent,
                  child: new Text("红色按钮")),
              // ),
              Expanded(
                child: new RaisedButton(
                    onPressed: () {},
                    color: Colors.orangeAccent,
                    child: new Text("橙色按钮")),
              ),
              Expanded(
                child: new RaisedButton(
                    onPressed: () {},
                    color: Colors.lightBlue,
                    child: new Text("蓝色按钮")),
              ),
            ],
          ),
        ));
  }
}
