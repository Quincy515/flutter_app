import 'package:flutter/material.dart';

// 使用 mixin 混入 ChangeNotifier，这个类能够帮驻我们自动管理所有听众
class Counter with ChangeNotifier{
  int _count = 0; // 声明私有 int 类型的 _count
  int get value => _count; // 通过 get value 把 _count 值暴露出来

  void increment() {
    _count++; // 提供 increment 方法用于更改数据
    notifyListeners(); // 当调用 notifyListeners() 时，它会通知所有听众进行刷新。
  }
}