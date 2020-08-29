import 'package:flutter/material.dart';
import 'package:flutter_app/config/api.dart';
import 'package:flutter_app/model/home_model.dart';

class HomePageProvide with ChangeNotifier {
  HomePageModel model;
  bool isLoading = false;
  bool isError = false;
  String errorMsg = "";

  loadHomePageData() async {
    isLoading = true;
    isError = false;
    errorMsg = "";
    Http().request(Api.HOME_PAGE).then((value) {
      isLoading = false;
      if (value.code == 200) {
        print(value.data);
        model = HomePageModel.fromJson(value.data);
        print(model.toJson());
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
