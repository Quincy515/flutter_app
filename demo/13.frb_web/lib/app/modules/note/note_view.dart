import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart' hide Card;
import 'package:get/get.dart';

import '../../components/video_player.dart';
import 'note_controller.dart';

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  final NoteController noteCtrl = Get.put(NoteController());
  final scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      key: scaffoldKey,
      children: const [
        Card(
          child: HiVideoPlayer(
            path: 'https://oxyak.oss-cn-hangzhou.aliyuncs.com/1.mp4',
            videoType: VideoType.network,
            autoPlay: false,
            looping: true,
            showControls: true,
            allowFullScreen: true,
            allowPlaybackSpeedMenu: true,
          ),
        ),
      ],
    );
  }
}
