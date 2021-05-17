import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/router/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/toast.dart';

class MobilePage extends StatefulWidget {
  const MobilePage({Key key}) : super(key: key);

  @override
  _MobilePageState createState() => _MobilePageState();
}

class _MobilePageState extends State<MobilePage> {
  String mobile;
  bool loginEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            title(context),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: LoginInput(
                hint: S.of(context).loginInputHint,
                keyboardType: TextInputType.number,
                onChange: (text) {
                  mobile = text;
                  checkInput();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 32, left: 32, right: 32),
              child: NextButton(S.of(context).codeButton,
                  enable: loginEnable, onPressed: getCode),
            ),
            mobilePasswordLogin(
                context, S.of(context).mobilePasswordLoginText, Routes.login),
            socialLogin(context),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (!ObjectUtil.isEmptyString(mobile)) {
      enable = true;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void getCode() {
    String tips;
    if (!RegexUtil.isMobileExact(mobile)) {
      tips = S.of(context).mobileNumErr;
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    // TODO: 发送验证码，并跳转到验证码输入页面
    Application.router.navigateTo(context, Routes.verificationCode,
        routeSettings: RouteSettings(name: mobile),
        transition: TransitionType.cupertino);
    print('发送验证码，并跳转到验证码输入页面');
  }
}

// 欢迎使用E社工
// 未注册手机号登录后将自动创建账号
Widget title(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 78, left: 24),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(S.of(context).welcomeText,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
        Text(S.of(context).welcomeTextHint, style: TextStyle(fontSize: 16)),
      ],
    ),
  );
}

// 手机密码登录的显示
Widget mobilePasswordLogin(BuildContext context, String text, String path) {
  return InkWell(
    onTap: () {
      Application.router
          .navigateTo(context, path, transition: TransitionType.cupertino);
    },
    child: Container(
      margin: EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(text, style: TextStyle(fontSize: 14)),
          Icon(Icons.arrow_forward_ios, size: 14),
        ],
      ),
    ),
  );
}

// 微信和苹果登录的显示
Widget socialLogin(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 180),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          onTap: () {
            Application.router.navigateTo(context, Routes.bindMobile1,
                transition: TransitionType.cupertino);
          },
          child: Image(
            height: 32,
            width: 32,
            image: AssetImage('images/wechat.png'),
          ),
        ),
        SizedBox(width: 32),
        Image(
          height: 32,
          width: 32,
          image: AssetImage('images/apple.png'),
        ),
      ],
    ),
  );
}
