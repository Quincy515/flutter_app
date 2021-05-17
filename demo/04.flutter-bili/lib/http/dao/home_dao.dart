import 'package:e_social_work/http/request/home_request.dart';
import 'package:e_social_work/model/home_mo.dart';
import 'package:hi_net/hi_net.dart';

class HomeDao {
  static get(String categoryName, {int pageIndex = 1, int pageSize = 1}) async {
    // https://api.devio.org/uapi/fa/home/推荐?pageIndex=1&pageSize=10 首页接口
    HomeRequest request = HomeRequest();
    request.pathParams = categoryName;
    request.add("pageIndex", pageIndex).add("pageSize", pageSize);
    var result = await HiNet.getInstance().fire(request);
    // print(result);
    return HomeMo.fromJson(result['data']);
  }
}
