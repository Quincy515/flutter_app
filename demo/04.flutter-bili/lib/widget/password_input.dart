import 'package:e_social_work/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';

class PasswordInput extends StatefulWidget {
  final String hint;
  final ValueChanged<String> onChange;

  const PasswordInput({Key key, this.onChange, this.hint}) : super(key: key);

  @override
  _PasswordInputState createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  final _focusNode = FocusNode(); // 输入框获取光标
  bool _obscureText = true; // 输入框内容是否可见,该组件是密码输入框默认不可见

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: _focusNode,
                    onChanged: widget.onChange,
                    autofocus: false, // 密码输入框不自动获取焦点
                    cursorColor: primary,
                    obscureText: _obscureText,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w300),
                    // 输入框的样式
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.only(left: 24, right: 20),
                      border: InputBorder.none,
                      hintText: widget.hint??S.of(context).loginInputPasswordHint,
                      hintStyle: TextStyle(fontSize: 15, color: Colors.grey),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(right: 24),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(_obscureText
                        ? Icons.lock_outlined
                        : Icons.lock_open_outlined),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
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
