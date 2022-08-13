import 'dart:io';
import 'package:dart_vlc/dart_vlc.dart';
import 'package:get/get.dart';

import '../../data/models/video_model.dart';

// TODO: 1.视频无法移动 2.视频框中按钮无法正常使用 3.视频快捷键绑定（播放、暂停、快进、快退等）
// 字幕显示，点击字幕跳转到视频画面，编辑字幕等
// 导出视频笔记成markdown或pdf或分享图片等
class PlayerController extends GetxController {
  final videoPlayer = Player(
    id: 69420,
    videoDimensions: const VideoDimensions(640, 360),
    registerTexture: !Platform.isWindows,
  );
  final Rx<Duration> _duration = const Duration(milliseconds: 0).obs;
  final Rx<Duration> _position = const Duration(milliseconds: 0).obs;
  final Rx<Duration> _bufferedPosition = const Duration(milliseconds: 0).obs;
  final RxBool _isPlaying = false.obs;
  final RxBool _isLoop = false.obs;
  final RxBool _isMuted = false.obs;
  final RxDouble _volume = 1.0.obs;
  final Rx<CurrentState> current = CurrentState().obs;
  final Rx<PositionState> position = PositionState().obs;
  final Rx<PlaybackState> playback = PlaybackState().obs;
  final Rx<GeneralState> general = GeneralState().obs;
  final RxList<Device> devices = <Device>[].obs;
  final videoDimensions = const VideoDimensions(0, 0).obs;
  final Rx<VideoModel> _currentVideo = VideoModel(
    id: 0,
    title: "",
    path: "",
    url: "",
    type: "",
    category: "",
    describe: "",
    tag: "",
    author: "",
    hash: "",
    duration: 0,
  ).obs;
  final RxList<VideoModel> _videos = [
    VideoModel(
      title: "title",
      path: "c:\\Users\\Administrator\\5.mp4",
      url: "http://video.com/networkurl.mp4",
      type: "file",
      category: "category",
      describe: "describe",
      tag: "tag",
      author: "author",
      hash: "hash",
      duration: 0,
    ),
  ].obs;

  Duration get getDuration => _duration.value;
  Duration get getPosition => _position.value;
  Duration get getBufferedPosition => _bufferedPosition.value;
  bool get getIsPlaying => _isPlaying.value;
  bool get getIsLoop => _isLoop.value;
  bool get getIsMuted => _isMuted.value;
  double get getVolume => _volume.value;
  VideoModel get getCurrentVideo => _currentVideo.value;

  @override
  void onInit() {
    videoPlayer.currentStream.listen((CurrentState state) {
      current.value = state;
      _currentVideo.value = _videos[state.index ?? 0];
    });
    videoPlayer.positionStream.listen((PositionState state) {
      position.value = state;
      _position.value = Duration(milliseconds: state.position!.inMilliseconds);
      _duration.value = Duration(milliseconds: state.duration!.inMilliseconds);
    });
    videoPlayer.playbackStream.listen((PlaybackState state) {
      playback.value = state;
      _isPlaying.value = state.isPlaying;
    });
    videoPlayer.generalStream.listen((GeneralState state) {
      general.value = state;
      _volume.value = state.volume;
    });
    videoPlayer.videoDimensionsStream.listen((VideoDimensions state) {
      videoDimensions.value = state;
    });
    videoPlayer.bufferingProgressStream.listen((double bufferedPosition) {
      _bufferedPosition.value = bufferedPosition.milliseconds;
    });
    videoPlayer.errorStream.listen((event) {
      print('libvlc error.');
    });
    devices.value = Devices.all;
    Equalizer equalizer = Equalizer.createMode(EqualizerMode.live);
    equalizer.setPreAmp(10.0);
    equalizer.setBandAmp(31.25, 10.0);
    videoPlayer.setEqualizer(equalizer);
    super.onInit();
  }

  @override
  void onClose() {
    videoPlayer.dispose();
    super.onClose();
  }

  void play(List<VideoModel> videos, int index) {
    _videos.value = videos.toList();
    videoPlayer.open(
      autoStart: false,
      Playlist(
        playlistMode: PlaylistMode.loop,
        medias: videos.map((video) {
          if (video.type == "network") {
            return Media.network(video.url);
          } else {
            return Media.file(File(video.path!.trim()));
          }
        }).toList(),
      ),
    );
    videoPlayer.play();
    videoPlayer.jumpToIndex(index);
  }

  void playOrPause() {
    videoPlayer.playOrPause();
  }

  void setRepeat() {
    if (_isLoop.value) {
      videoPlayer.setPlaylistMode(PlaylistMode.loop);
    } else {
      videoPlayer.setPlaylistMode(PlaylistMode.repeat);
    }
    _isLoop.value = !_isLoop.value;
  }

  void muteOrUnmute() {
    if (_volume.value != 0) {
      videoPlayer.setVolume(0);
    } else {
      videoPlayer.setVolume(0.8);
    }
  }

  void next() {
    videoPlayer.next();
  }

  void previous() {
    videoPlayer.previous();
  }

  void seek(Duration position) {
    videoPlayer.seek(position);
  }

  void setVolume(double volume) {
    videoPlayer.setVolume(volume);
  }
}
