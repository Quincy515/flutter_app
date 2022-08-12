// ignore_for_file: unnecessary_overrides

import 'package:get/get.dart';

import '../../../ffi.dart';

class InfoController extends GetxController {
  final count = 0.obs;
  late Future<Platform> platform;
  late Future<bool> isRelease;

  @override
  void onInit() {
    super.onInit();
    platform = api.platform();
    isRelease = api.rustReleaseMode();
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
}
