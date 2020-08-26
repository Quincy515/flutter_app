import 'package:flutter/material.dart';

import '../model/category.dart';

class ChildCategory with ChangeNotifier {
  List<BxMallSubDto> childCategoryList = [];
  int childIndex = 0; // 子类高亮索引

  getChildCategory(List<BxMallSubDto> list) {
    childIndex = 0; // 点击大类的时候子类索引归零
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
  changeChildIndex(index) {
    childIndex = index; // 改变子类索引赋值给状态就可以了
    notifyListeners();
  }
}
