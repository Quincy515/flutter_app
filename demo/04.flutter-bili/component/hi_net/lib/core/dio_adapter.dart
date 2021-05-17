import 'package:dio/dio.dart';
import 'package:hi_net/core/hi_error.dart';
import 'package:hi_net/core/hi_net_adapter.dart';
import 'package:hi_net/request/base_request.dart';

///Dio 适配器
class DioAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(HiBaseRequest request) async {
    var response, options = Options(headers: request.header);
    var err;
    try {
      if (request.httpMethod() == HttpMethod.GET) {
        response = await Dio().get(request.url(), options: options);
      } else if (request.httpMethod() == HttpMethod.POST) {
        response = await Dio()
            .post(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.PUT) {
        response = await Dio()
            .put(request.url(), data: request.params, options: options);
      } else if (request.httpMethod() == HttpMethod.DELETE) {
        response = await Dio()
            .delete(request.url(), data: request.params, options: options);
      }
    } on DioError catch (e) {
      err = e.error;
      response = e.message;
    }
    if (err != null) {
      throw HiNetError(response?.statusCode ?? -1, err.toString(),
          data: buildRes(response, request)); // 抛出 HiNetError
    }
    return buildRes(response, request); // 没有错误就返回正常的信息
  }

  /// 构建 HiNetResponse
  HiNetResponse buildRes(Response response, HiBaseRequest request) {
    return HiNetResponse(
        data: response.data,
        request: request,
        statusCode: response.statusCode,
        statusMessage: response.statusMessage,
        extra: response);
  }
}
