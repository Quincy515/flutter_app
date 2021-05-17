import 'package:e_social_work/http/dao/index.dart';
import 'package:e_social_work/http/request/notice_request.dart';
import 'package:e_social_work/page/index.dart';
import 'package:e_social_work/provider/index.dart';
import 'package:e_social_work/router/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:hi_net/hi_net.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    HiCache.preInit();
  }

  // 监听系统 Dark Mode 变化
  @override
  void didChangePlatformBrightness() {
    context.read<ThemeProvider>().darkModeChange();
    super.didChangePlatformBrightness();
  }

  void _incrementCounter() async {
    // context.read<ThemeProvider>().setTheme(ThemeMode.light);
    // TestRequest request = TestRequest();
    // request.add("requestPrams", "aa").add("bb", "3333");
    //
    // try {
    //   var result = await HiNet.getInstance().fire(request);
    //   print(result);
    // } on NeedLogin catch (e) {
    //   print(e);
    // } on NeedAuth catch (e) {
    //   print(e);
    // } on HiNetError catch (e) {
    //   print(e);
    // }
    //
    // test();
    // login();
    notice();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            NavigationBar(
              height: 50,
              child: _appBar(),
              color: Colors.white,
              statusStyle: StatusStyle.DARK_CONTENT,
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            DarkModeItem(),
            RaisedButton(
              onPressed: () {
                Application.router.navigateTo(context, Routes.registration,
                    transition: TransitionType.cupertino);
              },
              child: Text('注册'),
            ),
            RaisedButton(
              onPressed: () {
                Application.router.navigateTo(context, Routes.mobile,
                    transition: TransitionType.cupertino);
              },
              child: Text('手机号登录'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void test() {
    HiCache.getInstance().setString("aa", "1234");
    var value = HiCache.getInstance().get("aa");
    print('value: $value');
  }

  void login() async {
    try {
      // var result =
      // await LoginDao.registration('custer', 'custer', '123456', '123456');
      var result2 = await LoginDao.login('custer', 'custer');
      print(result2);
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e);
    }
  }

  void notice() async {
    try {
      var result = await HiNet.getInstance().fire(NoticeRequest());
      print(result);
    } on NeedLogin catch (e) {
      print(e);
    } on NeedAuth catch (e) {
      print(e);
    } on HiNetError catch (e) {
      print(e.message);
    }
  }

  _appBar() {
    return Padding(
      padding: EdgeInsets.only(left: 15, right: 15),
      child: Row(
        children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: EdgeInsets.only(left: 10),
                height: 32,
                alignment: Alignment.centerLeft,
                child: Icon(
                  Icons.search,
                  color: Colors.grey,
                ),
                decoration: BoxDecoration(color: Colors.grey[100]),
              ),
            ),
          )),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('取消', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
