import 'package:flutter/material.dart';
import 'package:hi_base/view_util.dart';

// 可动态改变位置的 Header 组件
// 性能优化：局部刷新的应用
class HiFlexibleHeader extends StatefulWidget {
  final String name; // 用户名称
  final String face; // 用户头像
  final ScrollController controller; // 列表滚动的控制器
  const HiFlexibleHeader(
      {Key key,
      @required this.name,
      @required this.face,
      @required this.controller})
      : super(key: key);

  @override
  _HiFlexibleHeaderState createState() => _HiFlexibleHeaderState();
}

class _HiFlexibleHeaderState extends State<HiFlexibleHeader> {
  static const double MAX_BOTTOM = 30; // 滚动前距离底部的最大距离
  static const double MIN_BOTTOM = 10; // 滚动结束时距离底部的最小距离

  static const MAX_OFFSET = 80; // 滚动范围
  double _dyBottom = MAX_BOTTOM; // 滚动时距离底部的动态距离

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      // 列表滚动时获取实时的列表位移，根据位移算出 _dyBottom
      var offset = widget.controller.offset;
      print('offset:$offset');
      // 算出 padding 变化 0 - 1
      var dyOffset = (MAX_OFFSET - offset) / MAX_OFFSET;
      // 根据 dyOffset 算出具体的变化的 padding 值
      var dy = dyOffset * (MAX_BOTTOM - MIN_BOTTOM);
      // 临界值保护
      if (dy > (MAX_BOTTOM - MIN_BOTTOM)) {
        dy = MAX_BOTTOM - MIN_BOTTOM;
      } else if (dy < 0) {
        dy = 0;
      }
      setState(() {
        _dyBottom = MIN_BOTTOM + dy; // 算出实时的 padding
      });
      print('_dyBottom:$_dyBottom');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      padding: EdgeInsets.only(bottom: _dyBottom, left: 15),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(23),
            child: cachedImage(widget.face, width: 46, height: 46),
          ),
          hiSpace(width: 8),
          Text(
            widget.name,
            style: TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
