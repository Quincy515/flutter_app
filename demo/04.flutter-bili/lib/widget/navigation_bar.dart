// 可自定义样式的沉浸式导航栏
import 'package:e_social_work/provider/index.dart';
import 'package:e_social_work/util/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';
import 'package:provider/provider.dart';

enum StatusStyle { LIGHT_CONTENT, DARK_CONTENT }

// 可自定义样式的沉浸式导航栏
class NavigationBar extends StatefulWidget {
  final StatusStyle statusStyle; // 样式
  final Color color; // 颜色
  final double height; // 高度
  final Widget child;

  const NavigationBar(
      {Key key,
      this.statusStyle = StatusStyle.DARK_CONTENT,
      this.color = Colors.white,
      this.height = 46,
      this.child})
      : super(key: key);

  @override
  _NavigationBarState createState() => _NavigationBarState();
}

class _NavigationBarState extends State<NavigationBar> {
  var _statusStyle;
  var _color;

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    if (themeProvider.isDark()) {
      _color = HiColor.dark_bg;
      _statusStyle = StatusStyle.LIGHT_CONTENT;
    } else {
      _color = widget.color;
      _statusStyle = widget.statusStyle;
    }

    _statusBarInit();
    // 状态栏高度
    var top = MediaQuery.of(context).padding.top;
    return Container(
      width: MediaQuery.of(context).size.width, // 取屏幕的宽度
      height: top + widget.height,
      child: widget.child,
      padding: EdgeInsets.only(top: top),
      decoration: BoxDecoration(color: _color),
    );
  }

  void _statusBarInit() {
    // 沉浸式状态栏样式
    changeStatusBar(color: _color, statusStyle: _statusStyle);
  }
}
