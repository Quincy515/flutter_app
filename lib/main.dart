import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "导航演示01",
    home: new FirstScreen(),
  ));
}

class FirstScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("导航页面")),
      body: Center(
        child: RaisedButton(
          // 按钮组件
          child: Text('查看商品详情页'),
          onPressed: () {
            // 按下动作的响应事件
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => new SecondScreen()));
          },
        ),
      ),
    );
  }
}

// 子页面
class SecondScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text('商品详情页')),
        body: Center(
          child: RaisedButton(
            child: Text('返回'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ));
  }
}
