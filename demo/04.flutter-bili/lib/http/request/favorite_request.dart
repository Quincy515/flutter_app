import 'package:e_social_work/http/index.dart';
import 'package:hi_net/request/base_request.dart';

class FavoriteRequest extends BaseRequest {
  @override
  bool useHttps() {
    return true;
  }

  @override
  String authority() {
    return Api.testAuthority;
  }

  @override
  HttpMethod httpMethod() {
    return HttpMethod.POST;
  }

  @override
  bool needLogin() {
    return true;
  }

  @override
  String path() {
    return 'uapi/fa/favorite';
  }
}

class CancelFavoriteRequest extends FavoriteRequest {
  @override
  HttpMethod httpMethod() {
    return HttpMethod.DELETE;
  }
}
