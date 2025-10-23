class CategoriesModel {
  int? categoriesId;
  String? categoriesName;
  String? categoriesNameAr;
  String? categoriesImage;
  int? categoriesActive;
  String? categoriesUpdateAt;
  String? categoriesCreateAt;

  CategoriesModel(
      {this.categoriesId,
        this.categoriesName,
        this.categoriesNameAr,
        this.categoriesImage,
        this.categoriesActive,
        this.categoriesUpdateAt,
        this.categoriesCreateAt});

  CategoriesModel.fromJson(Map<String, dynamic> json) {
    categoriesId = json['categories_id'];
    categoriesName = json['categories_name'];
    categoriesNameAr = json['categories_name_ar'];
    categoriesImage = json['categories_image'];
    categoriesActive = json['categories_active'];
    categoriesUpdateAt = json['categories_updateAt'];
    categoriesCreateAt = json['categories_createAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categories_id'] = this.categoriesId;
    data['categories_name'] = this.categoriesName;
    data['categories_name_ar'] = this.categoriesNameAr;
    data['categories_image'] = this.categoriesImage;
    data['categories_active'] = this.categoriesActive;
    data['categories_updateAt'] = this.categoriesUpdateAt;
    data['categories_createAt'] = this.categoriesCreateAt;
    return data;
  }
}