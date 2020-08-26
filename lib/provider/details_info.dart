import 'dart:convert';

import 'package:flutter/material.dart';

import '../model/details.dart';
import '../service/service_method.dart';

class DetailsInfoProvide with ChangeNotifier {
  DetailsModel goodsInfo = null; // 商品详情变量

  // 从后台获取商品详情数据
  getGoodsInfo(String id) {
    var formData = {'goodId': id}; // 构造 Map 类型变量
    request('getGoodDetailById', formData: formData).then((value) {
      var responseData = json.decode(value.toString()); // 从后台获得的数据 decode 防止报错
      print(responseData);
      goodsInfo = DetailsModel.fromJson(responseData); // 把数据从 json 转换成 Model 对象
      notifyListeners(); // 通知操作
    });
  }
}
