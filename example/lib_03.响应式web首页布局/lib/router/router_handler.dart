import 'package:fluro/fluro.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopping_mall/page/index.dart';

Handler rootHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  // return IndexPage();
  return HomePage();
});

Handler homeHandler =
    Handler(handlerFunc: (BuildContext context, Map<String, dynamic> params) {
  return HomePage();
});
