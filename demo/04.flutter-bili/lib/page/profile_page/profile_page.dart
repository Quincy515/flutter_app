import 'package:e_social_work/http/dao/profile_dao.dart';
import 'package:e_social_work/model/profile_mo.dart';
import 'package:e_social_work/widget/hi_banner.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/hi_blur.dart';
import 'package:hi_base/hi_flexible_header.dart';
import 'package:hi_base/toast.dart';
import 'package:hi_base/view_util.dart';
import 'package:hi_net/core/hi_error.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key key}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  ProfileMo _profileMo;
  ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: NestedScrollView(
        controller: _controller,
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[buildAppBar()];
        },
        body: ListView(
          padding: EdgeInsets.only(top: 10),
          // item 数量是可控的不是动态的列表，就不需要使用 ListView.builder
          children: [...buildContentList()],
        ),
      ),
    );
  }

  SliverAppBar buildAppBar() {
    return SliverAppBar(
      expandedHeight: 160, // 扩展高度
      pinned: true, // 滚动时标题栏是否固定
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.parallax, // 视差滚动效果
        titlePadding: EdgeInsets.only(left: 0),
        title: _buildHead(),
        background: Stack(
          children: [
            Positioned.fill(
              child: cachedImage(
                  'https://www.devio.org/img/beauty_camera/beauty_camera4.jpg'),
            ),
            Positioned.fill(child: HiBlur(sigma: 20)),
            Positioned(bottom: 0, left: 0, right: 0, child: _buildProfileTab()),
          ],
        ),
      ), // 定义滚动空间
    );
  }

  void loadData() async {
    try {
      ProfileMo result = await ProfileDao.get();
      print(result);
      setState(() {
        _profileMo = result;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }

  _buildHead() {
    if (_profileMo == null) return Container();
    return HiFlexibleHeader(
        name: _profileMo.name, face: _profileMo.face, controller: _controller);
  }

  @override
  bool get wantKeepAlive => true;

  buildContentList() {
    if (_profileMo == null) return [];
    return [
      _buildBanner(),
      CourseCard(courseList: _profileMo.courseList),
      BenefitCard(benefitList: _profileMo.benefitList),
    ];
  }

  _buildBanner() {
    return HiBanner(_profileMo.bannerList,
        bannerHeight: 120, padding: EdgeInsets.only(left: 10, right: 10));
  }

  _buildProfileTab() {
    if (_profileMo == null) return Container();
    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      decoration: BoxDecoration(color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildIconText('收藏', _profileMo.favorite),
          _buildIconText('点赞', _profileMo.like),
          _buildIconText('浏览', _profileMo.browsing),
          _buildIconText('金币', _profileMo.coin),
          _buildIconText('粉丝数', _profileMo.fans),
        ],
      ),
    );
  }

  _buildIconText(String text, int count) {
    return Column(
      children: [
        Text('$count', style: TextStyle(fontSize: 15, color: Colors.black87)),
        Text(text, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
      ],
    );
  }
}
