import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var url = '';
  var page = 1;
  var show = false;

  var imgList = <Uint8List>[];
  void _incrementCounter() {
    setState(() {
      page += 5;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imgListWidget = imgList.map((e) => Image.memory(e)).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextField(
              decoration: const InputDecoration(
                hintText: '请输入网址',
              ),
              onChanged: (String value) {
                setState(() {
                  url = value;
                });
              },
            ),
            TextField(
              decoration: const InputDecoration(
                hintText: '请输入页码',
              ),
              onChanged: (String value) {
                setState(() {
                  page = value.isEmpty ? 1 : int.parse(value.toString());
                });
              },
            ),
            ElevatedButton(
              onPressed: () {
                dioGetMul();
              },
              child: const Text('开始'),
            ),
            show
                ? Column(
                    children: [...imgListWidget],
                  )
                : Container(),
            ElevatedButton(
              onPressed: () {
                _incrementCounter();
                dioGetMul();
              },
              child: const Text('下一页'),
            ),
          ],
        ),
      ),
    );
  }

  void dioGetMul() async {
    await Future.wait([
      dioGet(page),
      dioGet(page + 1),
      dioGet(page + 2),
      dioGet(page + 3),
      dioGet(page + 4)
    ]);
  }

  Future dioGet(int num) async {
    // https://github.com/flutterchina/dio#examples
    Response<List<int>> res = await Dio().post(
      'http://111.229.226.15:9527/img',
      data: {
        'url': url,
        'page': num.toString(),
      },
      options: Options(responseType: ResponseType.bytes),
    );
    if (res.statusCode == 200) {
      final Uint8List bytes = consolidateHttpClientResponseBytes(res.data);
      setState(() {
        imgList.add(bytes);
        show = true;
      });
    }
  }

  static consolidateHttpClientResponseBytes(data) {
    // https://my.oschina.net/u/2354207/blog/5005221response.contentLength
    final List<List<int>> chunks = <List<int>>[];
    int contentLength = 0;
    chunks.add(data);
    contentLength += data.length as int;
    final Uint8List bytes = Uint8List(contentLength);
    int offset = 0;
    for (List<int> chunk in chunks) {
      bytes.setRange(offset, offset + chunk.length, chunk);
      offset += chunk.length;
    }
    return bytes;
  }
}
