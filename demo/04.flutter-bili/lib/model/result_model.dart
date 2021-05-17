import 'package:json_annotation/json_annotation.dart';

// 将在我们运行生成命令后自动生成
part 'result_model.g.dart';

// 这个标注是告诉生成器，这个类是需要生成 Model 类的
@JsonSerializable()
class ResultModel extends Object {
  // 定义字段
  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'vid')
  String vid;

  @JsonKey(name: 'title')
  String title;

  @JsonKey(name: 'tname')
  String tname;

  @JsonKey(name: 'url')
  String url;

  @JsonKey(name: 'cover')
  String cover;

  @JsonKey(name: 'pubdate')
  int pubdate;

  @JsonKey(name: 'desc')
  String desc;

  @JsonKey(name: 'view')
  int view;

  @JsonKey(name: 'duration')
  int duration;

  @JsonKey(name: 'owner')
  Owner owner;

  @JsonKey(name: 'reply')
  int reply;

  @JsonKey(name: 'favorite')
  int favorite;

  @JsonKey(name: 'like')
  int like;

  @JsonKey(name: 'coin')
  int coin;

  @JsonKey(name: 'share')
  int share;

  @JsonKey(name: 'createTime')
  String createTime;

  @JsonKey(name: 'size')
  int size;

  // 定义构造方法
  ResultModel(
    this.id,
    this.vid,
    this.title,
    this.tname,
    this.url,
    this.cover,
    this.pubdate,
    this.desc,
    this.view,
    this.duration,
    this.owner,
    this.reply,
    this.favorite,
    this.like,
    this.coin,
    this.share,
    this.createTime,
    this.size,
  );

  // 固定格式，不同的类使用不同的 mixin 即可
  factory ResultModel.fromJson(Map<String, dynamic> srcJson) =>
      _$ResultModelFromJson(srcJson);

  // 固定格式
  Map<String, dynamic> toJson() => _$ResultModelToJson(this);
}

@JsonSerializable()
class Owner extends Object {
  @JsonKey(name: 'name')
  String name;

  @JsonKey(name: 'face')
  String face;

  @JsonKey(name: 'fans')
  int fans;

  Owner(
    this.name,
    this.face,
    this.fans,
  );

  factory Owner.fromJson(Map<String, dynamic> srcJson) =>
      _$OwnerFromJson(srcJson);

  Map<String, dynamic> toJson() => _$OwnerToJson(this);
}
