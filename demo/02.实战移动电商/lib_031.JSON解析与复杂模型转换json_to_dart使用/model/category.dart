class CategoryBigModel {
  String mallCategoryId; // 类别编号
  String mallCategoryName; // 类别名称
  List<dynamic> bxMallSubDto;
  Null comments;
  String image;

  // 构造方法
  CategoryBigModel({
    this.mallCategoryId,
    this.mallCategoryName,
    this.bxMallSubDto,
    this.comments,
    this.image,
  });

  // 工厂构造模式，最常见的实例化对象
  factory CategoryBigModel.fromJson(dynamic json) {
    return CategoryBigModel(
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
      bxMallSubDto: json['bxMallSubDto'],
      comments: json['comments'],
      image: json['image'],
    );
  }
}

class CategoryBigListModel {
  List<CategoryBigModel> data;

  CategoryBigListModel(this.data);

  factory CategoryBigListModel.formJson(List json) {
    return CategoryBigListModel(
        json.map((i) => CategoryBigModel.fromJson(i)).toList());
  }
}
