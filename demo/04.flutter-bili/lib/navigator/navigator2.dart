import 'package:e_social_work/http/index.dart';
import 'package:e_social_work/model/video_model.dart';
import 'package:e_social_work/navigator/index.dart';
import 'package:e_social_work/page/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/toast.dart';

/// Navigator 2.0 提供了一系列全新的接口，可以实现将路由状态成为应用状态的一部分，并提供解析来自底层平台如：（Web URL）的路由的功能，新增的 API 如下：
///
/// Page:用来表示 Navigator 路由栈中各个页面的不可变对象；
///   Page 是个抽象类通常使用它的派生类：MaterialPage 或 CupertinoPage；
/// Router:用来配置要由 Navigator 展示的页面列表，通常，该页面列表会根据系统或应用程序的状态改变而改变；
///   除了可以直接使用 Router 本身外还可以使用 MaterialApp.router() 来创建 Router；
/// RouterDelegate: 定义应用程序中的路由行为，例如 Router 如何知道应用程序状态的变化以及如何响应；
///   主要的工作就是监听 RouteInformationParser  和应用状态，并使用当前列表来构建 Pages；
/// RouteInformationParser: 可缺省，主要应用与 web，持有 RouteInformationProvider 提供的 RouteInformation ，可以将其解析为我们定义的数据类型；
/// BackButtonDispatcher: 响应后退按钮，并通知 Router
/// Tips：上面 API 中 BackButtonDispatcher 是用到的情况很少，另外对应移动端 APP 开发来说我们只需要用到 Navigator 2.0 中的 Page、Router、RouterDelegate 这三个API即可，RouteInformationParser与RouteInformationProvider主要是应用于开发web网站的路由用的；

// RouterDelegate: 定义路由代理，委托
class HiRouteDelegate extends RouterDelegate<HiRouterPath>
    with ChangeNotifier, PopNavigatorRouterDelegateMixin<HiRouterPath> {
  final GlobalKey<NavigatorState> navigatorKey;

  // 构造方法完成 navigatorKey 的初始化
  // 为 Navigator 设置一个 key，必要的时候可以通过 navigatorKey.currentState 来获取到 NavigatorState 对象
  HiRouteDelegate() : navigatorKey = GlobalKey<NavigatorState>() {
    // 在构造方法里实现注册路由的跳转逻辑
    HiNavigator.getInstance().registerRouteJump(
        RouteJumpListener(onJumpTo: (RouteStatus routeStatus, {Map args}) {
      _routeStatus = routeStatus;
      if (_routeStatus == RouteStatus.videoDetail) {
        this.videoModel = args['videoMo'];
      }
      notifyListeners();
    }));
  }

  RouteStatus _routeStatus = RouteStatus.home; // 默认赋值为首页
  List<MaterialPage> pages = []; // 定义集合来存放所有页面
  VideoModel videoModel;

  @override
  Widget build(BuildContext context) {
    // 管理路由栈
    var index = getPageIndex(pages, routeStatus);
    List<MaterialPage> tempPages = pages;
    if (index != -1) {
      // 要打开的页面在栈中已存在，则将该页面和它上面的所有页面进行出栈
      // tips 具体规则可以根据需要进行调整，这里要求栈中只允许有一个同样的页面的实例
      tempPages = tempPages.sublist(0, index);
    }
    // 创建要打开的页面
    var page;
    if (routeStatus == RouteStatus.home) {
      // 跳转首页时将栈中其他页面进行出栈，因为首页不可回退
      pages.clear();
      page = pageWrap(BottomNavigator());
    } else if (routeStatus == RouteStatus.darkMode) {
      page = pageWrap(DarkModePage());
    } else if (routeStatus == RouteStatus.videoDetail) {
      page = pageWrap(VideoDetailPage(videoModel: videoModel));
    } else if (routeStatus == RouteStatus.login) {
      page = pageWrap(MobilePasswordLogin());
    } else if (routeStatus == RouteStatus.course) {
      page = pageWrap(CoursePage());
    }
    // 重新创建一个数组，否则 pages 因引用没有改变路由不会生效
    tempPages = [...tempPages, page];
    // 通知路由发生变化
    HiNavigator.getInstance().notify(tempPages, pages);
    pages = tempPages; // 改变真实的页面

    // 返回路由栈信息
    return WillPopScope(
      // fix Android 物理返回键，无法返回上一页问题@https://github.com/flutter/flutter/issues/66349
      onWillPop: () async => !await navigatorKey.currentState.maybePop(),
      child: Navigator(
        key: navigatorKey,
        pages: pages,
        onPopPage: (route, result) {
          if (route.settings is MaterialPage) {
            var _currentPage = (route.settings as MaterialPage).child;
            // 登录页未登录返回拦截
            if (_currentPage is MobilePasswordLogin ||
                _currentPage is MobilePage) {
              if (!hasLogin) {
                showWarnToast('请先登录');
                return false;
              }
            }
          }
          // 在这里可以控制是否可以返回上一页
          if (!route.didPop(result)) {
            return false;
          }
          var tempPages = [...pages];
          pages.removeLast(); // 移除上一级页面
          // 通知路由发生变化
          HiNavigator.getInstance().notify(pages, tempPages);
          return true;
        },
      ),
    );
  }

  RouteStatus get routeStatus {
    // 对当前路由状态进行拦截，如果当前打开的不是注册页面，并且没有登录
    if (_routeStatus != RouteStatus.login && !hasLogin) {
      return _routeStatus = RouteStatus.login; // 返回登录页面
    } else {
      return _routeStatus;
    }
  }

  bool get hasLogin => LoginDao.getBoardingPass() != null;

  @override
  Future<void> setNewRoutePath(HiRouterPath configuration) async {}
}

// RouteInformationParser: 可缺省，主要应用与 web，持有 RouteInformationProvider 提供的 RouteInformation ，可以将其解析为我们定义的数据类型
class HiRouteInformationParser extends RouteInformationParser<HiRouterPath> {
  @override
  Future<HiRouterPath> parseRouteInformation(
      RouteInformation routeInformation) async {
    final uri = Uri.parse(routeInformation.location); // 解析 url
    print('uri:$uri');
    if (uri.pathSegments.length == 0) {
      return HiRouterPath.home(); // 首页
    }
    return HiRouterPath.detail();
  }
}

// 定义路由数据，每个页面对应的 path
class HiRouterPath {
  final String location;

  HiRouterPath.home() : location = "/";

  HiRouterPath.detail() : location = "/detail";
}
