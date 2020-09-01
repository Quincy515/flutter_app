import 'package:flutter/material.dart';
import 'package:flutter_app/model/category_content_model.dart';
import 'package:flutter_app/page/product_list_page.dart';
import 'package:flutter_app/provide/category_provide.dart';
import 'package:flutter_app/provide/product_list_provide.dart';
import 'package:flutter_app/provide/theme_provide.dart';
import 'package:provider/provider.dart';

class CategoryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CategoryPageProvide>(
      create: (context) {
        var provider = new CategoryPageProvide();
        provider.loadCategoryPageData();
        return provider;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('分类'),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 15),
                child: InkWell(
                  onTap: () {
                    Provider.of<ThemeProvide>(context, listen: false).change();
                  },
                  child: Icon(Icons.brightness_4),
                )),
          ],
        ),
        body: Container(
          child: Consumer<CategoryPageProvide>(
            builder: (context, t, child) {
              if (t.isLoading && t.categoryNavList.length == 0) {
                return Center(
                  child: CircularProgressIndicator(), // 加载动画
                );
              }
              if (t.isError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center, // 捕获异常
                    children: <Widget>[
                      Text(t.errorMsg),
                      OutlineButton(
                        child: Text('刷新'),
                        onPressed: () {
                          t.loadCategoryPageData();
                        },
                      ),
                    ],
                  ),
                );
              }
              return Row(
                children: <Widget>[
                  buildNavLeftContainer(t), // 分类左侧
                  Expanded(
                    child: Stack(
                      children: <Widget>[
                        buildCategoryContainer(t.categoryContentList, context),
                        // 分类右侧
                        t.isLoading
                            ? Center(
                                child: CircularProgressIndicator(), // 加载动画
                              )
                            : Container()
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  // 分类左侧
  Container buildNavLeftContainer(CategoryPageProvide t) {
    return Container(
      width: 90,
      child: ListView.builder(
          itemCount: t.categoryNavList.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () {
                t.loadCategoryContentData(index);
              },
              child: Container(
                height: 50,
                padding: EdgeInsets.only(top: 15),
                color: t.tabIndex == index ? Colors.white : Color(0xFFF8F8F8),
                child: Text(
                  t.categoryNavList[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: t.tabIndex == index
                          ? Color(0xFF393b2d)
                          : Color(0xFF333333),
                      fontWeight: FontWeight.w500),
                ),
              ),
            );
          }),
    );
  }

  // 分类右侧
  Widget buildCategoryContainer(
      List<CategoryContentModel> contentList, BuildContext context) {
    List<Widget> list = List<Widget>();

    // 处理数据 title
    for (var i = 0; i < contentList.length; i++) {
      list.add(Container(
        height: 30.0,
        margin: EdgeInsets.only(top: 10.0, left: 10.0),
        child: Text('${contentList[i].title}',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
      ));

      // 商品数据容器
      List<Widget> descList = List<Widget>();

      for (var j = 0; j < contentList[i].desc.length; j++) {
        descList.add(InkWell(
          onTap: () {
            // 前往商品页面
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) =>
                    ChangeNotifierProvider<ProductListProvide>(
                  create: (context) {
                    ProductListProvide provide = ProductListProvide();
                    provide.loadProductList();
                    return provide;
                  },
                  child: Consumer<ProductListProvide>(
                    builder: (context, t, child) {
                      return Container(
                        child:
                            ProductListPage(title: contentList[i].desc[j].text),
                      );
                    },
                  ),
                ),
              ),
            );
          },
          child: Container(
            width: 60.0,
            color: Colors.white,
            child: Column(
              children: <Widget>[
                Image.asset('lib/assets${contentList[i].desc[j].img}',
                    width: 50, height: 50),
                Text('${contentList[i].desc[j].text}')
              ],
            ),
          ),
        ));
      }

      // 将 descList 追加到 list 中
      list.add(
        Padding(
          padding: EdgeInsets.all(8.0),
          child: Wrap(
            spacing: 7.0,
            runSpacing: 10.0,
            alignment: WrapAlignment.start,
            children: descList,
          ),
        ),
      );
    }

    return Container(
      width: double.infinity,
      child: ListView(
        children: list,
      ),
    );
  }
}
