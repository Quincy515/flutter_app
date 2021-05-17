import 'package:e_social_work/model/home_mo.dart';
import 'package:e_social_work/widget/index.dart';
import 'package:flutter/material.dart';

class CourseTabPage extends StatefulWidget {
  final String name;
  final List<BannerMo> bannerList;
  const CourseTabPage({Key key, this.name, this.bannerList}) : super(key: key);

  @override
  _CourseTabPageState createState() => _CourseTabPageState();
}

class _CourseTabPageState extends State<CourseTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        // children: [if (widget.bannerList != null) _banner()],
        children: [if (widget.name != null) _banner()],
      ),
    );
  }

  _banner() {
    return Padding(
      padding: EdgeInsets.only(left: 8, right: 8),
      child: HiBanner(
        widget.bannerList,
        viewportFraction: 0.8,
        scale: 0.9,
      ),
    );
  }
}
