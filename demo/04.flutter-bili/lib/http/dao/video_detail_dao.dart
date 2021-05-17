import 'package:e_social_work/http/request/video_detail_request.dart';
import 'package:e_social_work/model/video_detail_mo.dart';
import 'package:hi_net/hi_net.dart';

// 视频详情页的 Dao
class VideoDetailDao {
  // https://api.devio.org/uapi/fa/detail/BV19C4y1s7Ka
  static get(String vid) async {
    VideoDetailRequest request = VideoDetailRequest();
    request.pathParams = vid;
    var result = await HiNet.getInstance().fire(request);
    return VideoDetailMo.fromJson(result['data']);
  }
}
