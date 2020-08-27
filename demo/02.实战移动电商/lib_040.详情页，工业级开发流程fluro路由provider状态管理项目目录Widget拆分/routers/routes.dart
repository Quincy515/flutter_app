import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';

import './router_handler.dart';

// 总体路由配置
class Routes {
  static String root = "/";
  static String detailsPage = "/detail";

  static void configureRoutes(fluro.Router router) {
    router.notFoundHandler = fluro.Handler(// 配置404
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('ERROR====>ROUTE WAS NOT FOUND!!!');
    });

    // 配置路由
    router.define(detailsPage, handler: detailsHandler);
  }
}
