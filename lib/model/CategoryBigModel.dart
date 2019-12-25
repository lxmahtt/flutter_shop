class CategoryBigModel {
  List<BxMallSubDto> bxMallSubDto;
  String image;
  String mallCategoryId;
  String mallCategoryName;

  CategoryBigModel({this.bxMallSubDto, this.image, this.mallCategoryId, this.mallCategoryName});

  factory CategoryBigModel.fromJson(Map<String, dynamic> json) {
    return CategoryBigModel(
      bxMallSubDto: json['bxMallSubDto'] != null
          ? (json['bxMallSubDto'] as List).map((i) => BxMallSubDto.fromJson(i)).toList()
          : null,
      image: json['image'],
      mallCategoryId: json['mallCategoryId'],
      mallCategoryName: json['mallCategoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['image'] = this.image;
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallCategoryName'] = this.mallCategoryName;
    if (this.bxMallSubDto != null) {
      data['bxMallSubDto'] = this.bxMallSubDto.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class BxMallSubDto {
  String mallCategoryId;
  String mallSubId;
  String mallSubName;

  BxMallSubDto({this.mallCategoryId, this.mallSubId, this.mallSubName});

  factory BxMallSubDto.fromJson(Map<String, dynamic> json) {
    return BxMallSubDto(
      mallCategoryId: json['mallCategoryId'],
      mallSubId: json['mallSubId'],
      mallSubName: json['mallSubName'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['mallCategoryId'] = this.mallCategoryId;
    data['mallSubId'] = this.mallSubId;
    data['mallSubName'] = this.mallSubName;
    return data;
  }
}

class CategoryBigListModel {
  List<CategoryBigModel> categoryBigList;

  CategoryBigListModel(this.categoryBigList);

  factory CategoryBigListModel.fromJson(List json) {
    return CategoryBigListModel(json.map((i) => CategoryBigModel.fromJson(i)).toList());
  }
}
