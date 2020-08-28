import 'package:flutter/material.dart';

class BottomNaviProvide with ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(int newIndex) {
    if (this.currentIndex != newIndex) {
      currentIndex = newIndex;
      notifyListeners();
    }
  }
}
