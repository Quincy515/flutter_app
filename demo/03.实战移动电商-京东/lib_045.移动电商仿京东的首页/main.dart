import 'package:flutter/material.dart';
import 'package:flutter_app/page/index_page.dart';
import 'package:flutter_app/provide/index_provide.dart';
import 'package:flutter_app/provide/theme_provide.dart';
import 'package:provider/provider.dart';

void main() => runApp(
      MultiProvider(
        providers: providers,
        child: MyApp(),
      ),
    );

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter-JD',
      debugShowCheckedModeBanner: false,
      theme: Provider
          .of<ThemeProvide>(context, listen: true)
          .themeData,
      home: IndexPage(),
    );
  }
}
