import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/page/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';
import 'package:hi_base/toast.dart';

/// Page1: 输入手机号
/// Page2: 获取验证码 进行绑定 <--
class BindMobilePage2 extends StatefulWidget {
  final String mobile;
  const BindMobilePage2(this.mobile, {Key key}) : super(key: key);

  @override
  _BindMobilePage2State createState() => _BindMobilePage2State();
}

class _BindMobilePage2State extends State<BindMobilePage2> {
  bool nextButtonEnable = false;
  String code;
  bool _checked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(children: [
          BindMobileTitle(),
          Container(
            margin: EdgeInsets.only(top: 100),
            child: CountDownInput(
              widget.mobile,
              onChange: (text) {
                code = text;
                checkInput();
              },
            ),
          ),
          Padding(
              padding: EdgeInsets.all(32),
              child: NextButton('立即绑定',
                  enable: nextButtonEnable, onPressed: checkParams)),
          Container(
            margin: EdgeInsets.only(top: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                circularCheckBox(),
                SizedBox(width: 5),
                agreeText(),
              ],
            ),
          )
        ]),
      ),
    );
  }

  // 圆形选择框
  Container circularCheckBox() {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(width: 1),
        // borderRadius: BorderRadius.all(Radius.circular(100.0)),
      ),
      width: 20,
      height: 20,
      child: Theme(
        data: ThemeData(
          unselectedWidgetColor: Colors.transparent,
        ),
        child: Checkbox(
          tristate: false,
          value: _checked,
          checkColor: primary,
          activeColor: Colors.transparent,
          onChanged: (v) => setState(() => _checked = v),
          materialTapTargetSize: MaterialTapTargetSize.padded,
        ),
      ),
    );
  }

  // 勾选即同意“E社工平台服务协议”和“隐私政策”
  RichText agreeText() {
    return RichText(
      text: TextSpan(
        text: '勾选即同意“',
        style: TextStyle(color: Colors.black, fontSize: 14),
        children: <InlineSpan>[
          WidgetSpan(
            child: InkWell(
              onTap: () {},
              child: Text(
                'E社工平台服务协议',
                style: TextStyle(color: primary),
              ),
            ),
            alignment: PlaceholderAlignment.middle,
            baseline: TextBaseline.ideographic,
          ),
          TextSpan(
            text: '”和“',
            style: TextStyle(fontSize: 14),
          ),
          WidgetSpan(
            child: InkWell(
              onTap: () {},
              child: Text(
                '隐私政策',
                style: TextStyle(color: primary),
              ),
            ),
            alignment: PlaceholderAlignment.middle,
            baseline: TextBaseline.ideographic,
          ),
          TextSpan(
            text: '”',
            style: TextStyle(fontSize: 14),
          ),
        ],
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
    } else if (!_checked) {
      tips = '未选择隐私协议，不可登录注册';
    }
    if (tips != null) {
      showWarnToast(tips);
      return;
    }
    send();
  }

  void send() async {
    showToast('绑定手机号：${widget.mobile},验证码: $code');
  }
}
