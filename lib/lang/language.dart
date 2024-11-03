import 'package:get/get.dart';

class Messages extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        "zh_CN": {
          "hello": "你好，世界",
          "title": "标题",
        },
        "en_US": {
          "hello": "hello, world",
          "title": "title",
        }
      };
}
