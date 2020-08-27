import 'package:flutter/material.dart';
import 'package:flutter_app/provider/details_info.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsHTML extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsDetails = Provider.of<DetailsInfoProvide>(context, listen: false)
        .goodsInfo
        .data
        .goodInfo
        .goodsDetail;
    return Consumer<DetailsInfoProvide>(
      builder: (context, t, child) {
        var isLeft = t.isLeft;
        if (isLeft) {
          return Container(
            child: Html(
              data: goodsDetails,
            ),
          );
        } else {
          return Container(
            width: ScreenUtil().setWidth(750),
            padding: EdgeInsets.all(10.0),
            alignment: Alignment.center,
            child: Text('暂时没有数据'),
          );
        }
      },
    );
  }
}
