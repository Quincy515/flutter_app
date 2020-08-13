import 'package:flutter/material.dart';

// 主方法，入口
void main() => runApp(MyApp());

// MyApp 继承无状态组件 StatelessWidget
class MyApp extends StatelessWidget {
  @override // 重写
  Widget build(BuildContext context) {
    return MaterialApp(
        // 返回 MaterialApp 组件
        title: 'Text widget',
        home: Scaffold(
            appBar: AppBar(title: Text('Welcome to Fultter 欢迎')),
            body: Center(
              child: Container(
                child: new Image.network(
                  'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl-2.jpg',
                  // fit: BoxFit.cover,
                  color: Colors.greenAccent,
                  colorBlendMode: BlendMode.darken, // 图片混合模式
                  repeat: ImageRepeat.repeat,
                ),
                width: 300.0,
                height: 200.0,
                color: Colors.lightBlue,
              ),
            )));
  }
}

// 使用命令行在项目更目录下运行 flutter run
// p 键显示网格
// o 键切换 ios、android、fuchsia
// r 键 重新加载或 vscode 运行 debug 模式
