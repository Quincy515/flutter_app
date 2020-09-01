import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/page/cart_page.dart';
import 'package:flutter_app/page/category_page.dart';
import 'package:flutter_app/page/home_page.dart';
import 'package:flutter_app/page/user_page.dart';
import 'package:flutter_app/provide/bottom_navi_provide.dart';
import 'package:provider/provider.dart';

class IndexPage extends StatelessWidget {
  final List<BottomNavigationBarItem> bottomTabs = [
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.home), label: '首页'),
    BottomNavigationBarItem(icon: Icon(CupertinoIcons.search), label: '分类'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.shopping_cart), label: '购物车'),
    BottomNavigationBarItem(
        icon: Icon(CupertinoIcons.profile_circled), label: '我的'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomNaviProvide>(
      builder: (context, t, child) => Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: t.currentIndex,
          items: bottomTabs,
          onTap: (index) {
            t.changeIndex(index);
          },
        ),
        body: IndexedStack(
          index: t.currentIndex, // 层布局控件 只显示一个
          children: <Widget>[
            HomePage(),
            CategoryPage(),
            CartPage(),
            UserPage(),
          ],
        ),
      ),
    );
  }
}
