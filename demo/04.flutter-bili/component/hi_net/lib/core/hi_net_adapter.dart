import 'dart:convert';

import 'package:hi_net/request/base_request.dart';

///网络请求抽象类
abstract class HiNetAdapter {
  Future<HiNetResponse<T>> send<T>(HiBaseRequest request);
}

///统一网络层返回格式
class HiNetResponse<T> {
  // 构造方法设置成非必填的
  HiNetResponse(
      {this.data,
      this.request,
      this.statusCode,
      this.statusMessage,
      this.extra});

  /// Response body. may have been transformed, please refer to [ResponseType].
  T data; // 具体的返回数据

  /// The corresponding request info.
  HiBaseRequest request; // 请求

  /// Http status code.
  int statusCode; // http 状态码

  /// Returns the reason phrase associated with the status code.
  /// The reason phrase must be set before the body is written
  /// to. Setting the reason phrase after writing to the body.
  String statusMessage; // 返回的 message

  /// Custom field that you can retrieve it later in `then`.
  dynamic extra; // 返回的额外数据

  /// We are more concerned about `data` field.
  @override
  String toString() {
    if (data is Map) {
      return json.encode(data); // map 转成 json
    }
    return data.toString(); // 返回 String
  }
}
