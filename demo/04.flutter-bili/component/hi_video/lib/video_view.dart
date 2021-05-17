import 'package:chewie/chewie.dart' hide MaterialControls;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hi_base/color.dart';
import 'package:hi_base/view_util.dart';
import 'package:hi_video/video_controls.dart';
import 'package:orientation/orientation.dart';
import 'package:video_player/video_player.dart';

// 播放器组件
class VideoView extends StatefulWidget {
  final String url; // 视频 url
  final String cover; // 视频 封面
  final bool autoPlay; // 是否自动播放
  final bool looping; // 是否循环播放
  final double aspectRatio; // 视频缩放比例
  final Widget overlayUI;
  final Widget barrageUI;

  const VideoView(this.url,
      {Key key,
      this.cover,
      this.autoPlay = true,
      this.looping = false,
      this.aspectRatio = 16 / 9,
      this.overlayUI,
      this.barrageUI})
      : super(key: key);

  @override
  _VideoViewState createState() => _VideoViewState();
}

class _VideoViewState extends State<VideoView> {
  VideoPlayerController _videoPlayerController; // video_player 播放器 Controller
  ChewieController _chewieController; // chewie 播放器 Controller

  // 封面
  get _placeholder => FractionallySizedBox(
        widthFactor: 1, // 宽度填满
        child: cachedImage(widget.cover),
      );

  // 设置进度条的颜色
  get _progressColors => ChewieProgressColors(
        playedColor: primary, // 播放状态下的进度条颜色
        handleColor: primary, // 拖动状态下的进度条颜色
        backgroundColor: Colors.grey, // 背景色
        bufferedColor: primary[50], // 缓存状态下的颜色
      );

  @override
  void initState() {
    super.initState();
    // 初始化播放器设置
    _videoPlayerController =
        VideoPlayerController.network(widget.url); // 来自网络的视频资源
    _chewieController = ChewieController(
      videoPlayerController: _videoPlayerController,
      aspectRatio: widget.aspectRatio, // 视频播放比例
      autoPlay: widget.autoPlay, // 是否自动播放
      looping: widget.looping, // 是否循环播放
      allowMuting: false, // 不允许静音，默认不允许
      placeholder: _placeholder, // 设置视频封面
      allowPlaybackSpeedChanging: false, // 是否显示播放器的倍速设置
      customControls: MaterialControls(
        showLoadingOnInitialize: true, // 隐藏初始状态下的 loading 显示
        showBigPlayIcon: true, // 隐藏中间大的播放按钮
        bottomGradient: blackLinearGradient(), // 黑色线性渐变
        overlayUI: widget.overlayUI,
        barrageUI: widget.barrageUI,
      ),
      materialProgressColors: _progressColors,
    );
    //fix iOS无法正常退出全屏播放问题
    _chewieController.addListener(_fullScreenListener);
  }

  @override
  void dispose() {
    _chewieController.removeListener(_fullScreenListener);
    _videoPlayerController.dispose();
    _chewieController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double playerHeight = screenWidth / widget.aspectRatio;
    return Container(
      width: screenWidth,
      height: playerHeight,
      color: Colors.grey,
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  void _fullScreenListener() {
    Size size = MediaQuery.of(context).size; // 通过 size 判断当前是否正在全屏
    if (size.width > size.height) {
      OrientationPlugin.forceOrientation(DeviceOrientation.portraitUp);
    }
  }
}
