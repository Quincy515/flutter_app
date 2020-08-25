import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../model/category.dart';
import '../service/service_method.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('商品分类'),),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// 左侧大类导航
class LeftCategoryNav extends StatefulWidget {
  @override
  _LeftCategoryNavState createState() => _LeftCategoryNavState();
}

class _LeftCategoryNavState extends State<LeftCategoryNav> {
  List list = [];

  @override
  void initState() {
    super.initState();
    _getCategory();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: ScreenUtil().setWidth(180),
      decoration: BoxDecoration(
          border: Border(right: BorderSide(width: 1, color: Colors.black12))),
      child: ListView.builder(
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _leftInkWell(index);
        },
      ),
    );
  }

  Widget _leftInkWell(int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(width: 1, color: Colors.black12),
          ),
        ),
        child: Text(
            list[index].mallCategoryName,
          style: TextStyle(fontSize: ScreenUtil().setSp(28)),
        ),
      ),
    );
  }

  // 分类接口
  void _getCategory() async {
    await request('getCategory').then((value) {
      var data = json.decode(value.toString());
      CategoryModel category = CategoryModel.fromJson(data);
//      list.data.forEach((element) { print(element.mallCategoryName); });
      setState(() {
        list = category.data;
      });
      print(data);
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
  List list = [
    '名酒',
    '宝丰',
    '北京二锅头',
    '茅台',
    '舍得',
    '五粮液',
    '白酒',
    '葡萄酒'
  ]; // UI 布局使用假数据

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(80),
      width: ScreenUtil().setWidth(570), // 横向列表要设置宽高
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(bottom: BorderSide(width: 1, color: Colors.grey)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: list.length,
        itemBuilder: (context, index) {
          return _rightInkWell(list[index]);
        },
      ),
    );
  }

  // 先写小的布局还是大的布局都可以
  Widget _rightInkWell(String item) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item,
          style: TextStyle(fontSize: ScreenUtil().setSp(26)),
        ),
      ),
    );
  }
}
