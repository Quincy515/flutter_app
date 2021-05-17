import 'package:e_social_work/model/video_model.dart';
import 'package:e_social_work/navigator/hi_navigator.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/format_util.dart';
import 'package:hi_base/view_util.dart';

class VideoCard extends StatelessWidget {
  final VideoModel videoMo;
  const VideoCard({Key key, this.videoMo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        print(videoMo.url);
        HiNavigator.getInstance()
            .onJumpTo(RouteStatus.videoDetail, args: {"videoMo": videoMo});
      },
      child: SizedBox(
        height: 200,
        child: Card(
          // 取消卡片默认边距
          margin: EdgeInsets.only(left: 4, right: 4, bottom: 8),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _itemImage(context),
                _infoText(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _itemImage(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Stack(
      children: [
        // FadeInImage.memoryNetwork(// 图片渐入
        //   height: 120,
        //   width: size.width / 2 - 20, // 每行2个，减去间距
        //   placeholder: kTransparentImage,
        //   image: videoMo.cover,
        //   fit: BoxFit.cover,
        // ),
        cachedImage(videoMo.cover, width: size.width / 2 - 10, height: 120),
        // 图片下方的文字绝对定位
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.only(left: 0, right: 8, bottom: 3, top: 5),
            decoration: BoxDecoration(
              // 设置渐变,从底部往上逐渐变透明
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [Colors.black54, Colors.transparent],
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _iconText(Icons.ondemand_video, videoMo.view),
                _iconText(Icons.favorite_border, videoMo.favorite),
                _iconText(null, videoMo.duration),
              ],
            ),
          ),
        ),
      ],
    );
  }

  _iconText(IconData iconData, int count) {
    String views = "";
    if (iconData != null) {
      views = countFormat(count);
    } else {
      views = durationTransform(videoMo.duration);
    }
    return Row(
      children: [
        if (iconData != null) Icon(iconData, color: Colors.white, size: 12),
        Padding(
          padding: EdgeInsets.only(left: 3),
          child: Text(
            views,
            style: TextStyle(color: Colors.white, fontSize: 10),
          ),
        ),
      ],
    );
  }

  _infoText(BuildContext context) {
    return Expanded(
        child: Container(
      padding: EdgeInsets.only(top: 5, left: 8, right: 8, bottom: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            videoMo.title,
            maxLines: 2, // 最大两行
            overflow: TextOverflow.ellipsis, // 超出2行显示省略号
            style: TextStyle(fontSize: 12, color: Colors.black87),
          ),
          _owner(),
        ],
      ),
    ));
  }

  _owner() {
    var owner = videoMo.owner;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              // child: Image.network(owner.face, width: 24, height: 24),
              child: cachedImage(owner.face, width: 24, height: 24),
            ),
            Padding(
              padding: EdgeInsets.only(left: 8),
              child: Text(
                owner.name,
                style: TextStyle(fontSize: 11, color: Colors.black87),
              ),
            )
          ],
        ),
        Icon(
          Icons.more_vert_sharp,
          size: 15,
          color: Colors.grey,
        ),
      ],
    );
  }
}
