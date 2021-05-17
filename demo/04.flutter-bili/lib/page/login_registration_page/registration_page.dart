import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/http/dao/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/string_util.dart';
import 'package:hi_base/toast.dart';
import 'package:hi_net/core/hi_error.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key key}) : super(key: key);

  @override
  _RegistrationPageState createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool protect = false;
  bool loginEnable = false;
  String userName;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: leftRightAppBar("注册", "登录", () {
        print('点击了右边按钮');
      }),
      body: Container(
        child: ListView(
          // 自适应键盘弹起，防止遮挡
          children: [
            LoginInput(
              // title: "用户名",
              hint: S.of(context).loginInputHint,
              keyboardType: TextInputType.number,
              onChange: (text) {
                userName = text;
                checkInput();
              },
            ),
            LoginInput(
              hint: S.of(context).loginInputPasswordHint,
              obscureText: !protect,
              onChange: (text) {
                password = text;
                checkInput();
              },
              focusChange: (focus) {
                this.setState(() {
                  protect = focus;
                });
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 20, left: 20, right: 20),
              child: NextButton(S.of(context).registration,
                  enable: loginEnable, onPressed: checkParams),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (!ObjectUtil.isEmptyString(userName) && isNotEmpty(password)) {
      enable = true;
    }
    setState(() {
      loginEnable = enable;
    });
  }

  void checkParams() {
    String tips;
    if (!RegexUtil.isMobileExact(userName)) {
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

  void send() async {
    try {
      var result =
          await LoginDao.registration(userName, password, '123', '1123');
      print(result);
      if (result['code'] == 0) {
        showToast(S.of(context).registrationSuccess);
      } else {
        print(result['msg']);
        showWarnToast(result['msg']);
      }
    } on NeedAuth catch (e) {
      print(e);
      showWarnToast(e.message);
    } on HiNetError catch (e) {
      print(e);
      showWarnToast(e.message);
    }
  }
}
