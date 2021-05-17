import 'package:flutter/material.dart';
import 'package:hi_base/color.dart';

class NextButton extends StatelessWidget {
  final String title;
  final bool enable;
  final VoidCallback onPressed;

  const NextButton(this.title, {Key key, this.enable = true, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1, // 填满整个一行的宽度
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(206)),
        height: 45,
        onPressed: enable ? onPressed : null,
        disabledColor: primary[50],
        color: primary,
        child: Text(title, style: TextStyle(color: Colors.white, fontSize: 16)),
      ),
    );
  }
}
