import 'dart:io';

import 'package:dart_vlc/dart_vlc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' show QuillToolbar;

import 'package:get/get.dart';
import '../../../../data/models/video_model.dart';
import '../../../components/index.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  HomeView({super.key});

  final PlayerController playerController = Get.put(PlayerController());
  List<VideoModel> videos = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: CounterShortcuts(
            playOrPause: playerController.playOrPause,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                        child: TextField(
                            controller: controller.videoTextController)),
                    Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: ElevatedButton(
                            onPressed: () {
                              videos.add(
                                VideoModel(
                                  type: "file",
                                  path: controller.videoTextController.text
                                      .replaceAll('"', ''),
                                ),
                              );
                            },
                            child: const Text('Add to Playlist',
                                style: TextStyle(
                                  fontSize: 14.0,
                                )))),
                    const SizedBox(width: 12.0),
                    ElevatedButton(
                      onPressed: () => playerController.play(videos, 0),
                      child: const Text(
                        'play',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ElevatedButton(
                      onPressed: () => playerController.playOrPause(),
                      child: const Text(
                        'playOrPause',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12.0),
                    ElevatedButton(
                      onPressed: () => playerController.playOrPause(),
                      child: const Text(
                        'playOrPause',
                        style: TextStyle(
                          fontSize: 14.0,
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.7,
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: VideoPlayer(),
                    ),
                    Expanded(
                        child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.6,
                      child: const FlutterLogo(size: 100),
                    )),
                  ],
                ),
                QuillWidget(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Container(
          color: Colors.white12,
          width: double.infinity,
          child: QuillToolbar.basic(controller: controller.quillController)),
    );
  }
}

class VideoPlayer extends StatelessWidget {
  final PlayerController playerController = Get.put(PlayerController());
  VideoPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Platform.isWindows
          ? NativeVideo(
              player: playerController.videoPlayer,
              volumeThumbColor: Colors.blue,
              volumeActiveColor: Colors.blue,
            )
          : Video(
              player: playerController.videoPlayer,
              volumeThumbColor: Colors.blue,
              volumeActiveColor: Colors.blue,
            ),
    );
  }
}
