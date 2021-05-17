import 'package:e_social_work/http/request/base_request.dart';
import 'package:hi_net/request/base_request.dart';

///基础请求的派生类
class TestRequest extends BaseRequest {
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
