// ignore_for_file: unnecessary_overrides
import 'dart:ui' as ui;

import 'package:dart_vlc/dart_vlc.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';
import '../../../../ffi.dart';

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
    initDartVLC();
    getPlatform();
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

  final player = Player(
    id: 0,
    videoDimensions: const VideoDimensions(640, 360),
    registerTexture: false,
  ).obs;
  final mediaType = MediaType.file.obs;
  final current = CurrentState().obs;
  final position = PositionState().obs;
  final playback = PlaybackState().obs;
  final general = GeneralState().obs;
  final videoDimensions = const VideoDimensions(0, 0).obs;
  List<Media> medias = <Media>[].obs;
  List<Device> devices = <Device>[].obs;
  final bufferingProgress = 0.0.obs;
  Media? metasMedia;

  void initDartVLC() {
    player.value.currentStream.listen((value) {
      current.value = value;
    });
    player.value.positionStream.listen((value) {
      position.value = value;
    });
    player.value.playbackStream.listen((value) {
      playback.value = value;
    });
    player.value.generalStream.listen((value) {
      general.value = value;
    });
    player.value.videoDimensionsStream.listen((value) {
      videoDimensions.value = value;
    });
    player.value.bufferingProgressStream.listen(
      (bufferingProgress) {
        bufferingProgress = bufferingProgress;
      },
    );
    player.value.errorStream.listen((event) {
      print('libvlc error.');
    });
    devices = Devices.all;
    Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
    equalizer.setPreAmp(10.0);
    equalizer.setBandAmp(31.25, 10.0);
    player.value.setEqualizer(equalizer);
  }

  late bool isTablet;
  late bool isPhone;
  final double devicePixelRatio = ui.window.devicePixelRatio;
  final double width = ui.window.physicalSize.width;
  final double height = ui.window.physicalSize.height;
  void getPlatform() {
    if (devicePixelRatio < 2 && (width >= 1000 || height >= 1000)) {
      isTablet = true;
      isPhone = false;
    } else if (devicePixelRatio == 2 && (width >= 1920 || height >= 1920)) {
      isTablet = true;
      isPhone = false;
    } else {
      isTablet = false;
      isPhone = true;
    }
  }
}
