import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/http/index.dart';
import 'package:e_social_work/navigator/index.dart';
import 'package:e_social_work/page/index.dart';
import 'package:e_social_work/router/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/toast.dart';
import 'package:hi_net/core/hi_error.dart';

class MobilePasswordLogin extends StatefulWidget {
  const MobilePasswordLogin({Key key}) : super(key: key);

  @override
  _MobilePasswordLoginState createState() => _MobilePasswordLoginState();
}

class _MobilePasswordLoginState extends State<MobilePasswordLogin> {
  String mobile;
  String password;
  bool nextButtonEnable = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(children: [
          title(context),
          Container(
            margin: EdgeInsets.only(top: 78),
            child: LoginInput(
              hint: S.of(context).loginInputHint,
              // keyboardType: TextInputType.number,
              onChange: (text) {
                mobile = text;
                checkInput();
              },
            ),
          ),
          PasswordInput(
            onChange: (text) {
              password = text;
              checkInput();
            },
          ),
          Row(
            children: [
              Spacer(),
              InkWell(
                  onTap: () {
                    Application.router.navigateTo(
                        context, Routes.forgetPassword1,
                        transition: TransitionType.cupertino);
                  },
                  child: Text('忘记密码')),
              SizedBox(width: 15)
            ],
          ),
          Padding(
              padding: EdgeInsets.only(top: 32, left: 32, right: 32),
              child: NextButton('手机密码登录',
                  enable: nextButtonEnable, onPressed: checkParams)),
          mobilePasswordLogin(context, '手机验证码登录', Routes.mobile),
          socialLogin(context),
        ]),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (!ObjectUtil.isEmptyString(mobile) &&
        !ObjectUtil.isEmptyString(password)) {
      enable = true;
    }
    setState(() {
      nextButtonEnable = enable;
    });
  }

  void send() async {
    showToast('手机号:$mobile,密码:$password');
    try {
      var result = await LoginDao.login(mobile, password);
      print(result);
      if (result['code'] == 0) {
        showToast('登录成功');
        HiNavigator.getInstance().onJumpTo(RouteStatus.home);
      } else {
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      showWarnToast(e.toString());
    } on HiNetError catch (e) {
      showWarnToast(e.toString());
    }
  }

  void checkParams() {
    String tips;
    if (RegexUtil.isMobileExact(mobile)) {
      tips = S.of(context).mobileNumErr;
    } else if (password.length < 6 || password.length > 20) {
      tips = S.of(context).passwordNumErr;
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    send();
  }
}
