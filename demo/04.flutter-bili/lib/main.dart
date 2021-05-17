import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/navigator/index.dart';
import 'package:e_social_work/provider/index.dart';
import 'package:e_social_work/router/index.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:provider/provider.dart';

void main() => runApp(HiApp());

class HiApp extends StatefulWidget {
  const HiApp({Key key}) : super(key: key);

  @override
  _HiAppState createState() => _HiAppState();
}

class _HiAppState extends State<HiApp> {
  HiRouteDelegate _routeDelegate = HiRouteDelegate();
  HiRouteInformationParser _routeInformationParser = HiRouteInformationParser();

  @override
  Widget build(BuildContext context) {
    final router = fluro.FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    // 通过 FutureBuilder 完成预初始化
    return FutureBuilder<HiCache>(
      // 初始化 HiCache, 通过 HiCache 可以获取到登录态
      future: HiCache.preInit(),
      builder: (BuildContext context, AsyncSnapshot<HiCache> snapshot) {
        // 定义 route
        var widget = snapshot.connectionState == ConnectionState.done
            ? Router(
                routeInformationParser: _routeInformationParser,
                routerDelegate: _routeDelegate,
                // routeInformationParser 为 null 时可缺省，routeInformationProvider 和 routeInformationParser 配合使用
                routeInformationProvider: PlatformRouteInformationProvider(
                  initialRouteInformation: RouteInformation(location: "/"),
                ),
              )
            : Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );

        return MultiProvider(
          providers: topProviders,
          child: Consumer<ThemeProvider>(builder: (BuildContext context,
              ThemeProvider themeProvider, Widget child) {
            return MaterialApp(
              title: 'E 社工', // 快照名
              home: widget,
              theme: themeProvider.getTheme(context),
              darkTheme: themeProvider.getTheme(context, isDarkMode: true),
              themeMode: themeProvider.getThemeMode(),
              debugShowCheckedModeBanner: false,
              onGenerateRoute: Application.router.generator,
              // home: MyHomePage(title: 'Flutter Demo Home Page'),
              // home: BottomNavigator(),

              // 国际化配置
              localizationsDelegates: const [
                S.delegate, // 设置语言
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate
              ],
              // 设置中文为首选项,没有适配语言时,英语为首选项
              supportedLocales: [
                const Locale('zh', 'CN'),
                ...S.delegate.supportedLocales
              ],
              // 插件目前不完善手动处理简繁体
              localeResolutionCallback: (locale, supportLocales) {
                // 中文 简繁体处理
                if (locale?.languageCode == 'zh') {
                  if (locale?.scriptCode == 'Hant') {
                    return const Locale('zh', 'HK'); //繁体
                  } else {
                    return const Locale('zh', 'CN'); //简体
                  }
                }
                return null;
              },
            );
          }),
        );
      },
    );
  }
}
