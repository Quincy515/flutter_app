import 'package:get/get.dart';

class HomeController extends GetxController {
  //TODO: Implement HomeController

  final count = 0.obs;
  var currentIndex = 0.obs;
  var checked = false.obs;
  var toggleSwitchChecked = false.obs;
  var slider = 100.0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
  void changeCurrentIndex(i) => currentIndex.value = i;
  void changeChecked(i) => checked.value = i;
  void changeToggleSwitchChecked(i) => toggleSwitchChecked.value = i;
  void changeSlider(i) => slider.value = i;
}
