import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var card = new Card(
      child: Column(
        children: <Widget>[
          ListTile(
            title: Text(
                "Flutter 是 Google 开源的 UI 工具包，帮助开发者通过一套代码库高效构建多平台精美应用，支持移动、Web、桌面和嵌入式平台。",
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('好好学习，争取早日做出自己的产品'),
            leading: new Icon(
              Icons.flight,
              color: Colors.lightBlue,
            ),
          ),
          new Divider(),
          ListTile(
            title: Text(
                "Flutter 是 Google 开源的 UI 工具包，帮助开发者通过一套代码库高效构建多平台精美应用，支持移动、Web、桌面和嵌入式平台。",
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('好好学习，争取早日做出自己的产品'),
            leading: new Icon(
              Icons.flight,
              color: Colors.lightBlue,
            ),
          ),
          new Divider(),
          ListTile(
            title: Text(
                "Flutter 是 Google 开源的 UI 工具包，帮助开发者通过一套代码库高效构建多平台精美应用，支持移动、Web、桌面和嵌入式平台。",
                style: TextStyle(fontWeight: FontWeight.w500)),
            subtitle: Text('好好学习，争取早日做出自己的产品'),
            leading: new Icon(
              Icons.flight,
              color: Colors.lightBlue,
            ),
          ),
        ],
      ),
    );
    return MaterialApp(
      title: 'Row Widget Demo',
      home: Scaffold(
        appBar: new AppBar(title: new Text("垂直方向布局")),
        body: Center(
          child: card,
        ),
      ),
    );
  }
}
