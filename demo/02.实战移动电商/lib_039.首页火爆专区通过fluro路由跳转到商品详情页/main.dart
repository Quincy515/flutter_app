import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './provider/category_goods_list.dart';
import './provider/child_category.dart';
import './provider/counter.dart';
import './routers/application.dart';
import './routers/routes.dart';
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
        ChangeNotifierProvider(create: (_) => CategoryGoodsListProvide()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final router = fluro.Router();
    Routes.configureRoutes(router);
    Application.router = router;
    return Container(
      child: MaterialApp(
        title: '百姓生活+',
        onGenerateRoute: Application.router.generator, // route 加入到整个 App 上
        debugShowCheckedModeBanner: false, // 去除 debug 图标
        theme: ThemeData(
          primaryColor: Colors.pinkAccent, // 设置主题(主要颜色)
        ),
        home: IndexPage(),
      ),
    );
  }
}
