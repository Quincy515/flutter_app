import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MemberPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('会员中心'),
      ),
      body: ListView(
        children: <Widget>[
          _topHeader(),
        ],
      ),
    );
  }

  // 头像区域
  Widget _topHeader() {
    return Container(
      width: ScreenUtil().setWidth(750),
      padding: EdgeInsets.all(20),
      color: Colors.pinkAccent,
      child: Column(
        children: <Widget>[
          Container(
            margin: EdgeInsets.only(top: 30),
            child: ClipOval(
              child: Image.network(
                  'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1598611846969&di=b4863ad9563c9b6252c8afb3b9f948dd&imgtype=0&src=http%3A%2F%2Fb.hiphotos.baidu.com%2Fimage%2Fpic%2Fitem%2Fbd315c6034a85edf8c1758e240540923dc547553.jpg'),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            child: Text(
              'Flutter学习',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(36), color: Colors.black54),
            ),
          ),
        ],
      ),
    );
  }
}
