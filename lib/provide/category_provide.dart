import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/model/category_content_model.dart';

class CategoryPageProvide with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = '';
  List<String> categoryNavList = [];
  List<CategoryContentModel> categoryContentList = [];
  int tabIndex = 0;

  // 获取分类目录
  loadCategoryPageData() {
    isLoading = true;
    isError = false;
    errorMsg = '';
    Http().request(Api.CATEGORY_NAV).then((value) {
      isLoading = false;
      // print('获取分类目录=========>${value.data}');
      if (value.data is List) {
        for (var i = 0; i < value.data.length; i++) {
          categoryNavList.add(value.data[i]);
        }
        loadCategoryContentData(this.tabIndex);
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });
  }

  // 获取指定分类的内容
  loadCategoryContentData(int index) {
    this.tabIndex = index;
    isLoading = true;
    categoryContentList.clear(); // 先清空
    var data = {'title': categoryNavList[index]}; // 请求的数据
    Http()
        .request(Api.CATEGORY_CONTENT, data: data, method: 'post')
        .then((value) {
      isLoading = false;
      // print('获取指定分类的内容=========>${value.data}');
      if (value.data is List) {
        for (var item in value.data) {
          CategoryContentModel tmpModel = CategoryContentModel.fromJson(item);
          categoryContentList.add(tmpModel);
        }
      }
      notifyListeners();
    }).catchError((error) {
      print(error);
      errorMsg = error;
      isLoading = false;
      isError = true;
      notifyListeners();
    });

    notifyListeners();
  }
}
