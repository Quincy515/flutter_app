import 'package:e_social_work/http/request/profile_request.dart';
import 'package:e_social_work/model/profile_mo.dart';
import 'package:hi_net/hi_net.dart';

class ProfileDao {
  // https://api.devio.org/uapi/fa/profile
  static get() async {
    ProfileRequest request = ProfileRequest();
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return ProfileMo.fromJson(result['data']);
  }
}
