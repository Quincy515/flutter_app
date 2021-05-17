import 'package:e_social_work/http/index.dart';
import 'package:e_social_work/http/request/favorite_request.dart';
import 'package:hi_net/hi_net.dart';

// 收藏视频和取消收藏视频
class FavoriteDao {
  // https://api.devio.org/uapi/fa/favorite/BV1SK4y1h7E9
  static favorite(String vid, bool favorite) async {
    BaseRequest request =
        favorite ? FavoriteRequest() : CancelFavoriteRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return result;
  }
}
