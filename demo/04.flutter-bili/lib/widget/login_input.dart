import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';

/// 输入框组件，自定义 widget
class LoginInput extends StatefulWidget {
  final String title; // 标题
  final String hint; // 提示文案
  final ValueChanged<String> onChange; // 带传值的回调函数
  final ValueChanged<bool> focusChange; // 获取输入框焦点的回调函数
  final bool lineStretch; // 输入框底部的线条是否铺满
  final bool obscureText; // 输入框的内容是否可见
  final TextInputType keyboardType; // 控制键盘的输入类型

  const LoginInput(
      {Key key,
      this.title,
      this.hint,
      this.onChange,
      this.focusChange,
      this.lineStretch = false, // 底部线的展开默认是false使用短线形式
      this.obscureText = false, // 默认可以看到输入框的内容
      this.keyboardType})
      : super(key: key);

  @override
  _LoginInputState createState() => _LoginInputState();
}

class _LoginInputState extends State<LoginInput> {
  final _focusNode = FocusNode(); // 输入框获取光标

  @override
  void initState() {
    super.initState();
    // 输入框是否获取光标的监听
    _focusNode.addListener(() {
      print("Has focus: ${_focusNode.hasFocus}");
      if (widget.focusChange != null) {
        widget.focusChange(_focusNode.hasFocus);
      }
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.title != null) {
      return Column(
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.only(left: 15),
                width: 100,
                child: Text(
                  widget.title ?? '',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              _input(),
            ],
          ),
          buildPadding(),
        ],
      );
    }
    return Column(
      children: [
        Row(
          children: [
            _input(),
          ],
        ),
        buildPadding(),
      ],
    );
  }

  Padding buildPadding() {
    return Padding(
      padding: EdgeInsets.only(
          left: !widget.lineStretch ? 24 : 0,
          right: !widget.lineStretch ? 24 : 0),
      child: Divider(
        height: 1,
        thickness: 0.5,
      ),
    );
  }

  // 返回一个输入框
  _input() {
    return Expanded(
        child: TextField(
      focusNode: _focusNode,
      onChanged: widget.onChange,
      obscureText: widget.obscureText,
      keyboardType: widget.keyboardType,
      autofocus: !widget.obscureText, // 不是密码输入类型就自动获取焦点
      cursorColor: primary,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
      // 输入框的样式
      decoration: InputDecoration(
        contentPadding: EdgeInsets.only(left: 24, right: 20),
        border: InputBorder.none,
        hintText: widget.hint ?? '',
        hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
      ),
    ));
  }
}
