import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(title: '页面跳转返回数据', home: FirstPage()));
}

class FirstPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('客户电话'),
        ),
        body: Center(
          child: RouteButton(),
        ));
  }
}

class RouteButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
        onPressed: () {
          _navigateToCustom(context);
        },
        child: Text('去找客户'));
  }

  _navigateToCustom(BuildContext context) async {
    final result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => Custom()));
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text('$result'),
    ));
  }
}

class Custom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('我是客户'),
        ),
        body: Center(
          child: Column(
            children: <Widget>[
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, '上海客户: 1511008888');
                  },
                  child: Text('上海客户')),
              RaisedButton(
                  onPressed: () {
                    Navigator.pop(context, '北京客户: 1511008888');
                  },
                  child: Text('北京客户'))
            ],
          ),
        ));
  }
}
