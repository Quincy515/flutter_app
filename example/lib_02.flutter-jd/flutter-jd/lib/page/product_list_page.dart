import 'package:flutter/material.dart';
import 'package:flutter_app/model/product_info_model.dart';
import 'package:flutter_app/page/product_detail.dart';
import 'package:flutter_app/provide/product_detail_provide.dart';
import 'package:flutter_app/provide/product_list_provide.dart';
import 'package:provider/provider.dart';

class ProductListPage extends StatelessWidget {
  final String title;

  ProductListPage({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text('${title}'),
        ),
        body: Container(
          child: Consumer<ProductListProvide>(builder: (context, t, child) {
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
                        t.loadProductList(); // 重新加载
                      },
                    )
                  ],
                ),
              );
            }
            // 返回数据展示
            return ListView.builder(
                itemCount: t.list.length,
                itemBuilder: (context, index) {
                  ProductInfoModel model = t.list[index];
                  // print('model======>${model.toJson()}');
                  // 展示数据
                  return InkWell(
                    child: buildProductItem(model),
                    onTap: () {
                      // 前往商品详情页面
                      print(' 前往商品详情页面${model.title}');
                      // 前往商品页面
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ChangeNotifierProvider<ProductDetailProvide>(
                            create: (context) {
                              ProductDetailProvide provide =
                                  ProductDetailProvide();
                              provide.loadProduct(id: model.id);
                              return provide;
                            },
                            child: Consumer<ProductDetailProvide>(
                              builder: (context, t, child) {
                                return Container(
                                  child: ProductDetailPage(id: model.id),
                                );
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  );
                });
          }),
        ),
      ),
    );
  }

  // 展示数据
  Row buildProductItem(ProductInfoModel model) {
    return Row(
      children: <Widget>[
        Image.asset(
          'lib/assets${model.cover}',
          width: 95,
          height: 120,
        ),
        Expanded(
            child: Padding(
          padding: EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                model.title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                height: 5.0,
              ),
              Text(
                '￥${model.price}',
                style: TextStyle(fontSize: 16.0),
              ),
              SizedBox(
                height: 5.0,
              ),
              Row(
                children: <Widget>[
                  Text(
                    '${model.comment}条评价',
                    style: TextStyle(fontSize: 13.0),
                  ),
                  SizedBox(
                    width: 5.0,
                  ),
                  Text(
                    '好评率${model.rate}',
                    style: TextStyle(fontSize: 13.0),
                  ),
                ],
              ),
              SizedBox(
                height: 10.0,
              ),
            ],
          ),
        ))
      ],
    );
  }
}
