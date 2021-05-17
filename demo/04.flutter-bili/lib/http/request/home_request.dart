import 'package:e_social_work/http/index.dart';
import 'package:hi_net/request/base_request.dart';

class HomeRequest extends BaseRequest {
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
    return HttpMethod.GET;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return 'uapi/fa/home';
  }
}
