import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController typeController = TextEditingController();
  String showText = '欢迎来到学海无涯';

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Scaffold(
      appBar: AppBar(
        title: Text('学海无涯'),
      ),
      body: SingleChildScrollView( // 滚动组件避免像素超出容器
          child: Container(
        child: Column(children: <Widget>[
          TextField(
            controller: typeController,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.all(10.0),
              labelText: '技术类型',
              helperText: '请输入你喜欢的技术',
            ),
            autofocus: false, // 自动对焦关闭，避免自动打开手机输入
          ),
          RaisedButton(
            onPressed: _choiceAction,
            child: Text('选择完毕'),
          ),
          Text(
            showText,
            overflow: TextOverflow.ellipsis, // 省略号
            maxLines: 1, // 1行
          )
        ]),
      )),
    ));
  }

  void _choiceAction() {
    print('开始选择你喜欢的技术。。。。');
    if (typeController.text.toString() == '') {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('类型不能为空'),
              ));
    } else {
      getHttp(typeController.text.toString()).then((value) => setState(() {
//            showText = value['data']['name'];
            showText = value.toString();
          }));
    }
  }

  Future getHttp(String TypeText) async {
    try {
      Response response;
      var data = {'name': TypeText};
      response = await Dio()
          .get('http://192.168.3.24:2020/ping', queryParameters: data);
      print(response);
      return response;
    } catch (e) {
      return print(e);
    }
  }
}
