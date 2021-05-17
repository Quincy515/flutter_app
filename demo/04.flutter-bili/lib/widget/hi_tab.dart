import 'package:e_social_work/provider/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';
import 'package:provider/provider.dart';

// tab 切换组件
class HiTab extends StatelessWidget {
  final List<Widget> tabs; // 切换显示的 widget
  final TabController controller; // 控制器
  final double fontSize; // 文字大小
  final double borderWidth;
  final double insets;
  final Color unselectedLabelColor;

  const HiTab(this.tabs,
      {Key key,
      this.controller,
      this.fontSize = 13,
      this.borderWidth = 2,
      this.insets = 15,
      this.unselectedLabelColor = Colors.grey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var themeProvider = context.watch<ThemeProvider>();
    var _unselectedLabelColor =
        themeProvider.isDark() ? Colors.white70 : unselectedLabelColor;
    return TabBar(
      controller: controller,
      isScrollable: true, // 是否可以滚动
      labelColor: primary, // 显示颜色
      unselectedLabelColor: _unselectedLabelColor, // 未选中颜色
      labelStyle: TextStyle(fontSize: fontSize), // 文字大小
      indicator: UnderlineTabIndicator(
        borderSide: BorderSide(color: primary, width: borderWidth),
        insets: EdgeInsets.only(left: insets, right: insets),
      ), // 默认的指示器，非圆角
      tabs: tabs,
    );
  }
}
