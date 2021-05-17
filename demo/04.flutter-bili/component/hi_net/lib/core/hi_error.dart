///派生子类-需要登录的异常
class NeedLogin extends HiNetError {
  NeedLogin({int code: 401, String message: '请先登录'}) : super(code, message);
}

///派生子类-需要授权的异常
class NeedAuth extends HiNetError {
  NeedAuth(String message, {int code: 403, dynamic data})
      : super(code, message, data: data);
}

///网络异常统一格式类
class HiNetError implements Exception {
  final int code; // 异常码 必填
  final String message; // 异常信息 必填
  final dynamic data; // 异常数据 可选

  HiNetError(this.code, this.message, {this.data});
}
