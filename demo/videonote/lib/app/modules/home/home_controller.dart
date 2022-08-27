// ignore_for_file: unnecessary_overrides
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import '../../../ffi.dart';

class HomeController extends GetxController {
  final count = 0.obs;
  QuillController quillController = QuillController.basic();
  late Platform platform;
  late bool isRelease;

  TextEditingController videoTextController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    initPlatformInfo();
  }

  Future<void> initPlatformInfo() async {
    platform = await api.platform();
    isRelease = await api.rustReleaseMode();
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
