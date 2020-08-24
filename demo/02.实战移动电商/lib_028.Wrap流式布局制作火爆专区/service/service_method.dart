import 'dart:async';

import 'package:dio/dio.dart';

import '../config/service_url.dart';

// 通用获取数据, formData 修改为可选参数，加个大括号
Future request(url, {formData}) async {
  try {
    print('开始获取数据...');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
//        ContentType.parse("application/x-www-form-urlencode"); // 设置请求头类型
    if (formData == null) {
      response = await dio.post(servicePath[url]); // 调用不带参数
    } else {
      response = await dio.post(servicePath[url], data: formData);
    }
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:===>${e}');
  }
}

// 获取首页主题内容
Future getHomePageContent() async {
  try {
    print('开始获取首页数据...');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
//        ContentType.parse("application/x-www-form-urlencode"); // 设置请求头类型
    var formData = {'lon': '115.02932', 'lat': '35.76189'};
    response = await dio.post(servicePath['homePageContent'], data: formData);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:===>${e}');
  }
}

// 获取火爆专区商品内容
Future getHomePageBelowContent() async {
  try {
    print('开始获取火爆专区数据...');
    Response response;
    Dio dio = new Dio();
    dio.options.contentType = Headers.formUrlEncodedContentType;
    int page = 1;
    response = await dio.post(servicePath['homePageBelowContent'], data: page);
    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('后端接口出现异常');
    }
  } catch (e) {
    return print('ERROR:===>${e}');
  }
}
