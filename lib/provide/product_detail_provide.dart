import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/model/product_detail_model.dart';

class ProductDetailProvide with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  ProductDetailModel model;

  loadProduct({String id}) async {
    isLoading = true;
    isError = false;
    errorMsg = "";
    Http().request(Api.PRODUCTIONS_DETAIL).then((value) {
      isLoading = false;
      if (value.code == 200 && value.data is List) {
        for (var item in value.data) {
          ProductDetailModel tmpModel = ProductDetailModel.fromJson(item);
          if (tmpModel.partData.id == id) {
            model = tmpModel;
            // print('ProductDetailProvide===>${model.toJson()}');
          }
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
  }

  // 分期切换
  void changeBaitiaoSelected(int index) {
    if (this.model.baitiao[index].select == false) {
      for (int i = 0; i < this.model.baitiao.length; i++) {
        if (i == index) {
          this.model.baitiao[i].select = true;
        } else {
          this.model.baitiao[i].select = false;
        }
      }
      notifyListeners();
    }
  }

  // 数量赋值
  void changeProductCount(int count) {
    if (count > 0 && this.model.partData.count != count) {
      this.model.partData.count = count;
      notifyListeners();
    }
  }
}
