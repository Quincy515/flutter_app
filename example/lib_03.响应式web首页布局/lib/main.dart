import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:oktoast/oktoast.dart';
import 'package:provider/provider.dart';
import 'package:shopping_mall/generated/l10n.dart';
import 'package:shopping_mall/page/index.dart';
import 'package:shopping_mall/provider/index.dart';
import 'package:shopping_mall/router/application.dart';
import 'package:shopping_mall/router/routes.dart';

void main() => runApp(MultiProvider(providers: providers, child: MyApp()));

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final router = fluro.FluroRouter();
    Routes.configureRoutes(router);
    Application.router = router;

    return LayoutBuilder(
      builder: (context, constraints) {
        //设置适配尺寸 (填入设计稿中设备的屏幕尺寸) 此处假如设计稿是按iPhone6的尺寸设计的(iPhone6 750*1334)
        ScreenUtil.init(
          constraints, // 设置字体大小根据系统的“字体大小”辅助选项来进行缩放,默认为false
          designSize: Size(375, 812), allowFontScaling: true,
        );
        return OKToast(
          dismissOtherOnShow: true,
          child: MaterialApp(
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

            title: 'shopping_mall',
            debugShowCheckedModeBanner: false,
            onGenerateRoute: Application.router.generator,
            theme: ThemeData(
              primarySwatch: Colors.blue,
              visualDensity: VisualDensity.adaptivePlatformDensity,
            ),
            home: HomePage(),
          ),
        );
      },
    );
  }
}
