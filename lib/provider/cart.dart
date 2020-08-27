import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvider with ChangeNotifier {
  String cartString = "[]"; // 存储持久化

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
        isHave = true; // 如果已经有了就把商品数量+1
      }
      ival++;
    });

    if (!isHave) {
      tempList.add({
        'goodsId': goodsId, // 如果没有就把该商品加入到购物车中
        'goodsName': goodsName,
        'count': count,
        'price': price,
        'images': images
      });
    }

    cartString = json.encode(tempList).toString(); // 先把list转换成字符串
    print(cartString);
    await prefs.setString('cartInfo', cartString); // 再把字符串持久化
    notifyListeners();
  }

  remove() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove('cartInfo');
    print('清空购物车完成');
    notifyListeners();
  }
}
