import 'package:flutter/material.dart';
import 'package:flutter_app/provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsTabBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<DetailsInfoProvide>(builder: (context, t, child) {
      var isLeft = t.isLeft;
      var isRight = t.isRight;

      return Container(
        margin: EdgeInsets.only(top: 15.0),
        child: Row(
          children: <Widget>[
            _myTabBarLeft(context, isLeft),
            _myTabBarRight(context, isRight),
          ],
        ),
      );
    });
  }

  // 左侧按钮
  Widget _myTabBarLeft(BuildContext context, bool isLeft) {
    return InkWell(
      onTap: () {
        Provider.of<DetailsInfoProvide>(context, listen: false)
            .changeLeftAndRight('left');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        // 居中显示
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
                width: 1, color: isLeft ? Colors.pinkAccent : Colors.black26),
          ),
        ),
        child: Text('详情',
            style: TextStyle(color: isLeft ? Colors.pink : Colors.black26)),
      ),
    );
  }

  // 左侧按钮
  Widget _myTabBarRight(BuildContext context, bool isRight) {
    return InkWell(
      onTap: () {
        Provider.of<DetailsInfoProvide>(context, listen: false)
            .changeLeftAndRight('right');
      },
      child: Container(
        padding: EdgeInsets.all(10.0),
        alignment: Alignment.center,
        // 居中显示
        width: ScreenUtil().setWidth(375),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            bottom: BorderSide(
                width: 1, color: isRight ? Colors.pinkAccent : Colors.black26),
          ),
        ),
        child: Text('评论',
            style: TextStyle(color: isRight ? Colors.pink : Colors.black26)),
      ),
    );
  }
}
