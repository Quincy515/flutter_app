import 'package:flutter/material.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId; // 传递进来的商品ID
  DetailsPage(this.goodsId); // 构造函数接收参数

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('商品 ID: ${goodsId}'), // 把字面量显示到页面
      ),
    );
  }
}
