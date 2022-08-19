import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:get/get.dart';

import '../modules/home/controllers/home_controller.dart';

class QuillWidget extends StatelessWidget {
  QuillWidget({
    Key? key,
  }) : super(key: key);

  final HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    // TODO: 1.展开全屏 2.自动向下滚动 3.一键到顶部或底部
    // 4.自定义toolbar如一键截取视频当前画面和一键插入当前字幕，或所有字幕
    // 5.插入本地视频文件或图片
    return Container(
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
        minHeight: 200.0,
      ),
      color: Colors.grey,
      child: QuillEditor.basic(
        controller: homeController.quillController,
        readOnly: false, // true for view only mode
      ),
    );
  }
}
