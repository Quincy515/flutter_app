// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

class DashboardController extends GetxController {
  final count = 0.obs;
  final index = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  void increment() => count.value++;
  void setIndex(val) => index.value = val;
}
