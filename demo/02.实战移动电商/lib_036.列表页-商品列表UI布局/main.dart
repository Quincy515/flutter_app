import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/child_category.dart';
import './provider/counter.dart';
import 'pages/index_page.dart';

void main() {
//  runApp(MyApp());
  runApp(
    /// Providers are above [MyApp] instead of inside it, so that tests
    /// can use [MyApp] while mocking the providers
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => ChildCategory()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        debugShowCheckedModeBanner: false, // 去除 debug 图标
        theme: ThemeData(
          // 设置主题(主要颜色)
          primaryColor: Colors.pinkAccent,
        ),
        home: IndexPage(),
      ),
    );
  }
}
