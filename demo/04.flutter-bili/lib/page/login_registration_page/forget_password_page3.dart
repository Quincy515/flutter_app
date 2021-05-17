import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/page/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/toast.dart';

/// Page1: 输入手机号
/// Page2: 获取验证码
/// Page3: 重置密码 <--
class ForgetPasswordPage3 extends StatefulWidget {
  final String mobile;
  final String code;
  const ForgetPasswordPage3(this.mobile, this.code, {Key key})
      : super(key: key);

  @override
  _ForgetPasswordPage3State createState() => _ForgetPasswordPage3State();
}

class _ForgetPasswordPage3State extends State<ForgetPasswordPage3> {
  bool nextButtonEnable = true;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            ForgetPasswordTitle(),
            Container(
              margin: EdgeInsets.only(left: 24, bottom: 50),
              child: Text(
                '您已通过验证，请重置密码',
                style: TextStyle(fontSize: 14),
              ),
            ),
            PasswordInput(
              hint: '字母-数字组合，6-20位',
              onChange: (text) {
                password = text;
                checkInput();
              },
            ),
            Padding(
              padding: EdgeInsets.all(32),
              child: NextButton('完成',
                  enable: nextButtonEnable, onPressed: checkParams),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (!ObjectUtil.isEmptyString(password)) {
      enable = true;
    }
    setState(() {
      nextButtonEnable = enable;
    });
  }

  void checkParams() {
    String tips;
    if (!RegexUtil.isMobileExact(widget.mobile)) {
      tips = S.of(context).mobileNumErr;
    } else if (ObjectUtil.isEmptyString(widget.code) ||
        widget.code.length != 6) {
      tips = '验证码格式错误';
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
    showToast('手机号:${widget.mobile}，验证码${widget.code}，密码:$password');
  }
}
