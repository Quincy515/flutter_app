import 'package:get/get.dart';

class LoginController extends GetxController {
  final count = 0.obs;
  var name = 'custer';

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

  void changUser() {
    name = 'admin';
    update(['userName']);
  }
}
