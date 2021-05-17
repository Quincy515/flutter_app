// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ResultModel _$ResultModelFromJson(Map<String, dynamic> json) {
  return ResultModel(
    json['id'] as String,
    json['vid'] as String,
    json['title'] as String,
    json['tname'] as String,
    json['url'] as String,
    json['cover'] as String,
    json['pubdate'] as int,
    json['desc'] as String,
    json['view'] as int,
    json['duration'] as int,
    json['owner'] == null
        ? null
        : Owner.fromJson(json['owner'] as Map<String, dynamic>),
    json['reply'] as int,
    json['favorite'] as int,
    json['like'] as int,
    json['coin'] as int,
    json['share'] as int,
    json['createTime'] as String,
    json['size'] as int,
  );
}

Map<String, dynamic> _$ResultModelToJson(ResultModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'vid': instance.vid,
      'title': instance.title,
      'tname': instance.tname,
      'url': instance.url,
      'cover': instance.cover,
      'pubdate': instance.pubdate,
      'desc': instance.desc,
      'view': instance.view,
      'duration': instance.duration,
      'owner': instance.owner,
      'reply': instance.reply,
      'favorite': instance.favorite,
      'like': instance.like,
      'coin': instance.coin,
      'share': instance.share,
      'createTime': instance.createTime,
      'size': instance.size,
    };

Owner _$OwnerFromJson(Map<String, dynamic> json) {
  return Owner(
    json['name'] as String,
    json['face'] as String,
    json['fans'] as int,
  );
}

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'name': instance.name,
      'face': instance.face,
      'fans': instance.fans,
    };
