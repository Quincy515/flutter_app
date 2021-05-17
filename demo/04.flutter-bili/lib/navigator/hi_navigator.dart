// 路由相关功能抽取到该文件
import 'package:e_social_work/navigator/bottom_navigator.dart';
import 'package:e_social_work/page/index.dart';
import 'package:flutter/material.dart';

// 页面路由的跳转监听 当前的打开页面和上次的打开页面
typedef RouteChangeListener(RouteStatusInfo current, RouteStatusInfo pre);

// 创建页面
pageWrap(Widget child) {
  return MaterialPage(key: ValueKey(child.hashCode), child: child);
}

// 获取 routeStatus 当前要打开的页面在页面路由栈中的位置
int getPageIndex(List<MaterialPage> pages, RouteStatus routeStatus) {
  for (int i = 0; i < pages.length; i++) {
    MaterialPage page = pages[i];
    if (getStatus(page) == routeStatus) {
      return i;
    }
  }
  return -1;
}

// 自定义路由封装，路由状态
enum RouteStatus {
  login, // 登录注册页面
  home, // 首页
  course, // 课程页面
  darkMode, // 夜间模式页面
  unknown, // 未知页面
  videoDetail, // 视频详情页面
}

// 获取 page 对应的 RouteStatus
RouteStatus getStatus(MaterialPage page) {
  if (page.child is MobilePasswordLogin) {
    return RouteStatus.login;
  } else if (page.child is BottomNavigator) {
    return RouteStatus.home;
  } else if (page.child is CoursePage) {
    return RouteStatus.course;
  } else if (page.child is DarkModePage) {
    return RouteStatus.darkMode;
  } else if (page.child is VideoDetailPage) {
    return RouteStatus.videoDetail;
  } else {
    return RouteStatus.unknown;
  }
}

// 路由信息 路由状态与对应的页面
class RouteStatusInfo {
  final RouteStatus routeStatus;
  final Widget page;

  RouteStatusInfo(this.routeStatus, this.page);
}

// 监听路由页面跳转
// 感知当前页面是否压后台
// 通过单例管理路由的跳转和相关的状态
class HiNavigator extends _RouteJumpListener {
  static HiNavigator _instance; // 设置成单例

  RouteJumpListener _routeJump;
  List<RouteChangeListener> _listeners = [];
  RouteStatusInfo _current;

  RouteStatusInfo _bottomTab; // 首页底部 tab

  HiNavigator._(); // 私有的构造方法

  static HiNavigator getInstance() {
    if (_instance == null) {
      _instance = HiNavigator._(); // 通过构造方法创建新的实例
    }
    return _instance;
  }

  RouteStatusInfo getCurrent() {
    return _current;
  }

  // 首页底部 tab 切换监听
  void onBottomTabChange(int index, Widget page) {
    _bottomTab = RouteStatusInfo(RouteStatus.home, page);
    _notify(_bottomTab);
  }

  // 注册路由的跳转逻辑
  void registerRouteJump(RouteJumpListener routeJumpListener) {
    this._routeJump = routeJumpListener;
  }

  // 监听路由页面跳转
  void addListener(RouteChangeListener listener) {
    if (!_listeners.contains(listener)) {
      _listeners.add(listener);
    }
  }

  // 移除监听
  void removeListener(RouteChangeListener listener) {
    _listeners.remove(listener);
  }

  @override
  void onJumpTo(RouteStatus routeStatus, {Map args}) {
    _routeJump.onJumpTo(routeStatus, args: args);
  }

  // 通知路由页面变化
  void notify(List<MaterialPage> currentPages, List<MaterialPage> prePages) {
    if (currentPages == prePages) return;
    var current =
        RouteStatusInfo(getStatus(currentPages.last), currentPages.last.child);
    _notify(current);
  }

  void _notify(RouteStatusInfo current) {
    if (current.page is BottomNavigator && _bottomTab != null) {
      // 如果打开的是首页，则明确到首页具体的tab
      current = _bottomTab;
    }
    print('hi_navigator:current:${current.page}');
    print('hi_navigator:pre:${_current?.page}');
    _listeners.forEach((listener) {
      listener(current, _current);
    });
    _current = current;
  }
}

// 抽象类供 HiNavigator 实现
abstract class _RouteJumpListener {
  void onJumpTo(RouteStatus routeStatus, {Map args});
}

typedef OnJumpTo = void Function(RouteStatus routeStatus, {Map args});

// 定义路由跳转逻辑要实现的功能
class RouteJumpListener {
  final OnJumpTo onJumpTo;

  RouteJumpListener({this.onJumpTo});
}
