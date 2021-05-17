import 'package:e_social_work/http/index.dart';
import 'package:e_social_work/model/home_mo.dart';
import 'package:e_social_work/model/lesson_type_mo.dart';
import 'package:e_social_work/page/course_page/index.dart';
import 'package:e_social_work/util/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/hi_state.dart';
import 'package:hi_base/toast.dart';

class CoursePage extends StatefulWidget {
  const CoursePage({Key key}) : super(key: key);

  @override
  _CoursePageState createState() => _CoursePageState();
}

class _CoursePageState extends HiState<CoursePage>
    with AutomaticKeepAliveClientMixin, TickerProviderStateMixin {
  TabController _controller;

  // var tabs = ["推荐", "热点课程", "健康社工", "医务社工"];
  List<LessonTypeDataMo> categoryList = [];
  List<BannerMo> bannerList = [];

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: categoryList.length, vsync: this);
    loadData();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 30),
            child: _tabBar(),
            decoration: bottomBoxShadow(context),
          ),
          // Flexible 填充所有空间
          Flexible(
              child: TabBarView(
            controller: _controller,
            children: categoryList.map((tab) {
              return CourseTabPage(
                  name: tab.lessonTypeName,
                  bannerList: tab.lessonTypeName == '推荐' ? bannerList : null);
            }).toList(),
          )),
        ],
      ),
    );
  }

  _tabBar() {
    return HiTab(
      categoryList.map<Tab>((tab) {
        return Tab(
          text: tab.lessonTypeName,
        );
      }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      insets: 13, // 内边距
    );
  }

  void loadData() async {
    try {
      LessonTypeMo result = await LessonTypeDao.get();
      if (result.lessonTypeDataMo != null) {
        _controller = // tab 长度变化后需要重新创建 TabController
            TabController(length: result.lessonTypeDataMo.length, vsync: this);
      }
      setState(() {
        categoryList = result.lessonTypeDataMo;
      });
    } catch (e) {
      print(e);
      showWarnToast(e.toString());
    }
  }

  @override
  bool get wantKeepAlive => true;
}
