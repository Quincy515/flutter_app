import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';
import 'package:lottie/lottie.dart';

void main() async {
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: '看漫画',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
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
  bool isLoading = false;

  var imgList = <Uint8List>[];
  void _incrementCounter() {
    setState(() {
      page += 5;
    });
  }

  @override
  void initState() {
    super.initState();
    saveListWithGetStorage(
        'history', ['https://nizhidaoma.bqulou.com/bookimages/17107/79771']);
  }

  final box = GetStorage();

  /// write a storage key's value
  saveListWithGetStorage(String storageKey, List<String> storageValue) async =>
      await box.write(storageKey, jsonEncode(storageValue));

  /// read from storage
  List<String> readWithGetStorage(String storageKey) {
    var readString = box.read(storageKey);
    var temp = readString == null ? [] : json.decode(readString.toString());
    List<String> tempList = (temp as List).cast(); // 强制转成 List
    return tempList;
  }

  ScrollController scrollController = ScrollController();

  void _scrollTo({String where = 'top'}) {
    if (where == 'top') {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    } else {
      scrollController.jumpTo(scrollController.position.maxScrollExtent);
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> imgListWidget = imgList.map((e) => Image.memory(e)).toList();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      floatingActionButton: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => _scrollTo(where: 'top'),
              tooltip: '回到顶部',
              icon: const Icon(Icons.rocket),
            ),
            IconButton(
              onPressed: () => _scrollTo(where: 'down'),
              tooltip: '回到底部',
              icon: const Icon(Icons.arrow_downward),
            ),
          ]),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 16.0, right: 16, top: 8.0, bottom: 8),
                child: TextField(
                  //设置默认值，光标在文字最后
                  controller: TextEditingController.fromValue(TextEditingValue(
                      text: url,
                      selection: TextSelection.fromPosition(TextPosition(
                          affinity: TextAffinity.downstream,
                          offset: url.length)))),
                  maxLines: 2,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: BorderSide.none),
                    hintText: '请输入网址',
                    contentPadding: EdgeInsets.zero,
                    isCollapsed: false,
                    hintStyle:
                        const TextStyle(fontSize: 13, color: Colors.grey),
                  ),
                  onChanged: (String value) {
                    setState(() {
                      url = value;
                    });
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      List<String> history = readWithGetStorage('history');
                      if (!history.contains(url)) {
                        history.add(url);
                        if (history.length >= 5) {
                          history.removeAt(0);
                        }
                        saveListWithGetStorage('history', history);
                      }
                      dioGetMul();
                    },
                    icon: const Icon(Icons.book_outlined),
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (ctx) => _buildSimpleDialog(ctx));
                    },
                    icon: const Icon(Icons.history),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        url = '';
                        page = 1;
                        show = false;
                        imgList = <Uint8List>[];
                        isLoading = false;
                      });
                    },
                    icon: const Icon(Icons.refresh),
                  ),
                ],
              ),
              show
                  ? Column(
                      children: [...imgListWidget],
                    )
                  : Container(),
              isLoading ? isLoadingWidget() : const SizedBox(height: 20),
              IconButton(
                onPressed: () {
                  _incrementCounter();
                  dioGetMul();
                },
                icon: const Icon(Icons.arrow_forward_ios_outlined),
              ),
            ],
          ),
        ),
      ),
    );
  }

  SimpleDialog _buildSimpleDialog(BuildContext context) {
    List<String> history = readWithGetStorage('history');
    return SimpleDialog(
        title: const Text('历史记录'),
        children: history
            .map(
              (e) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        url = e;
                        page = 1;
                      });

                      Navigator.pop(context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16.0),
                      child: Text(e, style: const TextStyle(fontSize: 16)),
                    ),
                  ),
                  const Divider(
                    indent: 20,
                    height: 12,
                  ),
                ],
              ),
            )
            .toList());
  }

  void dioGetMul() async {
    setState(() {
      isLoading = true;
    });
    await dioGet(page);
    await dioGet(page + 1);
    await dioGet(page + 2);
    await dioGet(page + 3);
    await dioGet(page + 4);
    setState(() {
      isLoading = false;
    });
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

  Widget isLoadingWidget() {
    return Center(
      child: Lottie.asset(
        'assets/lottie_animations/loading.json',
        width: 50,
        height: 50,
        fit: BoxFit.fill,
      ),
    );
  }
}
