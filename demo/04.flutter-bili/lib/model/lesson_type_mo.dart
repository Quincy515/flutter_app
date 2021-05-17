import 'package:json_annotation/json_annotation.dart';

part 'lesson_type_mo.g.dart';

@JsonSerializable()
class LessonTypeMo extends Object {
  @JsonKey(name: 'data')
  List<LessonTypeDataMo> lessonTypeDataMo;

  @JsonKey(name: 'pager')
  LessonTypePagerMo lessonTypePagerMo;

  LessonTypeMo(
    this.lessonTypeDataMo,
    this.lessonTypePagerMo,
  );

  factory LessonTypeMo.fromJson(Map<String, dynamic> srcJson) =>
      _$LessonTypeMoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LessonTypeMoToJson(this);
}

@JsonSerializable()
class LessonTypeDataMo extends Object {
  @JsonKey(name: 'lessonTypeName')
  String lessonTypeName;

  @JsonKey(name: 'description')
  String description;

  @JsonKey(name: 'id')
  String id;

  @JsonKey(name: 'isDeleted')
  bool isDeleted;

  @JsonKey(name: 'createdUTC')
  String createdUTC;

  LessonTypeDataMo(
    this.lessonTypeName,
    this.description,
    this.id,
    this.isDeleted,
    this.createdUTC,
  );

  factory LessonTypeDataMo.fromJson(Map<String, dynamic> srcJson) =>
      _$LessonTypeDataMoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LessonTypeDataMoToJson(this);
}

@JsonSerializable()
class LessonTypePagerMo extends Object {
  @JsonKey(name: 'numberPerPage')
  int numberPerPage;

  @JsonKey(name: 'currentPage')
  int currentPage;

  @JsonKey(name: 'totalItems')
  int totalItems;

  @JsonKey(name: 'totalPages')
  int totalPages;

  @JsonKey(name: 'sortList')
  List<SortList> sortList;

  LessonTypePagerMo(
    this.numberPerPage,
    this.currentPage,
    this.totalItems,
    this.totalPages,
    this.sortList,
  );

  factory LessonTypePagerMo.fromJson(Map<String, dynamic> srcJson) =>
      _$LessonTypePagerMoFromJson(srcJson);

  Map<String, dynamic> toJson() => _$LessonTypePagerMoToJson(this);
}

@JsonSerializable()
class SortList extends Object {
  @JsonKey(name: 'columnName')
  String columnName;

  @JsonKey(name: 'sortOrder')
  int sortOrder;

  SortList(
    this.columnName,
    this.sortOrder,
  );

  factory SortList.fromJson(Map<String, dynamic> srcJson) =>
      _$SortListFromJson(srcJson);

  Map<String, dynamic> toJson() => _$SortListToJson(this);
}
