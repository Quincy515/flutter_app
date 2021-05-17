import 'package:e_social_work/http/request/index.dart';
import 'package:hi_net/request/base_request.dart';

class LessonTypeRequest extends BaseRequest {
  @override
  bool useHttps() {
    return false;
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
    return Api.lessonType;
  }
}
