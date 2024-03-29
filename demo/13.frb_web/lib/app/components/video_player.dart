import 'package:chewie/chewie.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

const kDefaultAspectRatio = 16 / 9;

enum VideoType {
  asset,
  network,
}

Set<VideoPlayerController> _videoPlayers = Set();

class HiVideoPlayer extends StatefulWidget {
  const HiVideoPlayer({
    required this.path,
    this.videoType = VideoType.network,
    this.width,
    this.height,
    this.aspectRatio,
    this.autoPlay = false,
    this.looping = false,
    this.showControls = true,
    this.allowFullScreen = true,
    this.allowPlaybackSpeedMenu = false,
    this.lazyLoad = false,
  });

  final String path;
  final VideoType videoType;
  final double? width;
  final double? height;
  final double? aspectRatio;
  final bool autoPlay;
  final bool looping;
  final bool showControls;
  final bool allowFullScreen;
  final bool allowPlaybackSpeedMenu;
  final bool lazyLoad;

  @override
  State<StatefulWidget> createState() => _HiVideoPlayerState();
}

class _HiVideoPlayerState extends State<HiVideoPlayer> {
  VideoPlayerController? _videoPlayerController;
  ChewieController? _chewieController;
  bool _loggedError = false;

  @override
  void initState() {
    super.initState();
    initializePlayer();
  }

  @override
  void dispose() {
    _videoPlayers.remove(_videoPlayerController);
    _videoPlayerController?.dispose();
    _chewieController?.dispose();
    super.dispose();
  }

  double get width => widget.width == null || widget.width! >= double.infinity
      ? MediaQuery.of(context).size.width
      : widget.width!;

  double get height =>
      widget.height == null || widget.height! >= double.infinity
          ? width / aspectRatio
          : widget.height!;

  double get aspectRatio =>
      _chewieController?.videoPlayerController.value.aspectRatio ??
      kDefaultAspectRatio;

  Future initializePlayer() async {
    _videoPlayerController = widget.videoType == VideoType.network
        ? VideoPlayerController.network(widget.path)
        : VideoPlayerController.asset(widget.path);
    if (kIsWeb && widget.autoPlay) {
      // Browsers generally don't allow autoplay unless it's muted.
      // Ideally this should be configurable, but for now we just automatically
      // mute on web.
      // See https://pub.dev/packages/video_player_web#autoplay
      _videoPlayerController!.setVolume(0);
    }
    if (!widget.lazyLoad) {
      await _videoPlayerController?.initialize();
    }
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController!,
      deviceOrientationsOnEnterFullScreen: [
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ],
      deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
      aspectRatio: widget.aspectRatio,
      autoPlay: widget.autoPlay,
      looping: widget.looping,
      showControls: widget.showControls,
      allowFullScreen: widget.allowFullScreen,
      allowPlaybackSpeedChanging: widget.allowPlaybackSpeedMenu,
    );

    _videoPlayers.add(_videoPlayerController!);
    _videoPlayerController!.addListener(() {
      if (_videoPlayerController!.value.hasError && !_loggedError) {
        debugPrint(
            'Error playing video: ${_videoPlayerController!.value.errorDescription}');
        _loggedError = true;
      }
      // Stop all other players when one video is playing.
      if (_videoPlayerController!.value.isPlaying) {
        for (var otherPlayer in _videoPlayers) {
          if (otherPlayer != _videoPlayerController &&
              otherPlayer.value.isPlaying) {
            setState(() {
              otherPlayer.pause();
            });
          }
        }
      }
    });

    setState(() {});
  }

  @override
  Widget build(BuildContext context) => FittedBox(
        fit: BoxFit.cover,
        child: SizedBox(
          height: height,
          width: width,
          child: _chewieController != null &&
                  (widget.lazyLoad ||
                      _chewieController!
                          .videoPlayerController.value.isInitialized)
              ? Chewie(controller: _chewieController!)
              : (_chewieController != null &&
                      _chewieController!.videoPlayerController.value.hasError)
                  ? const Text('Error playing video')
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                        SizedBox(height: 20),
                        Text('Loading'),
                      ],
                    ),
        ),
      );
}
