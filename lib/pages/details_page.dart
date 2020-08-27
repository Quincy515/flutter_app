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

  /// https://flutter.cn/docs/development/data-and-backend/state-mgmt/simple#providerof
  /// 有的时候你不需要模型中的 数据 来改变 UI，但是你可能还是需要访问该数据。
  /// 比如，ClearCart 按钮能够清空购物车的所有商品。它不需要显示购物车里的内容，只需要调用 clear() 方法。
  /// 在 build 方法中使用下面的代码，当 notifyListeners 被调用的时候，并不会使 widget 被重构。
  Future _getBackInfo(BuildContext context) async {
    await Provider.of<DetailsInfoProvide>(context, listen: false).getGoodsInfo(goodsId);
    // await context.watch<DetailsInfoProvide>().getGoodsInfo(goodsId); // 否则会一直重构请求数据再重构在请求数据
    return '完成加载';
  }
}
