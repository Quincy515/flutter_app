import 'package:dio/dio.dart';
import 'package:dio_log/dio_log.dart';

// 所有 Api 路由地址
class Api {
  // static const String BASE_URL = 'http://192.168.3.24:5001/api';
  static const String BASE_URL = 'https://flutter-jdapi.herokuapp.com/api';
  static const String HOME_PAGE =
      BASE_URL + '/profiles/homepage'; // 返回首页请求的json
  static const String CATEGORY_NAV =
      BASE_URL + '/profiles/navigationLeft'; // 分类页的导航
  static const String CATEGORY_CONTENT =
      BASE_URL + '/profiles/navigationRight'; // 分类页的商品类目的json数据
  static const String PRODUCTIONS_LIST =
      BASE_URL + '/profiles/productionsList'; // 返回的商品列表的json数据
  static const String PRODUCTIONS_DETAIL =
      BASE_URL + '/profiles/productionDetail'; // 返回的商品详情的json数据
}

// 封装返回的对象
class ComResponse<T> {
  int code;
  String msg;
  T data;

  ComResponse({this.code, this.msg, this.data});
}

// 封装网络请求
class Http {
  static Dio _dio;
  static Http https = Http();

  static Http getInstance() {
    return https;
  }

  Http() {
    if (_dio == null) {
      _dio = createDio();
    }
  }

  // Dio 的创建
  Dio createDio() {
    var dio = Dio(BaseOptions(
      connectTimeout: 30000,
      receiveTimeout: 30000,
      sendTimeout: 30000,
      baseUrl: Api.BASE_URL,
      responseType: ResponseType.json,
    ));
    dio.interceptors.add(DioLogInterceptor());

    return dio;
  }

  /// 通用请求
  /// xxx.xxx.com/api/test?name=custer&age=3  get
  /// xxx.xxx.com/api/test  body        post
  Future<ComResponse<T>> request<T>(String url,
      {Map<String, dynamic> queryParameters,
      dynamic data,
      String method = "get"}) async {
    try {
      Response response = method == "get"
          ? await _dio.get(url, queryParameters: queryParameters)
          : await _dio.post(url, data: data);
      if (response.statusCode == 200)
        return ComResponse(
            code: response.data['code'],
            msg: response.data['msg'],
            data: response.data['data']);
      else
        throw Exception('后端接口出现异常');
    } catch (e) {
      print('发送请求失败的消息:=======>${e}');
      String message = e.message;

      if (e.type == DioErrorType.CONNECT_TIMEOUT)
        message = "连接超时";
      else if (e.type == DioErrorType.RECEIVE_TIMEOUT)
        message = "接收超时";
      else if (e.type == DioErrorType.RESPONSE) {
        message = "404 页面走丢了 ${e.response.statusCode}";
      }

      return Future.error(message);
    }
  }
}
