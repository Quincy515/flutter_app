import 'package:flutter/material.dart';
import 'package:flutter_app/provider/details_info.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId; // 传递进来的商品ID
  DetailsPage(this.goodsId); // 构造函数接收参数

  @override
  Widget build(BuildContext context) {
    _getBackInfo(context);
    return Container(
      child: Scaffold(
        body: Center(
          child: Text('商品 ID: ${goodsId}'), // 把字面量显示到页面
        ),
      ),
    );
  }

  void _getBackInfo(BuildContext context) async {
    await context.watch<DetailsInfoProvide>().getGoodsInfo(goodsId);
    print('加载完成....');
  }
}
