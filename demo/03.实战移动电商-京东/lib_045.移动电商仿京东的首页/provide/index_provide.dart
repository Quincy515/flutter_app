import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/provide/bottom_navi_provide.dart';
import 'package:flutter_app/provide/theme_provide.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildStatelessWidget> providers = [
  Provider<Api>(create: (_) => Api()),
  ChangeNotifierProvider<ThemeProvide>(
      create: (_) => ThemeProvide(
            themeType: ThemeType.dark,
            themeData: ThemeData.dark(),
          )),
  // ChangeNotifierProvider(create: (_) => BottomNaviProvide()),
  ChangeNotifierProvider.value(value: BottomNaviProvide()),
];
