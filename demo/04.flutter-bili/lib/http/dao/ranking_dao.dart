import 'package:e_social_work/http/request/ranking_request.dart';
import 'package:e_social_work/model/ranking_mo.dart';
import 'package:hi_net/hi_net.dart';

class RankingDao {
  static get(String sort, {int pageIndex = 1, pageSize = 10}) async {
    RankingRequest request = RankingRequest();
    request
        .add("sort", sort)
        .add("pageIndex", pageIndex)
        .add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    print(result);
    return RankingMo.fromJson(result['data']);
  }
}
