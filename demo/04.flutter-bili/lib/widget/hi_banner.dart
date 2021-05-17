import 'package:e_social_work/model/home_mo.dart';
import 'package:e_social_work/model/video_model.dart';
import 'package:e_social_work/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:hi_base/color.dart';

class HiBanner extends StatelessWidget {
  final List<BannerMo> bannerList; // banner 列表
  final double bannerHeight; // banner 高度
  final EdgeInsetsGeometry padding;
  final double viewportFraction; // 缩放比例
  final double scale;

  const HiBanner(this.bannerList,
      {Key key,
      this.bannerHeight = 160,
      this.padding,
      this.viewportFraction = 1,
      this.scale = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: bannerHeight,
      child: _banner(),
    );
  }

  _banner() {
    var right =
        50 + (padding?.horizontal ?? 0) / 2; // 设置右边距,padding 不为空取水平的大小除以2
    if (bannerList == null) {
      return Swiper(
        itemCount: 3,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          // if (bannerList != null) {
          //   return _image(bannerMo: bannerList[index]);
          // }
          return _image();
        },
        // 自定义指示器
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              activeColor: primary,
              color: Colors.white60,
              size: 6,
              activeSize: 6),
        ),
        viewportFraction: viewportFraction,
        scale: scale,
      );
    } else {
      return Swiper(
        itemCount: bannerList.length,
        autoplay: true,
        itemBuilder: (BuildContext context, int index) {
          return _image(bannerMo: bannerList[index]);
        },
        // 自定义指示器
        pagination: SwiperPagination(
          alignment: Alignment.bottomRight,
          margin: EdgeInsets.only(right: right, bottom: 10),
          builder: DotSwiperPaginationBuilder(
              activeColor: primary,
              color: Colors.white60,
              size: 6,
              activeSize: 6),
        ),
        viewportFraction: viewportFraction,
        scale: scale,
      );
    }
  }

  _image({BannerMo bannerMo}) {
    return InkWell(
      onTap: () {
        print('点击了banner${bannerMo.toJson().toString()}');
        // _handlerClick(bannerMo);
      },
      child: Container(
        padding: padding,
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(6)),
          child: Image.network(
              bannerMo?.cover ?? 'http://via.placeholder.com/350x150',
              fit: BoxFit.cover),
        ),
      ),
    );
  }

  // 点击跳转
  void _handlerClick(BannerMo bannerMo) {
    // TODO: 跳转到链接的文章或课程页面
    if (bannerMo.type == 'video') {
      HiNavigator.getInstance().onJumpTo(RouteStatus.videoDetail,
          args: {'videoMo': VideoModel(vid: bannerMo.url)});
    } else {
      print(bannerMo.url);
      // TODO: 跳转到文章详情
    }
  }
}
