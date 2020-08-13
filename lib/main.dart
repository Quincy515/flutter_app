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
        body: new ListView(
          children: <Widget>[
            new ListTile(
                leading: new Icon(Icons.perm_camera_mic),
                title: new Text('perm_camera_mic')),
            new ListTile(
                leading: new Icon(Icons.add_call), title: new Text('add_call')),
            new ListTile(
                leading: new Icon(Icons.access_time),
                title: new Text('access_time'))
          ],
        ),
      ),
    );
  }
}
