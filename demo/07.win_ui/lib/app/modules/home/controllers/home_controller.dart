// ignore_for_file: unnecessary_overrides

import 'package:fluent_ui/fluent_ui.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  var currentIndex = 0.obs;
  var checked = false.obs;
  var toggleSwitchChecked = false.obs;
  var slider = 100.0.obs;
  var comboboxList = [].obs;
  var movieText = TextEditingController().obs;

  String? _comboxBox;

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

  get comboxBox => _comboxBox;
  set comboxBox(value) {
    _comboxBox = value;
    update();
  }

  String addMovie() {
    var res = '';
    if (movieText.value.text == '') return res = '空';
    comboboxList.add(movieText.value.text);
    movieText.value.text = '';
    res = 'Saved!';
    update();
    return res;
  }
}
