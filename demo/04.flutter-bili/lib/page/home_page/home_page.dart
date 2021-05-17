import 'package:e_social_work/http/dao/home_dao.dart';
import 'package:e_social_work/model/home_mo.dart';
import 'package:e_social_work/navigator/hi_navigator.dart';
import 'package:e_social_work/page/home_page/index.dart';
import 'package:e_social_work/page/index.dart';
import 'package:e_social_work/util/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';
import 'package:hi_base/hi_state.dart';
import 'package:hi_base/toast.dart';
import 'package:hi_net/core/hi_error.dart';

class HomePage extends StatefulWidget {
  final ValueChanged onJumpTo;

  const HomePage({Key key, this.onJumpTo}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends HiState<HomePage>
    with
        AutomaticKeepAliveClientMixin,
        TickerProviderStateMixin,
        WidgetsBindingObserver {
  var listener;

  TabController _controller;
  List<CategoryMo> categoryList = [];
  List<BannerMo> bannerList = [];
  bool _isLoading = true;
  Widget _currentPage; // 当前页面

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this); // 监听应用程序生命周期变化
    _controller = TabController(length: categoryList.length, vsync: this);
    HiNavigator.getInstance().addListener(this.listener = (cur, pre) {
      this._currentPage = cur.page;
      print('current: ${cur.page}');
      print('pre: ${pre.page}');
      if (widget == cur.page || cur.page is HomePage) {
        print('打开了首页，onResume');
      } else if (widget == pre?.page || pre?.page is HomePage) {
        print('首页压入后台，onPause');
      }
      // 当页面返回到首页恢复首页的状态栏样式
      if (pre?.page is VideoDetailPage && !(cur.page is ProfilePage)) {
        var statusStyle = StatusStyle.DARK_CONTENT;
        changeStatusBar(color: Colors.white, statusStyle: statusStyle);
      }
    });
    loadData();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    HiNavigator.getInstance().removeListener(this.listener);
    _controller.dispose();
    super.dispose();
  }

  // 监听应用程序生命周期变化
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print(':didChangeAppLifecycleState:$state');
    switch (state) {
      case AppLifecycleState.inactive: // 处于这种状态的应用程序应该假设他们可能在任何时候暂停
        break;
      case AppLifecycleState.resumed: // 从后台切换到前台，界面课件
        // fix Android压后台首页状态栏字体颜色变白，详情页状态栏字体变黑问题
        changeStatusBar();
        break;
      case AppLifecycleState.paused: // 界面不可见，后台
        break;
      case AppLifecycleState.detached: // APP 结束时调用
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      body: LoadingContainer(
        isLoading: _isLoading,
        child: Column(
          children: [
            NavigationBar(
              height: 50,
              child: _appBar(),
              color: Colors.white,
              statusStyle: StatusStyle.DARK_CONTENT,
            ),
            SizedBox(height: 6),
            searchBar(),
            SizedBox(height: 6),
            homeTabBanner(context),
            SizedBox(height: 6),
            Flexible(
                child: TabBarView(
                    controller: _controller,
                    children: categoryList.map((tab) {
                      return HomeTabPage(
                          categoryName: tab.name,
                          bannerList: tab.name == '推荐' ? bannerList : null);
                    }).toList()))
          ],
        ),
      ),
    );
  }

  // AutomaticKeepAliveClientMixin 页面切换走再切换回来不会被重新创建
  @override
  bool get wantKeepAlive => true;

  _tabBar() {
    return HiTab(
      categoryList.map<Tab>((tab) {
        return Tab(text: tab.name);
      }).toList(),
      controller: _controller,
      fontSize: 16,
      borderWidth: 3,
      unselectedLabelColor: Colors.black54,
      insets: 13,
    );
  }

  void loadData() async {
    try {
      HomeMo result = await HomeDao.get('推荐');
      // print('loadData(): $result');
      if (result.categoryList != null) {
        //tab长度变化后需要重新创建TabController
        _controller =
            TabController(length: result.categoryList.length, vsync: this);
      }
      setState(() {
        categoryList = result.categoryList;
        bannerList = result.bannerList;
        _isLoading = false;
      });
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
      setState(() {
        _isLoading = false;
      });
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
      setState(() => _isLoading = false);
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Image.asset(
            'images/logo.png',
            width: 48,
            height: 16,
          ),
        ],
      ),
    );
  }

  homeTabBanner(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          inkWell(0, '服务'),
          inkWell(2, '客户'),
          inkWell(1, '课程'),
          inkWell(3, '任务'),
        ],
      ),
    );
  }

  InkWell inkWell(int index, String title) {
    return InkWell(
      onTap: () {
        if (widget.onJumpTo != null) {
          widget.onJumpTo(index);
        }
      },
      child: Column(
        children: [
          Image.asset('images/$title.png', width: 66, height: 48),
          Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class searchBar extends StatelessWidget {
  const searchBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Container(
        child: Container(
          padding: EdgeInsets.only(left: 10),
          height: 44,
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.grey),
              Padding(
                padding: EdgeInsets.only(left: 10),
                child: Text(
                  '生育健康指导',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              )
            ],
          ),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            border: Border.all(color: primary, width: 1.5),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
