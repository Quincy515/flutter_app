import 'package:flutter/material.dart';
import 'package:flutter_app/provide/bottom_navi_provide.dart';
import 'package:flutter_app/provide/cart_provide.dart';
import 'package:flutter_app/provide/product_detail_provide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class ProductDetailPage extends StatelessWidget {
  final String id;

  ProductDetailPage({this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('京东')),
      body: Container(
        child: Consumer<ProductDetailProvide>(
          builder: (context, t, child) {
            // 加载动画
            if (t.isLoading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
            // 捕获异常
            if (t.isError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(t.errorMsg),
                    OutlineButton(
                      child: Text('刷新'),
                      onPressed: () {
                        t.loadProduct(id: id); // 重新加载
                      },
                    )
                  ],
                ),
              );
            }

            // print("获取  model====>${t.model}");
            String baitiaoTitle = '【白条支付】首单立减优惠';
            for (var item in t.model.baitiao) {
              if (item.select == true) {
                baitiaoTitle = item.desc;
              }
            }

            return Stack(
              children: <Widget>[
                // 主题内容
                ListView(
                  children: <Widget>[
                    // 轮播图
                    buildSwiperContainer(t),
                    // 标题
                    buildTitleContainer(t),
                    // 价格
                    buildPriceContainer(t),
                    // 白条支付
                    buildPayContainer(baitiaoTitle, t, context),
                    // 商品件数
                    buildCountContainer(context, t),
                    SizedBox(height: 60),
                  ],
                ),

                // 底部菜单
                buildbottomPositioned(context, t),
              ],
            );
          },
        ),
      ),
    );
  }

  // 底部菜单
  Positioned buildbottomPositioned(
      BuildContext context, ProductDetailProvide t) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        decoration: BoxDecoration(
            border:
                Border(top: BorderSide(width: 1, color: Color(0xFFE8E8ED)))),
        child: Row(
          children: <Widget>[
            Expanded(
                child: InkWell(
              child: Container(
                height: 60,
                color: Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Stack(
                      children: <Widget>[
                        Container(
                            width: 40,
                            height: 30,
                            child: Icon(Icons.shopping_cart)),
                        Consumer<CartProvide>(builder: (context, t, child) {
                          return Positioned(
                            right: 0.0,
                            child: t.getAllCount() > 0
                                ? Container(
                                    padding: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(11.0),
                                    ),
                                    child: Text(
                                      '${t.getAllCount()}',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 11.0),
                                    ),
                                  )
                                : Container(),
                          );
                        }),
                      ],
                    ),
                    Text('购物车', style: TextStyle(fontSize: 13.0)),
                  ],
                ),
              ),
              onTap: () {
                // 先回到顶层
                Navigator.popUntil(context, ModalRoute.withName('/')); // 先回到顶层
                Provider.of<BottomNaviProvide>(context, listen: false)
                    .changeIndex(2); // 再跳转到购物车
              },
            )),
            Expanded(
                child: InkWell(
              child: Container(
                height: 60.0,
                color: Color(0xFFe93b3d),
                alignment: Alignment.center,
                child: Text(
                  '加入购物车',
                  style: TextStyle(
                      fontSize: 15.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              onTap: () {
                Provider.of<CartProvide>(context, listen: false)
                    .addToCart(t.model.partData);
                Fluttertoast.showToast(
                    msg: '成功加入购物车',
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    fontSize: 16.0);
              },
            )),
          ],
        ),
      ),
    );
  }

  // 商品件数
  Container buildCountContainer(BuildContext context, ProductDetailProvide t) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey),
            bottom: BorderSide(width: 1, color: Colors.grey),
          )),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text('已选'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text('${t.model.partData.count}件'),
              ),
            ),
            Icon(Icons.more_horiz),
          ],
        ),
        onTap: () {
          // 选择商品个数
          return showModalBottomSheet(
              backgroundColor: Colors.transparent, // 背景颜色透明
              context: context,
              builder: (BuildContext context) {
                return ChangeNotifierProvider<ProductDetailProvide>.value(
                  value: t,
                  child: Stack(
                    children: <Widget>[
                      Container(
                        color: Colors.white,
                        width: double.infinity,
                        height: double.infinity,
                        margin: EdgeInsets.only(top: 20),
                      ),
                      // 顶部：包含图片价格和数量信息
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        // 从最左侧开始布局
                        children: <Widget>[
                          Padding(
                            padding: EdgeInsets.only(left: 20, right: 20),
                            child: Image.asset(
                              'lib/assets${t.model.partData.loopImgUrl[0]}',
                              width: 90,
                              height: 90,
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(height: 30),
                              Text(
                                '￥${t.model.partData.price}',
                                style: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red),
                              ),
                              SizedBox(height: 10),
                              Text('已选${t.model.partData.count}件'),
                            ],
                          ),
                          Spacer(), // 靠在最右侧
                          Container(
                            margin: EdgeInsets.only(top: 20),
                            child: IconButton(
                              icon: Icon(Icons.close),
                              iconSize: 20,
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                        ],
                      ),
                      // 中间: 数量 加减号
                      Container(
                        margin: EdgeInsets.only(top: 90.0, bottom: 50.0),
                        padding: EdgeInsets.only(top: 40.0, left: 15.0),
                        child: Consumer<ProductDetailProvide>(
                            builder: (context, t, child) {
                          return Row(
                            children: <Widget>[
                              Text('数量'),
                              Spacer(),
                              InkWell(
                                child: Container(
                                  width: 35,
                                  height: 35,
                                  color: Color(0xFFF7F7F7),
                                  child: Center(
                                    child: Text('-',
                                        style: TextStyle(
                                            fontSize: 18.0,
                                            color: Color(0xFFB0B0B0))),
                                  ),
                                ),
                                onTap: () {
                                  // 减号
                                  int tmpCount = t.model.partData.count;
                                  tmpCount--;
                                  t.changeProductCount(tmpCount);
                                },
                              ),
                              SizedBox(width: 2),
                              Container(
                                  width: 35,
                                  height: 35,
                                  child: Center(
                                      child:
                                          Text('${t.model.partData.count}'))),
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
                                  int tmpCount = t.model.partData.count;
                                  tmpCount++;
                                  t.changeProductCount(tmpCount);
                                },
                              ),
                            ],
                          );
                        }),
                      ),
                      // 底部: 加入购物车按钮
                      Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: InkWell(
                            child: Container(
                                height: 50.0,
                                color: Color(0xFFE93B3D),
                                alignment: Alignment.center,
                                child: Text(
                                  '加入购物车',
                                  style: TextStyle(
                                      fontSize: 15.0,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                )),
                            onTap: () {
                              Provider.of<CartProvide>(context, listen: false)
                                  .addToCart(t.model.partData);
                              Navigator.pop(context);
                            },
                          ))
                    ],
                  ),
                );
              });
        },
      ),
    );
  }

  // 白条支付
  Container buildPayContainer(
      String baitiaoTitle, ProductDetailProvide t, BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
            top: BorderSide(width: 1, color: Colors.grey),
            bottom: BorderSide(width: 1, color: Colors.grey),
          )),
      child: InkWell(
        child: Row(
          children: <Widget>[
            Text('支付'),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                child: Text('$baitiaoTitle'),
              ),
            ),
            Icon(Icons.more_horiz),
          ],
        ),
        onTap: () {
          // 选择支付方式，白条支付、分期
          return showBaitiao(context, t);
        },
      ),
    );
  }

  // 选择支付方式，白条支付、分期
  Future showBaitiao(BuildContext context, ProductDetailProvide t) {
    return showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ChangeNotifierProvider<ProductDetailProvide>.value(
            value: t,
            child: Stack(
              children: <Widget>[
                // 顶部标题栏
                Stack(
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 40,
                      color: Color(0xFFF3F2F8),
                      child: Center(
                          child: Text(
                        '打白条购买',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      )),
                    ),
                    Positioned(
                        top: 0,
                        right: 0,
                        width: 40.0,
                        height: 40.0,
                        child: Center(
                          child: IconButton(
                            icon: Icon(Icons.close),
                            iconSize: 20,
                            onPressed: () {
                              // 关闭
                              Navigator.pop(context);
                            },
                          ),
                        )),
                  ],
                ),
                // 主题列表
                Container(
                  margin: EdgeInsets.only(top: 40.0, bottom: 50.0),
                  child: ListView.builder(
                      itemCount: t.model.baitiao.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          child: Row(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.only(left: 8.0, right: 8.0),
                                child: Consumer<ProductDetailProvide>(
                                  builder: (context, tmp, child) {
                                    return Image.asset(
                                      t.model.baitiao[index].select
                                          ? 'lib/assets/image/selected.png'
                                          : 'lib/assets/image/unselect.png',
                                      width: 20,
                                      height: 20,
                                    );
                                  },
                                ),
                              ),
                              Padding(
                                  padding:
                                      EdgeInsets.only(top: 8.0, bottom: 8.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('${t.model.baitiao[index].desc}'),
                                      Text('${t.model.baitiao[index].tip}')
                                    ],
                                  ))
                            ],
                          ),
                          onTap: () {
                            // 选择分期类型
                            t.changeBaitiaoSelected(index);
                          },
                        );
                      }),
                ),
                // 底部按钮
                Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: InkWell(
                      child: Container(
                        width: double.infinity,
                        height: 50.0,
                        color: Color(0xFFE4393C),
                        child: Center(
                            child: Text(
                          '立即打白条',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold),
                        )),
                      ),
                      onTap: () {
                        // 确定分期并返回
                        Navigator.pop(context);
                      },
                    )),
              ],
            ),
          );
        });
  }

  // 价格
  Container buildPriceContainer(ProductDetailProvide t) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(10.0),
      child: Text(
        '￥${t.model.partData.price}',
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 标题
  Container buildTitleContainer(ProductDetailProvide t) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Text(
        t.model.partData.title,
        style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      ),
    );
  }

  // 轮播图
  Container buildSwiperContainer(ProductDetailProvide t) {
    return Container(
      height: 400,
      child: Swiper(
        itemCount: t.model.partData.loopImgUrl.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset(
            'lib/assets${t.model.partData.loopImgUrl[index]}',
            width: double.infinity,
            height: 400,
            fit: BoxFit.fill,
          );
        },
      ),
    );
  }
}
