import 'package:flutter/material.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartBottom extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(5.0),
      color: Colors.white,
      child: Consumer<CartProvider>(builder: (context, t, child) {
        return Row(
          children: <Widget>[
            selectAllBtn(context),
            allPriceArea(context),
            goButton(context),
          ],
        );
      }),
    );
  }

  // 全选按钮
  Widget selectAllBtn(context) {
    bool isAllCheck =
        Provider.of<CartProvider>(context, listen: false).isAllCheck;
    return Container(
      child: Row(
        children: <Widget>[
          Checkbox(
              value: isAllCheck,
              activeColor: Colors.pink,
              onChanged: (bool val) {
                Provider.of<CartProvider>(context, listen: false)
                    .changeAllCheckBtnState(val);
              }),
          Text('全选'),
        ],
      ),
    );
  }

  // 合计区域
  Widget allPriceArea(context) {
    double allPrice =
        Provider
            .of<CartProvider>(context, listen: true)
            .allPrice;
    return Container(
      width: ScreenUtil().setWidth(430),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              Container(
                alignment: Alignment.centerRight,
                width: ScreenUtil().setWidth(280),
                child: Text(
                  '合计: ',
                  style: TextStyle(fontSize: ScreenUtil().setSp(36)),
                ),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: ScreenUtil().setWidth(150),
                child: Text(
                  '￥ ${allPrice}',
                  style: TextStyle(
                      fontSize: ScreenUtil().setSp(36), color: Colors.red),
                ),
              ),
            ],
          ),
          Container(
            width: ScreenUtil().setWidth(430),
            alignment: Alignment.centerRight,
            child: Text(
              '满10元免配送费，预购免配送费',
              style: TextStyle(
                  fontSize: ScreenUtil().setSp(22), color: Colors.black38),
            ),
          ),
        ],
      ),
    );
  }

  // 结算
  Widget goButton(context) {
    int allGoodsCount = Provider
        .of<CartProvider>(context, listen: true)
        .allGoodsCount;
    return Container(
      width: ScreenUtil().setWidth(160),
      padding: EdgeInsets.only(left: 10),
      child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(10.0),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.circular(3.0),
          ),
          child: Text(
            '结算(${allGoodsCount})',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
