import 'package:get/get.dart';

import 'info_controller.dart';

class InfoBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<InfoController>(
      () => InfoController(),
    );
  }
}
