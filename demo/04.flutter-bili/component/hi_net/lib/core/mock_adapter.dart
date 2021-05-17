import 'package:hi_net/core/hi_net_adapter.dart';
import 'package:hi_net/request/base_request.dart';

///测试适配器，mock 数据
class MockAdapter extends HiNetAdapter {
  @override
  Future<HiNetResponse<T>> send<T>(HiBaseRequest request) {
    return Future<HiNetResponse>.delayed(Duration(milliseconds: 1000), () {
      return HiNetResponse(
          data: {"code": 0, "msg": "SUCCESS."}, statusCode: 200);
    });
  }
}
