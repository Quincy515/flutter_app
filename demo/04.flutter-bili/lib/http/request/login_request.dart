import 'package:e_social_work/http/request/base_request.dart';
import 'package:e_social_work/http/request/index.dart';
import 'package:hi_net/request/base_request.dart';

class LoginRequest extends BaseRequest {
  @override
  String authority() {
    return Api.testAuthority;
  }

  @override
  bool useHttps() {
    return true;
  }

  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return false;
  }

  @override
  String path() {
    return Api.login;
  }
}
