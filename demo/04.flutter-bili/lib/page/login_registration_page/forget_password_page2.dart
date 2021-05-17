import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/page/index.dart';
import 'package:e_social_work/router/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:fluro/fluro.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/toast.dart';

/// Page1: 输入手机号
/// Page2: 获取验证码 <--
/// Page3: 重置密码
class ForgetPasswordPage2 extends StatefulWidget {
  final String mobile;
  const ForgetPasswordPage2(this.mobile, {Key key}) : super(key: key);

  @override
  _ForgetPasswordPage2State createState() => _ForgetPasswordPage2State();
}

class _ForgetPasswordPage2State extends State<ForgetPasswordPage2> {
  String code;
  bool nextButtonEnable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            ForgetPasswordTitle(),
            SendCode(widget.mobile),
            CountDownInput(
              widget.mobile,
              onChange: (text) {
                code = text;
                checkInput();
              },
            ),
            Padding(
                padding: EdgeInsets.all(32),
                child: NextButton('下一步',
                    enable: nextButtonEnable, onPressed: checkParams)),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable = false;
    if (!ObjectUtil.isEmptyString(code) && code.length == 6) {
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
    } else if (ObjectUtil.isEmptyString(code) || code.length != 6) {
      tips = '验证码格式错误';
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    Application.router.navigateTo(
        context, '/forgetPassword3?mobile=${widget.mobile}&code=$code',
        transition: TransitionType.cupertino);
  }
}
