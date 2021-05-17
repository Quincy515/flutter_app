import 'package:hi_net/core/dio_adapter.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:hi_net/core/hi_net_adapter.dart';
import 'package:hi_net/request/base_request.dart';

///1. 支持网络库插拔设计，且不干扰业务层
///2. 基于配置请求，简洁易用
///3. Adapter设计，扩展性强
///4. 统一异常和返回处理
class HiNet {
  HiNet._(); // 创建单例模式

  static HiNet _instance; // 设置静态方法

  static HiNet getInstance() {
    if (_instance == null) {
      // 懒汉模式，使用时才创建
      _instance = HiNet._();
    }
    return _instance; // 获取单例
  }

  Future fire(HiBaseRequest request) async {
    HiNetResponse response;
    var error;

    try {
      response = await send(request);
    } on HiNetError catch (e) {
      error = e;
      response = e.data;
      printLog(e.message);
    } catch (e) {
      // 其他异常
      error = e;
      printLog(e);
    }

    if (response == null) {
      printLog(error);
    }
    var result = response.data;
    // printLog(result);

    var status = response.statusCode;
    switch (status) {
      case 200:
        return result;
      case 401:
        throw NeedLogin();
      case 403:
        throw NeedAuth(result.toString(), data: result);
      default:
        throw HiNetError(status, result.toString(), data: result);
    }
  }

  Future<dynamic> send<T>(HiBaseRequest request) async {
    printLog('url:${request.url()}');
    // 使用 Dio 发送请求
    HiNetAdapter adapter = DioAdapter();
    return adapter.send(request);
  }

  void printLog(log) {
    print('hi_net:${log.toString()}');
  }
}
