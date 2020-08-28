import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/cart_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  String cartString = "[]"; // 存储持久化
  List<CartInfoModel> cartList = []; // 购物车列表
  double allPrice = 0; // 购物车商品总价格
  int allGoodsCount = 0; // 购物车商品总数
  bool isAllCheck = true; // 是否全部选中

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast(); // 强制转成 List
    bool isHave = false;
    int ival = 0;
    allPrice = 0; // 初始化
    allGoodsCount = 0;
    // 循环判断目前购物车里有没有要添加的这个商品
    tempList.forEach((element) {
      if (element['goodsId'] == goodsId) {
        tempList[ival]['count'] = element['count'] + 1;
        cartList[ival].count++; // 购物车数据模型+1
        isHave = true; // 如果已经有了就把商品数量+1
      }
      if (element['isCheck']) {
        allPrice += (cartList[ival].price * cartList[ival].count);
        allGoodsCount += cartList[ival].count;
      }
      ival++;
    });

    if (!isHave) {
      Map<String, dynamic> newGoods = {
        'goodsId': goodsId, // 如果没有就把该商品加入到购物车中
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images,
        'isCheck': true,
      };
      tempList.add(newGoods);
      cartList.add(CartInfoModel.fromJson(newGoods)); // 购物车数据模型
      allPrice += (count * price);
      allGoodsCount += count;
    }

    cartString = json.encode(tempList).toString(); // 先把list转换成字符串
    print('字符串》》》》》》》》${cartString}');
    print('数据模型》》》》》》》》${cartList}');
    await prefs.setString('cartInfo', cartString); // 再把字符串持久化
    notifyListeners();
  }

  // 删除购物车中的商品
  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = []; // 清空数据模型
    allPrice = 0;
    allGoodsCount = 0;
    print('清空购物车完成');
    notifyListeners();
  }

  // 得到购物车中的商品
  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString =
        prefs.getString('cartInfo'); // 1. 从持久化中获得字符串,获得购物车中的商品,这时候是一个字符串
    cartList = []; // 把cartList进行初始化，防止数据混乱
    if (cartString == null) {
      cartList = []; // 没有 key 值
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List)
          .cast(); // 2. String 转为 List<Map>
      allPrice = 0; // 初始化商品总数量和总价格
      allGoodsCount = 0;
      isAllCheck = true;
      tempList.forEach((element) {
        if (element['isCheck']) {
          allPrice += (element['count'] * element['price']);
          allGoodsCount += element['count'];
        } else {
          isAllCheck = false;
        }
        cartList.add(CartInfoModel.fromJson(element)); // 3. 进行循环转变为对象保存到数据模型
      });
    }
    notifyListeners();
  }

  // 删除单个购物车商品
  deleteOneGoods(String goodsId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); // 1. 从持久化中获得字符串
    List<Map> tempList = (json.decode(cartString.toString()) as List)
        .cast(); // 2. String 转为 List<Map>
    int tempIndex = 0; // 定义循环所需的索引
    int delIndex = 0; // 定义删除的索引项
    tempList.forEach((element) {
      if (element['goodsId'] == goodsId) {
        delIndex = tempIndex; // 找到要删除的索引
      }
      tempIndex++;
    });

    tempList.removeAt(delIndex); // 删除的索引值
    cartString = json.encode(tempList).toString(); // List<Map>转成String
    prefs.setString('cartInfo', cartString); // 持久化
    await getCartInfo(); // 刷新列表
  }

  //修改选中状态
  changeCheckState(CartInfoModel cartItem) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); // 1. 从持久化中获得字符串
    List<Map> tempList = (json.decode(cartString.toString()) as List)
        .cast(); // 2. String 转为 List<Map>
    int tempIndex = 0; // 定义循环所需的索引
    int changeIndex = 0; // 定义需要切换的索引
    tempList.forEach((element) {
      // dart在循环中不能修改循环项
      if (element['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex; // 先确定索引值
      }
      tempIndex++;
    });
    tempList[changeIndex] = cartItem.toJson(); // 在外部修改
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 点击全选按钮操作
  changeAllCheckBtnState(bool isCheck) async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //初始化SharedPreferences
    cartString = prefs.getString('cartInfo'); // 1. 从持久化中获得字符串
    List<Map> tempList = (json.decode(cartString.toString()) as List)
        .cast(); // 2. String 转为 List<Map>
    List<Map> newList = []; // 声明新的 List，因为在 Dart 循环中不允许修改循环项
    for (var item in tempList) {
      var newItem = item; // 把循环项赋值给新的 List
      newItem['isCheck'] = isCheck; // 改变新的 List 中 isCheck 字段
      newList.add(newItem); // 添加到新的 List 中
    }
    cartString = json.encode(newList).toString(); // 持久化变成字符串
    prefs.setString('cartInfo', cartString);
    await getCartInfo();
  }

  // 增加或减少数量的操作
  addOrReduceAction(var cartItem, String todo) async {
    SharedPreferences prefs =
        await SharedPreferences.getInstance(); //初始化SharedPreferences
    cartString = prefs.getString('cartInfo'); // 1. 从持久化中获得字符串
    List<Map> tempList = (json.decode(cartString.toString()) as List)
        .cast(); // 2. String 转为 List<Map>
    int tempIndex = 0;
    int changeIndex = 0;
    tempList.forEach((element) {
      if (element['goodsId'] == cartItem.goodsId) {
        changeIndex = tempIndex; // 找到索引值
      }
      tempIndex++;
    });
    if (todo == 'add') {
      cartItem.count++;
    } else if (cartItem.count > 1) {
      cartItem.count--;
    }
    tempList[changeIndex] = cartItem.toJson(); // 把 Json 变成 Map
    cartString = json.encode(tempList).toString();
    prefs.setString('cartInfo', cartString); // 持久化
    await getCartInfo();
  }
}
