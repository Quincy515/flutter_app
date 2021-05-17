import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/router/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/toast.dart';

/// Page1: 输入手机号 <--
/// Page2: 获取验证码 进行绑定
class BindMobilePage1 extends StatefulWidget {
  const BindMobilePage1({Key key}) : super(key: key);

  @override
  _BindMobilePage1State createState() => _BindMobilePage1State();
}

class _BindMobilePage1State extends State<BindMobilePage1> {
  String mobile;
  bool nextButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            BindMobileTitle(),
            Container(
              margin: EdgeInsets.only(top: 100),
              child: LoginInput(
                hint: S.of(context).loginInputHint,
                onChange: (text) {
                  mobile = text;
                  checkInput();
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: NextButton(S.of(context).codeButton,
                  enable: nextButtonEnable, onPressed: checkParams),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (RegexUtil.isMobileExact(mobile)) {
      enable = true;
    }
    setState(() {
      nextButtonEnable = enable;
    });
  }

  void checkParams() {
    String tips;
    if (!RegexUtil.isMobileExact(mobile)) {
      tips = S.of(context).mobileNumErr;
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    Application.router.navigateTo(context, Routes.bindMobile2,
        routeSettings: RouteSettings(name: mobile),
        transition: TransitionType.cupertino);
  }
}

// 绑定手机号
// 未注册手机号登录后将自动创建账号
class BindMobileTitle extends StatelessWidget {
  const BindMobileTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 78, left: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('绑定手机号',
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600)),
          Text('未注册手机号登录后将自动创建账号', style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
