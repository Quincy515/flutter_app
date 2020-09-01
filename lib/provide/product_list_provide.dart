import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/model/product_info_model.dart';

class ProductListProvide with ChangeNotifier {
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";
  List<ProductInfoModel> list = List();

  loadProductList() async {
    isLoading = true;
    isError = false;
    errorMsg = "";
    Http().request(Api.PRODUCTIONS_LIST).then((value) {
      isLoading = false;
      if (value.code == 200 && value.data is List) {
        // print('ProductListProvide===>${value.data}');
        for (var item in value.data) {
          ProductInfoModel tmpModel = ProductInfoModel.fromJson(item);
          list.add(tmpModel);
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
}
