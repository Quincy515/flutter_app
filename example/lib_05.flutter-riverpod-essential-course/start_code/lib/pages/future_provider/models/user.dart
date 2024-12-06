import 'package:freezed_annotation/freezed_annotation.dart';

// 快捷键 ptf 生成 freezed 文件
part 'user.freezed.dart';
// 快捷键 pts 生成 g.dart 文件
part 'user.g.dart';

// 快捷键 fdataClass 生成 class
@freezed
class User with _$User {
  const factory User({
    required int id,
    required String name,
    required String email,
    required String username,
    required String phone,
    required String website,
  }) = _User;

  // 快捷键 fromJson 生成 fromJson 工厂构造函数，并将 User 作为名词
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
