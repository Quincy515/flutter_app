import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/model/home_model.dart';
import 'package:flutter_app/provide/home_provide.dart';
import 'package:flutter_app/provide/theme_provide.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Http().request(Api.HOME_PAGE).then((value) => print(value.data));
    return ChangeNotifierProvider<HomePageProvide>(
      create: (context) {
        var provider = new HomePageProvide();
        provider.loadHomePageData();
        return provider;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text('首页'),
            actions: <Widget>[
              Padding(
                  padding: EdgeInsets.only(right: 15),
                  child: InkWell(
                    onTap: () {
                      Provider.of<ThemeProvide>(context, listen: false)
                          .change();
                    },
                    child: Icon(Icons.brightness_4),
                  )),
            ],
          ),
          body: Container(
            child: Consumer<HomePageProvide>(
              builder: (context, t, child) {
                print(t.isLoading);
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
                            t.loadHomePageData(); // 重新加载
                          },
                        )
                      ],
                    ),
                  );
                }
                return ListView(
                  children: <Widget>[
                    buildAspectRatio(t.model), // 轮播图
                    buildLogos(t.model), // 图标分类
                    buildMSHeaderContainer(), // 掌上秒杀头部
                    buildMSBodyContainer(t.model), // 掌上秒杀商品
                    buildAds(t.model.pageRow.ad1), // 广告1
                    buildAds(t.model.pageRow.ad2), // 广告2
                  ],
                );
              },
            ),
          )),
    );
  }

  // 轮播图
  AspectRatio buildAspectRatio(HomePageModel model) {
    return AspectRatio(
      aspectRatio: 72 / 35,
      child: Swiper(
        itemCount: model.swipers.length,
        pagination: SwiperPagination(),
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return Image.asset('lib/assets${model.swipers[index].image}');
        },
      ),
    );
  }

  // 图标分类
  Widget buildLogos(HomePageModel model) {
    // 定义 list 数组，列表容器
    List<Widget> list = List<Widget>();
    // 遍历 model 中的 logos 数组
    for (var i = 0; i < model.logos.length; i++) {
      list.add(Container(
        width: 60.0,
        child: Column(
          children: <Widget>[
            Image.asset(
              "lib/assets${model.logos[i].image}",
              width: 50,
              height: 50,
            ),
            Text("${model.logos[i].title}"),
          ],
        ),
      ));
    }

    return Container(
      color: Colors.white,
      height: 170,
      padding: const EdgeInsets.all(10.0),
      child: Wrap(
        spacing: 7.0, // 间隙
        runSpacing: 10.0, // 上下间隙
        alignment: WrapAlignment.spaceBetween, // 等比例间隙
        children: list,
      ),
    );
  }

  // 掌上秒杀头部
  Container buildMSHeaderContainer() {
    return Container(
      margin: EdgeInsets.only(top: 10.0),
      padding: EdgeInsets.all(10.0),
      color: Colors.white,
      height: 50,
      child: Row(
        children: <Widget>[
          Image.asset(
            'lib/assets/image/bej.png',
            width: 90,
            height: 20,
          ),
          Spacer(), // 填充
          Text('更多秒杀'),
          Icon(
            CupertinoIcons.right_chevron,
            size: 14,
          ),
        ],
      ),
    );
  }

  // 掌上秒杀商品
  Container buildMSBodyContainer(HomePageModel model) {
    return Container(
      height: 120,
      color: Colors.white,
      child: ListView.builder(
          itemCount: model.quicks.length,
          scrollDirection: Axis.horizontal, // 横向
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: Column(
                children: <Widget>[
                  Image.asset(
                    'lib/assets${model.quicks[index].image}',
                    width: 85,
                    height: 85,
                  ),
                  Text('${model.quicks[index].price}',
                      style: TextStyle(color: Colors.red, fontSize: 12))
                ],
              ),
            );
          }),
    );
  }

  // 广告
  Widget buildAds(List<String> ads) {
    List<Widget> list = List<Widget>();

    for (var i = 0; i < ads.length; i++) {
      list.add(Expanded(child: Image.asset('lib/assets${ads[i]}')));
    }

    return Row(children: list);
  }
}
