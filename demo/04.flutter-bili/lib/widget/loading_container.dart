import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

// 带 lottie 动画的加载进度条组件
class LoadingContainer extends StatelessWidget {
  final Widget child; // 当前页面
  final bool isLoading; // 变量控制是否显示 loading
  final bool cover; // 加载动画是否覆盖在原有界面上

  const LoadingContainer(
      {Key key, this.child, this.isLoading, this.cover = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (cover) {
      return Stack(
        children: [child, isLoading ? _loadingView : Container()],
      );
    } else {
      return isLoading ? _loadingView : child;
    }
  }

  Widget get _loadingView {
    return Center(child: Lottie.asset('assets/loading.json'));
  }
}
