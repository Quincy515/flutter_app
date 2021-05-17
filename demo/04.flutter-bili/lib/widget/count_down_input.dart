import 'package:e_social_work/widget/index.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';

class CountDownInput extends StatefulWidget {
  final String mobile;
  final ValueChanged<String> onChange;

  const CountDownInput(this.mobile, {Key key, this.onChange}) : super(key: key);

  @override
  _CountDownInputState createState() => _CountDownInputState();
}

class _CountDownInputState extends State<CountDownInput> {
  final _focusNode = FocusNode(); // 输入框获取光标

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextField(
                  focusNode: _focusNode,
                  onChanged: widget.onChange,
                  keyboardType: TextInputType.number,
                  autofocus: true, // 不是密码输入类型就自动获取焦点
                  cursorColor: primary,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                  // 输入框的样式
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(left: 24, right: 20),
                    border: InputBorder.none,
                    hintText: '请输入验证码',
                    hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 24),
                child: TimerCountDownWidget(
                  () {
                    // TODO: 发送验证码函数
                  },
                  onTimerFinish: () {
                    print('倒计时结束');
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(left: 24, right: 24),
            child: Divider(
              height: 1,
              thickness: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}
