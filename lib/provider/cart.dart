import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_app/model/cart_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  String cartString = "[]"; // 存储持久化
  List<CartInfoModel> cartList = []; // 购物车列表

  save(goodsId, goodsName, count, price, images) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo');
    var temp = cartString == null ? [] : json.decode(cartString.toString());
    List<Map> tempList = (temp as List).cast(); // 强制转成 List
    bool isHave = false;
    int ival = 0;
    // 循环判断目前购物车里有没有要添加的这个商品
    tempList.forEach((element) {
      if (element['goodsId'] == goodsId) {
        tempList[ival]['count'] = element['count'] + 1;
        cartList[ival].count++; // 购物车数据模型+1
        isHave = true; // 如果已经有了就把商品数量+1
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
    }

    cartString = json.encode(tempList).toString(); // 先把list转换成字符串
    print('字符串》》》》》》》》${cartString}');
    print('数据模型》》》》》》》》${cartList}');
    await prefs.setString('cartInfo', cartString); // 再把字符串持久化
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    cartList = []; // 清空数据模型
    print('清空购物车完成');
    notifyListeners();
  }

  getCartInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    cartString = prefs.getString('cartInfo'); // 1. 从持久化中获得字符串
    cartList = [];
    if (cartString == null) {
      // 没有 key 值
      cartList = [];
    } else {
      List<Map> tempList = (json.decode(cartString.toString()) as List)
          .cast(); // 2. String 转为 List<Map>
      tempList.forEach((element) {
        cartList.add(CartInfoModel.fromJson(element)); // 3. 进行循环转变为对象保存到数据模型
      });
    }
    notifyListeners();
  }
}
