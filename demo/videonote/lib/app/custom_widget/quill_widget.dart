import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../modules/home/home_controller.dart';

class QuillWidget extends StatelessWidget {
  QuillWidget({
    Key? key,
    this.width,
    this.height,
  }) : super(key: key);

  final double? width;
  final double? height;
  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // TODO: 1.展开全屏 2.自动向下滚动 3.一键到顶部或底部
    // 4.自定义toolbar如一键截取视频当前画面和一键插入当前字幕，或所有字幕
    // 5.插入本地视频文件或图片
    return  Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0),
      child: Column(
        children: [
          QuillToolbar.basic(controller: homeController.quillController),
          SizedBox(
            height: height ?? MediaQuery.of(context).size.height * 0.9,
            child: ListView(
              padding: EdgeInsets.zero,
              scrollDirection: Axis.vertical,
              children: [
                QuillEditor.basic(
                  controller: homeController.quillController,
                  readOnly: false, // true for view only mode
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
