import 'package:flutter/material.dart';

class DraggableWidget extends StatefulWidget {
  // 结束参数 声明变量 重洗构造方法
  final Offset offset; // 位置
  final Color widgetColor; // 颜色
  const DraggableWidget({Key key, this.offset, this.widgetColor})
      : super(key: key); // 无名无参需要调用父类方法
  // 这样就可以传递参数并接收

  @override
  _DraggableWidgetState createState() => _DraggableWidgetState();
}

class _DraggableWidgetState extends State<DraggableWidget> {
  Offset offset = Offset(0.0, 0.0); // 左上角
  @override
  void initState() {
    super.initState();
    offset = widget.offset; // 取组件传递过来的位置
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      // 位置控件
      left: offset.dx,
      top: offset.dy,
      child: Draggable(
        // 可拖拽的组件
        data: widget.widgetColor, // 传递给接收器的数据
        child: Container(
          // 子组件容器
          width: 100.0,
          height: 100.0,
          color: widget.widgetColor,
        ),
        feedback: Container(
          // 当拖动控件，子元素的样子,
          width: 110.0, // 拿起的效果放大一点点
          height: 110.0,
          color: widget.widgetColor.withOpacity(0.5), // 拖动的效果变成半透明
        ),
        onDraggableCanceled: (Velocity velocity, Offset offset) {
          // 当拖拽松手时的效果,
          setState(() {
            this.offset = offset; // 改变位置
          });
        },
      ),
    );
  }
}
