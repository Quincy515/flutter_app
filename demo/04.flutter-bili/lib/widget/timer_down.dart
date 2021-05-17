import 'dart:async';

import 'package:e_social_work/generated/l10n.dart';
import 'package:flutter/material.dart';

class TimerCountDownWidget extends StatefulWidget {
  final Function onTimerFinish;
  final Function sendCode;
  const TimerCountDownWidget(this.sendCode, {Key key, this.onTimerFinish})
      : super(key: key);

  @override
  _TimerCountDownWidgetState createState() => _TimerCountDownWidgetState();
}

class _TimerCountDownWidgetState extends State<TimerCountDownWidget> {
  Timer _timer;
  int _countDown = 60;

  @override
  void initState() {
    super.initState();
    // 开始倒计时
    startCountDown();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (_countDown == 0) {
          setState(() {
            _countDown = 60;
          });
          // 开始倒计时
          startCountDown();
        }
      },
      child: Text(
        _countDown > 0 ? '$_countDown秒' : S.of(context).resendCode,
        style: TextStyle(
          fontSize: 14,
          // color: _countDown > 0 ? primary : Color.fromARGB(255, 17, 132, 255),
        ),
      ),
    );
  }

  void startCountDown() {
    // 发送验证码函数
    widget.sendCode();

    _timer = Timer.periodic(
        Duration(seconds: 1),
        (Timer timer) => {
              setState(() {
                if (_countDown < 1) {
                  widget.onTimerFinish();
                  _timer.cancel();
                } else {
                  _countDown = _countDown - 1;
                }
              })
            });
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }
}
