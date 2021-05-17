import 'package:e_social_work/navigator/hi_navigator.dart';
import 'package:e_social_work/page/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';

// 底部导航
class BottomNavigator extends StatefulWidget {
  const BottomNavigator({Key key}) : super(key: key);

  @override
  _BottomNavigatorState createState() => _BottomNavigatorState();
}

class _BottomNavigatorState extends State<BottomNavigator> {
  final _defaultColor = Colors.grey; // 底部导航的默认颜色
  final _activeColor = primary; // 底部导航激活的颜色
  int _currentIndex = 0; // 当前打开的是哪个 tab
  static int initialPage = 0; // 当前打开的是哪个 tab
  final PageController _controller =
      PageController(initialPage: initialPage); // 默认打开哪个页面
  List<Widget> _pages;
  bool _hasBuild = false;

  @override
  Widget build(BuildContext context) {
    _pages = [
      HomePage(
        onJumpTo: (index) => _onJumpTo(index, pageChange: false),
      ),
      CoursePage(),
      MessagePage(),
      ProfilePage(),
    ];

    if (!_hasBuild) {
      // 页面第一次打开时通知打开的是哪个 tab
      HiNavigator.getInstance()
          .onBottomTabChange(initialPage, _pages[initialPage]);
      _hasBuild = true;
    }

    return Scaffold(
      body: PageView(
        controller: _controller,
        children: _pages,
        onPageChanged: (index) => _onJumpTo(index, pageChange: true),
        physics: NeverScrollableScrollPhysics(), // 禁止默认的 PageView 页面滚动功能
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => _onJumpTo(index),
        type: BottomNavigationBarType.fixed,
        // 未选中时也显示名称
        selectedItemColor: _activeColor,
        // 选中时的激活颜色
        items: [
          _bottomItem('首页', Icons.home, 0),
          _bottomItem('课程', Icons.school, 1),
          _bottomItem('消息', Icons.email, 2),
          _bottomItem('我的', Icons.person, 3),
        ],
      ),
    );
  }

  // 构造底部图标的名字，图标，索引
  _bottomItem(String title, IconData icon, int index) {
    return BottomNavigationBarItem(
      icon: Icon(icon, color: _defaultColor),
      activeIcon: Icon(icon, color: _activeColor),
      label: title,
    );
  }

  void _onJumpTo(int index, {pageChange = false}) {
    if (!pageChange) {
      // 让 PageView 展示对应的 tab
      _controller.jumpToPage(index);
    } else {
      HiNavigator.getInstance().onBottomTabChange(index, _pages[index]);
    }
    setState(() {
      // 控制选中的是第几个 tab
      _currentIndex = index;
    });
  }
}
