import 'package:e_social_work/http/request/base_request.dart';
import 'package:e_social_work/http/request/index.dart';
import 'package:e_social_work/http/request/login_request.dart';
import 'package:hi_cache/hi_cache.dart';
import 'package:hi_net/hi_net.dart';

/// 数据访问对象
/// 用于和服务端进行的通信，以及数据持久化
class LoginDao {
  static const BOARDING_PASS = "boarding-pass"; // 登录令牌

  static login(String userName, String password) {
    return _send(userName, password);
  }

  static registration(
      String userName, String password, String imoocId, String orderId) {
    return _send(userName, password, imoocId: imoocId, orderId: orderId);
  }

  // 抽象出通用的登录注册请求
  static _send(String userName, String password, {imoocId, orderId}) async {
    BaseRequest request;
    if (imoocId != null && orderId != null) {
      request = RegistrationRequest(); // 用于注册
    } else {
      request = LoginRequest(); // 用于登录
    }
    request
        .add("userName", userName)
        .add("password", password)
        .add("imoocId", imoocId)
        .add("orderId", orderId);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    if (result['code'] == 0 && result['data'] != null) {
      // 登录成功保存登录令牌
      HiCache.getInstance().setString(BOARDING_PASS, result['data']);
    }
    return result;
  }

  // 获取登录令牌
  static getBoardingPass() {
    return HiCache.getInstance().get(BOARDING_PASS);
  }
}
