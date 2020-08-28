import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:flutter_app/pages/index_page.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:flutter_app/provider/category_goods_list.dart';
import 'package:flutter_app/provider/child_category.dart';
import 'package:flutter_app/provider/counter.dart';
import 'package:flutter_app/provider/current_index.dart';
import 'package:flutter_app/provider/details_info.dart';
import 'package:flutter_app/routers/application.dart';
import 'package:flutter_app/routers/routes.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => Counter()),
        ChangeNotifierProvider(create: (_) => ChildCategory()),
        ChangeNotifierProvider(create: (_) => CategoryGoodsListProvide()),
        ChangeNotifierProvider(create: (_) => DetailsInfoProvide()),
        ChangeNotifierProvider(create: (_) => CartProvider()),
        ChangeNotifierProvider(create: (_) => CurrentIndexProvide()),
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
