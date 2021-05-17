// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_type_mo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LessonTypeMo _$LessonTypeMoFromJson(Map<String, dynamic> json) {
  return LessonTypeMo(
    (json['data'] as List)
        ?.map((e) => e == null
            ? null
            : LessonTypeDataMo.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    json['pager'] == null
        ? null
        : LessonTypePagerMo.fromJson(json['pager'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$LessonTypeMoToJson(LessonTypeMo instance) =>
    <String, dynamic>{
      'data': instance.lessonTypeDataMo,
      'pager': instance.lessonTypePagerMo,
    };

LessonTypeDataMo _$LessonTypeDataMoFromJson(Map<String, dynamic> json) {
  return LessonTypeDataMo(
    json['lessonTypeName'] as String,
    json['description'] as String,
    json['id'] as String,
    json['isDeleted'] as bool,
    json['createdUTC'] as String,
  );
}

Map<String, dynamic> _$LessonTypeDataMoToJson(LessonTypeDataMo instance) =>
    <String, dynamic>{
      'lessonTypeName': instance.lessonTypeName,
      'description': instance.description,
      'id': instance.id,
      'isDeleted': instance.isDeleted,
      'createdUTC': instance.createdUTC,
    };

LessonTypePagerMo _$LessonTypePagerMoFromJson(Map<String, dynamic> json) {
  return LessonTypePagerMo(
    json['numberPerPage'] as int,
    json['currentPage'] as int,
    json['totalItems'] as int,
    json['totalPages'] as int,
    (json['sortList'] as List)
        ?.map((e) =>
            e == null ? null : SortList.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$LessonTypePagerMoToJson(LessonTypePagerMo instance) =>
    <String, dynamic>{
      'numberPerPage': instance.numberPerPage,
      'currentPage': instance.currentPage,
      'totalItems': instance.totalItems,
      'totalPages': instance.totalPages,
      'sortList': instance.sortList,
    };

SortList _$SortListFromJson(Map<String, dynamic> json) {
  return SortList(
    json['columnName'] as String,
    json['sortOrder'] as int,
  );
}

Map<String, dynamic> _$SortListToJson(SortList instance) => <String, dynamic>{
      'columnName': instance.columnName,
      'sortOrder': instance.sortOrder,
    };
