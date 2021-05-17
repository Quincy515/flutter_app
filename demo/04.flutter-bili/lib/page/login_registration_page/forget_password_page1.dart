import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/router/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/toast.dart';

/// Page1: 输入手机号 <--
/// Page2: 获取验证码
/// Page3: 重置密码
class ForgetPasswordPage1 extends StatefulWidget {
  const ForgetPasswordPage1({Key key}) : super(key: key);

  @override
  _ForgetPasswordPage1State createState() => _ForgetPasswordPage1State();
}

class _ForgetPasswordPage1State extends State<ForgetPasswordPage1> {
  String mobile;
  bool nextButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            ForgetPasswordTitle(),
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
    Application.router.navigateTo(context, Routes.forgetPassword2,
        routeSettings: RouteSettings(name: mobile),
        transition: TransitionType.cupertino);
  }
}

class ForgetPasswordTitle extends StatelessWidget {
  const ForgetPasswordTitle({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: 78, left: 24),
        child: Text(
          '修改密码',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
        ));
  }
}
