import 'package:flutter/material.dart';
import 'dart:ui';

class FrostedClassDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // 重叠的Stack Widget，实现重贴
        children: <Widget>[
          ConstrainedBox(
            // 约束盒子组件，添加额外的约束条件 child 上
            constraints: const BoxConstraints.expand(), //限制条件，可扩展的。
            child: Image.network(
                'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1545738629147&di=22e12a65bbc6c4123ae5596e24dbc5d3&imgtype=0&src=http%3A%2F%2Fpic30.photophoto.cn%2F20140309%2F0034034413812339_b.jpg'),
          ),
          Center(
            child: ClipRect(
              // 可裁切的矩形
              child: BackdropFilter(
                // 背景过滤器
                filter: ImageFilter.blur(
                    sigmaX: 5.0, sigmaY: 5.0), //图片模糊过滤，横向竖向都设置5.0
                child: Opacity(
                  opacity: 0.5,
                  child: Container(
                    // 容器组件
                    width: 500.0,
                    height: 700.0,
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200), // 深度200灰色的盒子修饰器
                    child: Center(
                      child: Text('毛玻璃效果',
                          style: Theme.of(context).textTheme.bodyText2),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
