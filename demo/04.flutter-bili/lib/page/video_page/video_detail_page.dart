import 'dart:io';

import 'package:e_social_work/http/dao/favorite_dao.dart';
import 'package:e_social_work/http/dao/video_detail_dao.dart';
import 'package:e_social_work/model/video_detail_mo.dart';
import 'package:e_social_work/model/video_model.dart';
import 'package:e_social_work/provider/index.dart';
import 'package:e_social_work/util/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';
import 'package:hi_base/toast.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:hi_video/video_view.dart';
import 'package:provider/provider.dart';

class VideoDetailPage extends StatefulWidget {
  final VideoModel videoModel;

  const VideoDetailPage({Key key, this.videoModel}) : super(key: key);

  @override
  _VideoDetailPageState createState() => _VideoDetailPageState();
}

class _VideoDetailPageState extends State<VideoDetailPage>
    with TickerProviderStateMixin {
  VideoModel videoModel;
  ThemeProvider _themeProvider;
  TabController _controller; // tab 切换控制器
  List tabs = ["课程介绍", "课程大纲"];
  VideoDetailMo videoDetailMo;
  List<VideoModel> videoList = [];

  @override
  void initState() {
    super.initState();
    _themeProvider = context.read<ThemeProvider>();
    // 黑色状态栏，仅 Android
    changeStatusBar(
        color: Colors.black, statusStyle: StatusStyle.LIGHT_CONTENT);
    _controller =
        TabController(length: tabs.length, vsync: this); // 初始化 tab controller
    videoModel = widget.videoModel; // 初始值是从首页传递进来的
    _loadDetail();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MediaQuery.removePadding(
        removeTop: Platform.isIOS,
        context: context,
        child: videoModel.url != null
            ? Column(
                children: [
                  // iOS 黑色状态栏
                  NavigationBar(
                    color: Colors.black,
                    statusStyle: StatusStyle.LIGHT_CONTENT,
                    height: Platform.isAndroid ? 0 : 46,
                  ),
                  _buildVideoView(),
                  _buildTabNavigation(),
                  Flexible(
                      child: TabBarView(
                    controller: _controller,
                    children: [
                      _buildDetailList(),
                      Container(
                        child: Center(child: Text('敬请期待')),
                      ),
                    ],
                  ))
                ],
              )
            : Container(),
      ),
    );
  }

  _buildVideoView() {
    var model = videoModel;
    return VideoView(
      model.url,
      cover: model.cover,
      overlayUI: videoAppBar(download: () {
        // TODO: 点击下载该视频
        print('点击下载该视频');
      }),
    );
  }

  // 返回一个带阴影效果的 navigation
  _buildTabNavigation() {
    return Material(
      elevation: 5, // 阴影的大小
      shadowColor: // 阴影的颜色
          _themeProvider.isDark() ? HiColor.dark_bg : Colors.grey[100],
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.only(left: 20),
        height: 39,
        color: _themeProvider.isDark() ? HiColor.dark_bg : Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _tabBar(),
            Padding(
              padding: EdgeInsets.only(right: 20),
              child: Icon(Icons.grade_outlined, color: Colors.grey),
            )
          ],
        ),
      ),
    );
  }

  _tabBar() {
    return HiTab(
      tabs.map<Tab>((name) {
        return Tab(
          text: name,
        );
      }).toList(),
      controller: _controller,
    );
  }

  // 视频详情页的介绍 ListView
  _buildDetailList() {
    return ListView(
      padding: EdgeInsets.all(0), // 移除边距
      children: [
        ...buildContents(),
        ...buildVideoList(),
      ],
    );
  }

  // 视频详情页的介绍的内容
  buildContents() {
    return [
      VideoHeader(
        owner: videoModel.owner,
      ),
      ExpandableContent(mo: videoModel),
      VideoToolBar(
        detailMo: videoDetailMo,
        videoModel: videoModel,
        onLike: _doLike,
        onUnLike: _onUnLike,
        onFavorite: _onFavorite,
      ),
    ];
  }

  // 加载视频详情数据
  void _loadDetail() async {
    try {
      VideoDetailMo result = await VideoDetailDao.get(videoModel.vid);
      setState(() {
        videoDetailMo = result;
        videoModel = result.videoInfo; // 二次赋值，更新
        videoList = result.videoList;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  // 点赞
  void _doLike() {}

  // 取消点赞
  void _onUnLike() {}

  // 收藏
  void _onFavorite() async {
    try {
      var result =
          await FavoriteDao.favorite(videoModel.vid, !videoDetailMo.isFavorite);
      print(result);
      videoDetailMo.isFavorite = !videoDetailMo.isFavorite;
      if (videoDetailMo.isFavorite) {
        videoModel.favorite += 1;
      } else {
        videoModel.favorite -= 1;
      }
      setState(() {
        videoDetailMo = videoDetailMo;
        videoModel = videoModel;
      });
      showToast(result['msg']);
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  buildVideoList() {
    return videoList
        .map((VideoModel mo) => VideoLargeCard(videoModel: mo))
        .toList();
  }
}
