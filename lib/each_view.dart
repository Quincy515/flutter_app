import 'package:flutter/material.dart';

// 动态子页面
class EachView extends StatefulWidget {
  String _title;
  EachView(this._title); // 传递的参数
  @override
  _EachViewState createState() => _EachViewState();
}

class _EachViewState extends State<EachView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget._title)),
      body: Center(
        child: Text(widget._title),
      ),
    );
  }
}
