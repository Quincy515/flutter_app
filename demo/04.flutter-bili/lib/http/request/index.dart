export 'base_request.dart';
export 'lesson_type_request.dart';
export 'registration_request.dart';

class Api {
  static const login = '/uapi/user/login';
  static const register = '/uapi/user/registration';
  static const notice = '/uapi/notice';
  static const authority = 'http://3p9448f078.wicp.vip';
  static const testAuthority = 'api.devio.org';
  static const lessonType = '/api/lessontypes/search';
}
