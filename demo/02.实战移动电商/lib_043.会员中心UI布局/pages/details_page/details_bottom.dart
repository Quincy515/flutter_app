import 'package:flutter/material.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:flutter_app/provider/current_index.dart';
import 'package:flutter_app/provider/details_info.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class DetailsBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var goodsInfo = Provider.of<DetailsInfoProvide>(context, listen: false)
        .goodsInfo
        .data
        .goodInfo;
    var goodsId = goodsInfo.goodsId;
    var goodsName = goodsInfo.goodsName;
    var count = 1;
    var price = goodsInfo.presentPrice;
    var images = goodsInfo.image1;

    return Container(
      width: ScreenUtil().setWidth(750),
      color: Colors.white,
      height: ScreenUtil().setHeight(80),
      child: Row(
        children: <Widget>[
          Stack(children: <Widget>[
            InkWell(
              onTap: () {
                Provider.of<CurrentIndexProvide>(context, listen: false)
                    .changeIndex(2); // 修改Provider
                Navigator.pop(context); // 跳转
              },
              child: Container(
                width: ScreenUtil().setWidth(110),
                alignment: Alignment.center,
                child: Icon(
                  Icons.add_shopping_cart,
                  size: 35,
                  color: Colors.red,
                ),
              ),
            ),
            Consumer<CartProvider>(builder: (context, t, child) {
              int goodsCount = t.allGoodsCount;
              return Positioned(
                top: 0,
                right: 10,
                child: Container(
                  padding: EdgeInsets.fromLTRB(6, 3, 6, 3),
                  decoration: BoxDecoration(
                    color: Colors.pink,
                    border: Border.all(width: 2, color: Colors.white),
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Text(
                    '${goodsCount}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: ScreenUtil().setSp(22),
                    ),
                  ),
                ),
              );
            }),
          ]),
          InkWell(
            onTap: () async {
              await Provider.of<CartProvider>(context, listen: false)
                  .save(goodsId, goodsName, count, price, images);
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.green,
              child: Text('加入购物车', style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(28)),),
            ),
          ),
          InkWell(
            onTap: () async {
              await Provider.of<CartProvider>(context, listen: false).remove();
            },
            child: Container(
              alignment: Alignment.center,
              width: ScreenUtil().setWidth(320),
              height: ScreenUtil().setHeight(80),
              color: Colors.red,
              child: Text('立即购买', style: TextStyle(
                  color: Colors.white, fontSize: ScreenUtil().setSp(28)),),
            ),
          ),
        ],
      ),
    );
  }
}
