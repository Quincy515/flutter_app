import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'zh_CN': {
          'hello': '你好 世界',
          'Home': '主页',
          'Inputs': '输入',
        },
        'en_US': {
          'hello': 'Hello World',
          'Home': 'Home',
          'Inputs': 'Inputs',
        }
      };
}
