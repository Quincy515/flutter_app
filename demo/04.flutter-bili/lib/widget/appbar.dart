import 'package:flutter/material.dart';
import 'package:hi_base/view_util.dart';

/// 自定义顶部左右格式的 AppBar
/// < 注册               登录
leftRightAppBar(
    String title, String rightTitle, VoidCallback rightButtonClick) {
  return AppBar(
    centerTitle: false, // title 居左
    titleSpacing: 0,
    elevation: 0,
    leading: BackButton(), // 左边设置返回按钮
    title: Text(title, style: TextStyle(fontSize: 18)),
    actions: [
      InkWell(
        onTap: rightButtonClick,
        child: Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          alignment: Alignment.center,
          child: Text(
            rightTitle,
            style: TextStyle(fontSize: 18, color: Colors.grey[500]),
            textAlign: TextAlign.center,
          ),
        ),
      )
    ],
  );
}

// 视频详情页 appBar
videoAppBar({VoidCallback download}) {
  return Container(
    padding: EdgeInsets.only(right: 8),
    decoration: BoxDecoration(gradient: blackLinearGradient(fromTop: true)),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        BackButton(color: Colors.white),
        Row(
          children: [
            IconButton(
              onPressed: download,
              icon: Icon(Icons.cloud_download_rounded),
              color: Colors.white,
              iconSize: 20,
            ),
            // Padding(
            //   padding: EdgeInsets.only(left: 12),
            //   child:
            //       Icon(Icons.more_vert_rounded, color: Colors.white, size: 20),
            // ),
          ],
        ),
      ],
    ),
  );
}
