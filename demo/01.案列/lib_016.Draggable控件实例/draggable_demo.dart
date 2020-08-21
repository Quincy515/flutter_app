import 'package:flutter/material.dart';
import 'draggable_widget.dart';

class DraggableDemo extends StatefulWidget {
  @override
  _DraggableDemoState createState() => _DraggableDemoState();
}

class _DraggableDemoState extends State<DraggableDemo> {
  Color _draggableColor = Colors.grey; // 需要传递给最终接收容器中,默认灰色
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        // Stack 表示可重叠的控件
        children: <Widget>[
          DraggableWidget(
            offset: Offset(80.0, 80.0),
            widgetColor: Colors.tealAccent,
          ),
          DraggableWidget(
            offset: Offset(180.0, 80.0),
            widgetColor: Colors.redAccent,
          ),
          Center(
            child: DragTarget(
              // 拖拽接收器
              onAccept: (Color color) {
                _draggableColor = color; // 触发事件
              },
              builder: (context, candidateData, rejectedData) {
                return Container(
                  width: 200.0, // 构造器改变样式
                  height: 200.0,
                  color: _draggableColor,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
