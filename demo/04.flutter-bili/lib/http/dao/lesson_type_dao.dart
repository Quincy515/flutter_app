import 'package:e_social_work/http/request/index.dart';
import 'package:e_social_work/model/lesson_type_mo.dart';
import 'package:hi_net/hi_net.dart';

class LessonTypeDao {
  static get({int pageIndex = 1, int pageSize = 10}) async {
    LessonTypeRequest request = LessonTypeRequest();
    /** curl -X 'POST' 'http://3p9448f078.wicp.vip/api/lessontypes/search' -d ''
     * {
          "numberPerPage": 10,
          "currentPage": 1,
          "sortList": [
            {
            "columnName": "CreatedUTC",
            "sortOrder": 0
            }
          ],
          "filters": [
            {
            "key": "IsDeleted",
            "filterType": 2,
            "value": "false"
            }
          ]
        }
     */
    request.add("numberPerPage", pageSize).add("currentPage", pageIndex);
    var result;
    result = await HiNet.getInstance().fire(request);
    return LessonTypeMo.fromJson(result);
  }
}
