import 'package:e_social_work/router/router_handler.dart';
import 'package:fluro/fluro.dart' as fluro;
import 'package:flutter/cupertino.dart';

class Routes {
  static String home = '/home'; // 主页
  static String dark = '/dark'; // 设置夜间模式页面
  static String mobile = '/mobile'; // 注册登录 - 验证码登录/注册
  static String login = '/login'; // 注册登录 - 手机密码登录/注册
  static String verificationCode = '/verification_code'; // 填写验证码页面
  static String registration = '/registration'; // 测试页面
  static String forgetPassword1 = '/forgetPassword1'; // 忘记密码第一步：输入手机号
  static String forgetPassword2 = '/forgetPassword2'; // 忘记密码第二步：输入验证码
  static String forgetPassword3 = '/forgetPassword3'; // 忘记密码第三步：输入新密码
  static String bindMobile1 = '/bindMobile1'; // 第三方登录后绑定手机号 第一步：输入手机号
  static String bindMobile2 = '/bindMobile2'; // 第三方登录后绑定手机号 第二步：输入验证码进行绑定

  // 注册路由
  static void configureRoutes(fluro.FluroRouter router) {
    router.notFoundHandler = new fluro.Handler(
        handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      print('页面走丢了~');
      return;
    });

    // 路由配置
    router.define(home, handler: homeHandler);
    router.define(dark, handler: darkHandler);
    router.define(mobile, handler: mobileHandler);
    router.define(login, handler: loginHandler);
    router.define(verificationCode, handler: verificationCodeHandler);
    router.define(registration, handler: registrationHandler);
    router.define(forgetPassword1, handler: forgetPassword1Handler);
    router.define(forgetPassword2, handler: forgetPassword2Handler);
    router.define(forgetPassword3, handler: forgetPassword3Handler);
    router.define(bindMobile1, handler: bindMobile1Handler);
    router.define(bindMobile2, handler: bindMobile2Handler);
  }
}
