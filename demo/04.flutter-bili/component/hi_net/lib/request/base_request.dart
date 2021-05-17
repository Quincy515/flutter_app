enum HttpMethod { GET, POST, DELETE, PUT }

///基础请求的抽象类 - 即支持查询参数，又支持path参数
///curl -X GET "http://api.devio.org/uapi/test/test?requestPrams=123" -H "accept: */*" 查询参数
///curl -X GET "https://api.devio.org/uapi/test/test/1" -H "accept: */*"  path 参数
///             协议:// 域名authority /   后缀 path  / pathParams 参数
abstract class HiBaseRequest {
  var pathParams; // path 参数
  bool useHttps() {
    // 默认 HTTP 请求
    return false;
  }

  String authority() {
    return "3p9448f078.wicp.vip"; // 域名
  }

  HttpMethod httpMethod(); // 设置请求方法

  String path(); // 设置后缀 /uapi/test/test

  String url() {
    Uri uri; // 通过 url 方法生成具体的 url
    var pathStr = path(); // 获取 path
    if (pathParams != null) {
      if (path().endsWith("/")) {
        pathStr = "${path()}$pathParams"; // 兼容处理 path 参数是否带 /
      } else {
        pathStr = "${path()}/$pathParams"; // 拼接 path 参数
      }
    }
    // http 和 https 的切换
    if (useHttps()) {
      uri = Uri.https(authority(), pathStr, params);
    } else {
      uri = Uri.http(authority(), pathStr, params);
    }
    print('url:${uri.toString()}');
    return uri.toString();
  }

  bool needLogin(); // 设置是否需要登录

  Map<String, String> params = Map(); // 查询参数

  HiBaseRequest add(String k, Object v) {
    params[k] = v.toString(); // 添加查询参数
    return this;
  }

  Map<String, dynamic> header = Map();

  HiBaseRequest addHeader(String k, Object v) {
    header[k] = v.toString(); // 添加请求 header
    return this;
  }
}
