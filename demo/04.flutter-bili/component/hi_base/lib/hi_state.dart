import 'package:flutter/material.dart';

// 有网络请求和异步处理的 StatefulWidget 继承它
abstract class HiState<T extends StatefulWidget> extends State<T> {
  @override
  void setState(fn) {
    if (mounted) {
      super.setState(fn); // 判断页面有没有被装载
    } else {
      print('HiState: 页面已销毁，本次 setState 不执行:${toString()}');
    }
  }
}
