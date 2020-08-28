import 'package:flutter/material.dart';
import 'package:flutter_app/model/cart_info.dart';
import 'package:flutter_app/pages/cart_page/cart_count.dart';
import 'package:flutter_app/provider/cart.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CartItem extends StatelessWidget {
  final CartInfoModel item;

  CartItem(this.item); // 构造方法接收 CartInfoModel

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(5.0, 2.0, 5.0, 2.0),
      padding: EdgeInsets.fromLTRB(5.0, 10.0, 5.0, 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(width: 1, color: Colors.black12),
        ),
      ),
      child: Row(
        children: <Widget>[
          _cartCheckBt(context, item), // 横向布局
          _cartImage(),
          _cartGoodsName(),
          _cartPrice(context, item),
        ],
      ),
    );
  }

  // 勾选按钮
  Widget _cartCheckBt(context, item) {
    return Container(
      child: Checkbox(
        value: item.isCheck,
        activeColor: Colors.pink,
        onChanged: (bool val) {},
      ),
    );
  }

  // 商品图片
  Widget _cartImage() {
    return Container(
      width: ScreenUtil().setWidth(150),
      padding: EdgeInsets.all(3.0),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: Colors.black12), // 设置所有的边
      ),
      child: Image.network(item.images),
    );
  }

  // 商品名称
  Widget _cartGoodsName() {
    return Container(
      width: ScreenUtil().setWidth(300),
      padding: EdgeInsets.all(10),
      alignment: Alignment.topLeft,
      child: Column(
        children: <Widget>[
          Text(item.goodsName), // 商品名称
          CartCount(),
        ],
      ),
    );
  }

  // 商品价格
  Widget _cartPrice(context, item) {
    return Container(
      width: ScreenUtil().setWidth(150),
      alignment: Alignment.centerRight,
      child: Column(
        children: <Widget>[
          Text('￥${item.price}'), // 与数据模型类一一对应的
          Container(
            child: InkWell(
              onTap: () {
                Provider.of<CartProvider>(context, listen: false)
                    .deleteOneGoods(item.goodsId);
              },
              child:
                  Icon(Icons.delete_forever, color: Colors.black26, size: 30),
            ),
          ),
        ],
      ),
    );
  }
}
