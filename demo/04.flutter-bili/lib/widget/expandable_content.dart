import 'package:e_social_work/model/video_model.dart';
import 'package:flutter/material.dart';
import 'package:hi_base/view_util.dart';

// 可展开的 widget
class ExpandableContent extends StatefulWidget {
  final VideoModel mo;
  const ExpandableContent({Key key, @required this.mo}) : super(key: key);

  @override
  _ExpandableContentState createState() => _ExpandableContentState();
}

class _ExpandableContentState extends State<ExpandableContent>
    with SingleTickerProviderStateMixin {
  static final Animatable<double> _easeInTween =
      CurveTween(curve: Curves.easeIn); // 曲线动画，速度先慢后快
  bool _expand = false; // 展开状态，默认不展开
  AnimationController _controller; // 动画的控制器,用来管理 Animation
  Animation<double> _heightFactor; // 动画高度

  @override
  void initState() {
    super.initState();
    _controller = // 初始化动画控制器，执行时间 200 毫秒
        AnimationController(duration: Duration(microseconds: 200), vsync: this);
    _heightFactor = _controller.drive(_easeInTween); // 高度动画，通过控制器使用曲线动画
    _controller.addListener(() {
      // 监听动画值的变化
      print(_heightFactor.value);
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, top: 5),
      child: Column(
        children: [
          _buildTitle(),
          Padding(padding: EdgeInsets.only(bottom: 8)),
          _buildInfo(),
          _buildDes(),
        ],
      ),
    );
  }

  _buildTitle() {
    return InkWell(
      onTap: _toggleExpand, // 方法回调
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 通过 Expanded 让 Text 获得最大宽度，以便显示省略号
          Expanded(
              child: Text(
            widget.mo.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          )),
          Padding(padding: EdgeInsets.only(left: 15)),
          Icon(
            _expand
                ? Icons.keyboard_arrow_up_sharp
                : Icons.keyboard_arrow_down_sharp,
            color: Colors.grey,
            size: 16,
          ),
        ],
      ),
    );
  }

  // 展开事件
  void _toggleExpand() {
    setState(() {
      _expand = !_expand; // 取反
      if (_expand) {
        _controller.forward(); // 执行动画
      } else {
        _controller.reverse(); // 反向执行动画
      }
    });
  }

  // 描述信息 浏览量，评论数，日期
  _buildInfo() {
    var style = TextStyle(fontSize: 12, color: Colors.grey);
    var dateStr = widget.mo.createTime.length > 10
        ? widget.mo.createTime.substring(5, 10)
        : widget.mo.createTime;
    return Row(
      children: [
        ...smallIconText(Icons.ondemand_video, widget.mo.view),
        Padding(padding: EdgeInsets.only(left: 10)),
        ...smallIconText(Icons.list_alt, widget.mo.reply),
        Text('     $dateStr', style: style),
      ],
    );
  }

  // 展开的具体描述
  _buildDes() {
    // 展开状态下，就显示具体描述，不展开状态就不显示任何内容
    var child = _expand
        ? Text(widget.mo.desc,
            style: TextStyle(fontSize: 12, color: Colors.grey))
        : null;
    // 构建动画的通用 widget
    return AnimatedBuilder(
        animation: _controller,
        child: child,
        builder: (BuildContext context, Widget child) {
          return Align(
            heightFactor: _heightFactor.value,
            alignment: Alignment.topCenter, // fix 从布局之上的位置开始展开
            child: Container(
              alignment: Alignment.topLeft, // 会撑满宽度后，让内容对齐
              padding: EdgeInsets.only(top: 8),
              child: child,
            ),
          );
        });
  }
}
