import 'package:hi_net/request/base_request.dart';

///基础请求的派生类
class TestRequest extends HiBaseRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return 'uapi/test/test';
  }
}
