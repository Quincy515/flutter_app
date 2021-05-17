import 'package:e_social_work/generated/l10n.dart';
import 'package:e_social_work/page/index.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';
import 'package:hi_base/toast.dart';

class VerificationCodePage extends StatefulWidget {
  final String mobile;
  const VerificationCodePage(this.mobile, {Key key}) : super(key: key);

  @override
  _VerificationCodePageState createState() => _VerificationCodePageState();
}

class _VerificationCodePageState extends State<VerificationCodePage> {
  bool nextButtonEnable = false;
  bool _checked = false;
  String code;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: ListView(
          children: [
            title(context),
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
                child: NextButton('立即登录',
                    enable: nextButtonEnable, onPressed: send)),
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
          ],
        ),
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

  // 发送立即登录请求
  void send() {
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
    // TODO: 发送手机号验证码登录注册请求
    showToast('手机号: ${widget.mobile} 验证码: $code');
  }

  // 检查输入
  void checkInput() {
    bool enable = false;
    if (!ObjectUtil.isEmptyString(code) && code.length == 6) {
      enable = true;
    }
    setState(() {
      nextButtonEnable = enable;
    });
  }
}

// 验证码发送至137****0866
class SendCode extends StatelessWidget {
  final String mobile;

  const SendCode(this.mobile, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 64, left: 24, bottom: 24),
      child: Text('验证码已发送至 ' + TextUtil.hideNumber(mobile)),
    );
  }
}
