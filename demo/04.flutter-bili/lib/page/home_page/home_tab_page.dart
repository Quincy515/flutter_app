import 'package:e_social_work/http/dao/home_dao.dart';
import 'package:e_social_work/model/home_mo.dart';
import 'package:e_social_work/model/video_model.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hi_base/hi_tab_state.dart';

class HomeTabPage extends StatefulWidget {
  final String categoryName;
  final List<BannerMo> bannerList;

  const HomeTabPage({Key key, this.categoryName, this.bannerList})
      : super(key: key);

  @override
  _HomeTabPageState createState() => _HomeTabPageState();
}

class _HomeTabPageState
    extends HiBaseTabState<HomeMo, VideoModel, HomeTabPage> {
  @override
  void initState() {
    super.initState(); // 调用 supper 父类的 initState 才可以初始化
    print(widget.categoryName);
    print(widget.bannerList);
  }

  _banner() {
    return HiBanner(
      widget.bannerList,
      bannerHeight: 100,
      padding: EdgeInsets.only(left: 5, right: 5),
    );
  }

  @override
  get contentChild => StaggeredGridView.countBuilder(
        controller: scrollController,
        physics: const AlwaysScrollableScrollPhysics(), // 数据量少，列表无法填满屏幕，也可以滚动
        padding: EdgeInsets.only(top: 10, left: 10, right: 10),
        crossAxisCount: 2, // 每一行默认展示几列
        itemCount: dataList.length,
        itemBuilder: (BuildContext context, int index) {
          if (widget.bannerList != null && index == 0) {
            return Padding(
                padding: EdgeInsets.only(bottom: 8), child: _banner());
          } else {
            return VideoCard(videoMo: dataList[index]);
          }
        },
        staggeredTileBuilder: (int index) {
          if (widget.bannerList != null && index == 0) {
            return StaggeredTile.fit(2); // banner 独占一行
          } else {
            return StaggeredTile.fit(1); // 每一个栈几列
          }
        }, // 每一行显示几个 item
      );

  @override
  Future<HomeMo> getData(int pageIndex) async {
    HomeMo result = await HomeDao.get(widget.categoryName,
        pageIndex: pageIndex, pageSize: 10);
    return result;
  }

  @override
  List<VideoModel> parseList(HomeMo result) {
    return result.videoList;
  }
}
