import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../model/category.dart';
import '../model/categoryGoodsList.dart';
import '../provider/category_goods_list.dart';
import '../provider/child_category.dart';
import '../service/service_method.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('商品分类'),
      ),
      body: Container(
        child: Row(
          children: <Widget>[
            LeftCategoryNav(),
            Column(
              children: <Widget>[
                RightCategoryNav(),
                CategoryGoodsList(),
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
  var listIndex = 0; // 被点击的显示

  @override
  void initState() {
    _getCategory();
    _getGoodsList();
    super.initState();
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
    bool isClick = false; // 是否被点击了
    isClick = (index == listIndex) ? true : false;
    return InkWell(
      onTap: () {
        setState(() {
          listIndex = index; // 点击就更新索引
        });
        var childList = list[index].bxMallSubDto; // 获取点击该一级分类得到对应的二级分类
        var categoryId = list[index].mallCategoryId;
        context.read<ChildCategory>().getChildCategory(childList,
            categoryId); // 调用状态管理的getChildCategory方法更新状态childCategoryList
        _getGoodsList(categoryId: categoryId);
      },
      child: Container(
        height: ScreenUtil().setHeight(100),
        padding: EdgeInsets.only(left: 10, top: 20),
        decoration: BoxDecoration(
          color: isClick ? Color.fromRGBO(236, 236, 236, 1.0) : Colors.white,
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
      context
          .read<ChildCategory>()
          .getChildCategory(list[0].bxMallSubDto, list[0].mallCategoryId);
    });
  }

  // 切换大类 可选的分类 id
  void _getGoodsList({String categoryId}) async {
    var data = {
      'categoryId': categoryId == null ? '4' : categoryId, // 大类ID
      'categorySubId': "",
      'page': 1,
    };

    await request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString()); // 从字符串或 map 转换成 model 类
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      context
          .read<CategoryGoodsListProvide>()
          .getGoodsList(goodsList.data); // 改变列表状态
    });
  }
}

class RightCategoryNav extends StatefulWidget {
  @override
  _RightCategoryNavState createState() => _RightCategoryNavState();
}

class _RightCategoryNavState extends State<RightCategoryNav> {
//  List list = [ '名酒', '宝丰', '北京二锅头' ]; // UI 布局使用假数据

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
        itemCount: context.watch<ChildCategory>().childCategoryList.length,
        itemBuilder: (context, index) {
          return _rightInkWell(
              index, context.watch<ChildCategory>().childCategoryList[index]);
        },
      ),
    );
  }

  // 先写小的布局还是大的布局都可以
  Widget _rightInkWell(int index, BxMallSubDto item) {
    bool isClick = false; // 是否已经点击
    isClick =
        (index == context.read<ChildCategory>().childIndex) ? true : false;
    return InkWell(
      onTap: () {
        context.read<ChildCategory>().changeChildIndex(index); // 改变状态高亮显示
        _getGoodsList(item.mallSubId);
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
        child: Text(
          item.mallSubName,
          style: TextStyle(
              color: isClick ? Colors.pink : Colors.black,
              fontSize: ScreenUtil().setSp(26)),
        ),
      ),
    );
  }

  // 切换小类 必选的分类 id
  void _getGoodsList(String categorySubId) async {
    var data = {
      'categoryId': context
          .read<ChildCategory>()
          .categoryId, // 大类ID
      'categorySubId': categorySubId,
      'page': 1,
    };

    await request('getMallGoods', formData: data).then((value) {
      var data = json.decode(value.toString()); // 从字符串或 map 转换成 model 类
      CategoryGoodsListModel goodsList = CategoryGoodsListModel.fromJson(data);
      context
          .read<CategoryGoodsListProvide>()
          .getGoodsList(goodsList.data); // 改变列表状态
    });
  }
}

// 商品分类的商品列表,可以上拉加载
class CategoryGoodsList extends StatefulWidget {
  @override
  _CategoryGoodsListState createState() => _CategoryGoodsListState();
}

class _CategoryGoodsListState extends State<CategoryGoodsList> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final goodsList =
        context.select((CategoryGoodsListProvide p) => p.goodsList);
    return Expanded(
      // 有伸缩能力的组件继承于 Flexible
      child: Container(
        width: ScreenUtil().setWidth(570), // 去掉 height 使用 Expanded 解决高度溢出
        child: ListView.builder(
            itemCount: goodsList.length,
            itemBuilder: (context, index) {
              return _listItemWidget(goodsList, index);
            }),
      ),
    );
  }

  // 商品图片小控件
  Widget _goodsImage(List newList, index) {
    return Container(
      width: ScreenUtil().setWidth(200),
      child: Image.network(newList[index].image),
    );
  }

  // 商品名称的小控件
  Widget _goodsName(List newList, index) {
    return Container(
        padding: EdgeInsets.all(5.0), // 上下左右外边距都设置为5
        width: ScreenUtil().setWidth(370),
        child: Text(
          newList[index].goodsName,
          maxLines: 2, // 最大两行
          overflow: TextOverflow.ellipsis, // 超过两行显示省略号
          style: TextStyle(fontSize: ScreenUtil().setSp(28)), //字体大小
        ));
  }

  // 商品价格的小控件
  Widget _goodsPrice(List newList, index) {
    return Container(
      margin: EdgeInsets.only(top: 20.0),
      width: ScreenUtil().setWidth(370),
      child: Row(
        children: <Widget>[
          Text(
            '价格：￥${newList[index].presentPrice}',
            style:
                TextStyle(color: Colors.pink, fontSize: ScreenUtil().setSp(30)),
          ),
          Text(
            '￥${newList[index].oriPrice}',
            style: TextStyle(
                color: Colors.black26, decoration: TextDecoration.lineThrough),
          ),
        ],
      ),
    );
  }

  // 上面三个小控件组成的商品item的控件
  Widget _listItemWidget(List newList, int index) {
    return InkWell(
      onTap: () {},
      child: Container(
        padding: EdgeInsets.only(top: 5.0, bottom: 5.0),
        decoration: BoxDecoration(
          color: Colors.white, // 背景
          border: Border(
            bottom: BorderSide(width: 1.0, color: Colors.black12), // 底边
          ),
        ),
        child: Row(
          // 先横向布局
          children: <Widget>[
            _goodsImage(newList, index),
            Column(
              // 然后是列布局
              children: <Widget>[
                _goodsName(newList, index),
                _goodsPrice(newList, index),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
