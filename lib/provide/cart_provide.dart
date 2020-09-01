import 'dart:convert';

import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/model/product_detail_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartProvide with ChangeNotifier {
  List<PartData> models = []; // 本地存储
  bool isSelectAll = false;

  Future<Widget> addToCart(PartData data) async {
    // print(data.toJson());
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];

    // list.add(json.encode(data.toJson()));
    // // 存入缓存
    // prefs.setStringList('cartInfo', list);
    // // 取出缓存
    // list = prefs.getStringList('cartInfo');
    // print('持久化存储字符串数组=======>${list}');

    // 先把缓存的数据取出来
    list = prefs.getStringList('cartInfo');
    models.clear();

    // 判断取出的list是否有内容
    if (list == null) {
      print('缓存中没有任何商品数据，${data.toJson()}');
      list = List<String>(); // list 为 null 时先初始化为 List<String>
      list.add(json.encode(data.toJson())); // 放入数组
      prefs.setStringList('cartInfo', list); // 存入缓存
      models.add(data); // 更新本地数据
      notifyListeners(); // 通知听众
    } else {
      print('缓存中有商品数据');
      List<String> tmpList = []; // 定义临时数组
      bool isUpdated = false; // 判断缓存中是否有对象的商品

      // 遍历缓存数组
      for (var i = 0; i < list.length; i++) {
        PartData tmpData =
            PartData.fromJson(json.decode(list[i])); // 把数组中的每个数据拿出来变成模型类
        if (tmpData.id == data.id) {
          tmpData.count = data.count; // 修改商品数量
          isUpdated = true; // 判断商品 id
        }

        String tmpDataStr = json.encode(tmpData.toJson()); // 放入数组中
        tmpList.add(tmpDataStr);
        models.add(tmpData);
      }

      // 如果缓存里的数组，没有现在添加的商品，那么直接添加
      if (isUpdated == false) {
        String str = json.encode(data.toJson());
        tmpList.add(str);
        models.add(data);
      }

      prefs.setStringList('cartInfo', tmpList); // 放入缓存
      notifyListeners(); // 通知听众
    }
  }

  // 获取购物车商品的数量
  int getAllCount() {
    int count = 0;
    for (PartData data in this.models) {
      count += data.count;
    }
    return count;
  }

  // 获取购物车商品
  void getCartList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    // 取出缓存
    list = prefs.getStringList('cartInfo');
    if (list != null) {
      for (var i = 0; i < list.length; i++) {
        PartData tmpData = PartData.fromJson(json.decode(list[i]));
        models.add(tmpData);
      }
      notifyListeners();
    }
  }

  // 删除商品
  void removeFromCart(String id) async {
    // 从缓存中删除
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> list = [];
    list = prefs.getStringList('cartInfo'); // 取出缓存
    for (var i = 0; i < list.length; i++) {
      PartData tmpData = PartData.fromJson(json.decode(list[i]));
      if (tmpData.id == id) {
        list.remove(list[i]); // 遍历缓存数据
        break;
      }
    }

    // 从本地数据中删除
    for (var i = 0; i < models.length; i++) {
      if (this.models[i].id == id) {
        this.models.remove(this.models[i]); // 遍历本地数据
        break;
      }
    }

    // 缓存重新赋值
    prefs.setStringList('cartInfo', list);
    notifyListeners();
  }

  // 选中状态
  void changeSelectId(String id) {
    // print(id);
    int tmpCount = 0;
    for (var i = 0; i < this.models.length; i++) {
      if (id == this.models[i].id) {
        this.models[i].isSelected = !this.models[i].isSelected;
      }
      if (this.models[i].isSelected) {
        tmpCount++;
      }
    }

    // 如果 tmpCount 个数和 models.length 相同，则是全选状态
    if (tmpCount == this.models.length) {
      this.isSelectAll = true;
    } else {
      this.isSelectAll = false;
    }

    notifyListeners();
  }

  // 全选
  void changeSelectAll() {
    isSelectAll = !isSelectAll; // 切换选中的状态
    for (var i = 0; i < this.models.length; i++) {
      this.models[i].isSelected = isSelectAll; // 更新选中的状态
    }
    notifyListeners();
  }

  // 统计合计金额
  String getAmount() {
    String amountStr = '0.00';
    for (var i = 0; i < this.models.length; i++) {
      if (this.models[i].isSelected == true) {
        num price = this.models[i].count *
            NumUtil.getNumByValueStr(this.models[i].price,
                fractionDigits: 2); // 数字乘以字符串，使用插件
        num amount = NumUtil.getNumByValueStr(amountStr, fractionDigits: 2);
        amountStr = NumUtil.add(amount, price).toString();
      }
    }

    return amountStr;
  }

  // 统计选中商品个数
  int getSelectedCount() {
    int selectedCount = 0;
    for (var i = 0; i < this.models.length; i++) {
      if (this.models[i].isSelected == true) {
        selectedCount++;
      }
    }
    return selectedCount;
  }
}
