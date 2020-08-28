import 'package:flutter/material.dart';
import 'package:flutter_app/provide/theme_provide.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('分类'),
        actions: <Widget>[
          Padding(
              padding: EdgeInsets.only(right: 15),
              child: InkWell(
                onTap: () {
                  Provider.of<ThemeProvide>(context, listen: false).change();
                },
                child: Icon(Icons.brightness_4),
              )),
        ],
      ),
    );
  }
}
