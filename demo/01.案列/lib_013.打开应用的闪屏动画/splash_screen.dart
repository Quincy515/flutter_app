import 'package:flutter/material.dart';
import 'home_page.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller; // 控制动画的控制器（控制动画的时间等）
  Animation _animation; // 控制动画

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        vsync: this, // vsync 垂直动态演示
        duration: Duration(milliseconds: 3000));
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

    /**
     * 动画事件监听器
     * 它可以监听到动画的执行状态
     * 我们这里只监听动画是否结束
     * 如果结束则执行页面跳转动作
     */
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => MyHomePage()),
            (route) => route == null);
      }
    });
    // 播放动画
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      // 透明度动画组件
      opacity: _animation, // 执行动画
      child: Image.network(
          // 网络图片
          'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1597994860040&di=f8033e1b33714beb33ea98c72fb3a64c&imgtype=0&src=http%3A%2F%2Ft8.baidu.com%2Fit%2Fu%3D1484500186%2C1503043093%26fm%3D79%26app%3D86%26f%3DJPEG%3Fw%3D1280%26h%3D853',
          scale: 2.0, // 进行缩放
          fit: BoxFit.cover // 充满父容器
          ),
    );
  }
}
