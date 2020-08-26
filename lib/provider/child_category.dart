import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引
  String categoryId = '4'; // 大类ID默认设置为白酒
  String subId = ''; // 小类 ID
  int page = 1; // 列表页数
  String noMoreText = ''; // 默认为空,显示没有数据的文字

  // 大类切换逻辑
  getChildCategory(List<BxMallSubDto> list, String id) {
    page = 1; // 切换大类，页数要置为1
    noMoreText = '';
    childIndex = 0; // 点击大类的时候子类索引归零
    categoryId = id; // 切换大类ID

    BxMallSubDto all = BxMallSubDto();
    all.mallSubId = '00';
    all.mallCategoryId = '00';
    all.mallSubName = '全部';
    all.comments = 'null';
    childCategoryList = [all]; // 在子类别前面添加全部
    childCategoryList.addAll(list);
    notifyListeners();
  }

  // 改变子类索引
  changeChildIndex(index, String id) {
    page = 1; // 切换小类，页数要置为1
    noMoreText = '';
    childIndex = index; // 改变子类索引赋值给状态就可以了
    subId = id; // 记录状态子类 ID
    notifyListeners();
  }

  // 下拉不断增加 page 的方法
  addPage() {
    page++;
  }

  // 改变没有数据的显示
  changeNoMore(String text) {
    noMoreText = text;
    notifyListeners();
  }
}
