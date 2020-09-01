import 'package:flutter/material.dart';
import 'package:flutter_app/provide/cart_provide.dart';
import 'package:flutter_app/provide/theme_provide.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';

class CartPage extends StatelessWidget {
  // 只保留一个 slidable 打开
  final SlidableController _slidableController = SlidableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('购物车'),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 15),
            child: InkWell(
              onTap: () {
                Provider.of<ThemeProvide>(context, listen: false).change();
              },
              child: Icon(Icons.brightness_4),
            ),
          ),
        ],
      ),
      body: Consumer<CartProvide>(builder: (context, t, child) {
        if (t.models.length == 0) {
          return Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: Image.asset('lib/assets/image/shop_cart.png',
                      width: 90, height: 90),
                ),
                Text(
                  '购物车空空如也，去逛逛把~',
                  style: TextStyle(fontSize: 16.0),
                )
              ],
            ),
          );
        } else {
          return Stack(
            children: <Widget>[
              // 商品列表
              ListView.builder(
                  itemCount: t.models.length,
                  itemBuilder: (context, index) {
                    return buildProductItem(t, index);
                  }),
              // 底部菜单栏
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                        top: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
                        bottom: BorderSide(width: 1, color: Color(0xFFE8E8ED)),
                      )),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Padding(
                          padding: EdgeInsets.only(left: 5.0, right: 5.0),
                          child: Image.asset(
                            t.isSelectAll
                                ? 'lib/assets/image/selected.png'
                                : 'lib/assets/image/unselect.png',
                            width: 20,
                            height: 20,
                          ),
                        ),
                        onTap: () {
                          // 选中事件
                          t.changeSelectAll();
                        },
                      ),
                      Text('全选', style: TextStyle(color: Color(0xFF999999))),
                      SizedBox(width: 10),
                      Text('合计', style: TextStyle(fontSize: 16.0)),
                      Text('￥${t.getAmount()}',
                          style: TextStyle(
                              fontSize: 16.0,
                              color: Color(0xFFe4393c),
                              fontWeight: FontWeight.w500)),
                      Spacer(),
                      Container(
                        width: 120,
                        height: double.infinity,
                        color: Color(0xFFe4393c),
                        child: Center(
                          child: Text(
                            '去结算(${t.getSelectedCount()})',
                            style: TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }

  Widget buildProductItem(CartProvide t, int index) {
    return Slidable(
      child: Row(
        children: <Widget>[
          InkWell(
            child: Padding(
              padding: EdgeInsets.only(left: 8.0),
              child: Image.asset(
                t.models[index].isSelected
                    ? 'lib/assets/image/selected.png'
                    : 'lib/assets/image/unselect.png',
                width: 20,
                height: 20,
              ),
            ),
            onTap: () {
              // 选中事件
              t.changeSelectId(t.models[index].id);
            },
          ),
          Expanded(
              child: Card(
            margin: EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(right: 5.0),
                  child: Image.asset(
                    'lib/assets/${t.models[index].loopImgUrl[0]}',
                    width: 90,
                    height: 90,
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          t.models[index].title,
                          style: TextStyle(
                              fontSize: 16.0, fontWeight: FontWeight.w400),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: <Widget>[
                          Text(
                            '￥${t.models[index].price}',
                            style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFe93b3d)),
                          ),
                          Spacer(),
                          InkWell(
                            child: Container(
                              width: 35,
                              height: 35,
                              color: Color(0xFFF7F7F7),
                              child: Center(
                                child: t.models[index].count > 1
                                    ? Text('-',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: t.models[index].count == 1
                                                ? Color(0xFFB0B0B0)
                                                : Colors.black))
                                    : Text(''),
                              ),
                            ),
                            onTap: () {
                              // 减号
                              if (t.models[index].count > 1) {
                                t.models[index].count -= 1;
                                t.addToCart(t.models[index]);
                              }
                            },
                          ),
                          SizedBox(width: 2),
                          Container(
                              width: 35,
                              height: 35,
                              child: Center(
                                  child: Text('${t.models[index].count}'))),
                          SizedBox(width: 2),
                          InkWell(
                            child: Container(
                                width: 35,
                                height: 35,
                                color: Color(0xFFF7F7F7),
                                child: Center(
                                    child: Text('+',
                                        style: TextStyle(fontSize: 18.0)))),
                            onTap: () {
                              // 加号
                              t.models[index].count += 1;
                              t.addToCart(t.models[index]);
                            },
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
        ],
      ),
      controller: _slidableController,
      // 只保留一个 slid 打开
      actionPane: SlidableDrawerActionPane(),
      // 显示效果
      actionExtentRatio: 0.2,
      // 右侧显示大小的比例
      secondaryActions: <Widget>[
        // 右侧的 action
        SlideAction(
          child: Center(
            child: Text('删除',
                style: TextStyle(color: Colors.white, fontSize: 16.0)),
          ),
          color: Color(0xFFe4393c),
          onTap: () {
            // 删除事件
            t.removeFromCart(t.models[index].id);
          },
        ),
      ],
    );
  }
}
