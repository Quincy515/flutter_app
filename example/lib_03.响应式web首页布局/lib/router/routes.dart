import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:shopping_mall/router/router_handler.dart';

class Routes {
  static String root = '/';
  static String home = '/home';

  // 注册路由
  static void configureRoutes(fluro.FluroRouter router) {
    router.notFoundHandler = new fluro.Handler(// 未找到路由
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('页面走丢了~~');
      return;
    });

    // 配置路由
    router.define(root, handler: rootHandler);
    router.define(home, handler: homeHandler);
  }
}
