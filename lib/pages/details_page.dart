import 'package:flutter/material.dart';
import 'package:flutter_app/provider/details_info.dart';
import 'package:provider/provider.dart';

class DetailsPage extends StatelessWidget {
  final String goodsId; // 传递进来的商品ID
  DetailsPage(this.goodsId); // 构造函数接收参数

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // 返回上一个页面
          },
        ),
        title: Text('商品详情页'),
      ),
      // FutureBuilder 主要可以异步加载
      body: FutureBuilder(
        future: _getBackInfo(context),
        builder: (context, snapshot) {
          // 匿名函数
          if (snapshot.hasData) {
            return Container(
              child: Column(
                children: <Widget>[Text('商品ID: ${goodsId}')],
              ),
            );
          } else {
            return CircularProgressIndicator(); // 加载中
          }
        },
      ),
    );
  }

  Future _getBackInfo(BuildContext context) async {
    await context.watch<DetailsInfoProvide>().getGoodsInfo(goodsId);
    return '完成加载';
  }
}
