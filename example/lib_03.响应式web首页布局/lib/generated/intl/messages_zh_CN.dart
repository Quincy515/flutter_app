// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static m0(value) => "项 ${value}";

  static m1(name) => "欢迎 ${name}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static _notInlinedMessages(_) => <String, Function> {
    "starterAppDrawerItem" : m0,
    "starterAppGenericBody" : MessageLookupByLibrary.simpleMessage("正文"),
    "starterAppGenericButton" : MessageLookupByLibrary.simpleMessage("按钮"),
    "starterAppGenericHeadline" : MessageLookupByLibrary.simpleMessage("标题"),
    "starterAppGenericSubtitle" : MessageLookupByLibrary.simpleMessage("副标题"),
    "starterAppGenericTitle" : MessageLookupByLibrary.simpleMessage("标题"),
    "starterAppTitle" : MessageLookupByLibrary.simpleMessage("入门应用"),
    "starterAppTooltipAdd" : MessageLookupByLibrary.simpleMessage("添加"),
    "starterAppTooltipFavorite" : MessageLookupByLibrary.simpleMessage("收藏"),
    "starterAppTooltipSearch" : MessageLookupByLibrary.simpleMessage("搜索"),
    "starterAppTooltipShare" : MessageLookupByLibrary.simpleMessage("分享"),
    "welcome" : m1
  };
}
