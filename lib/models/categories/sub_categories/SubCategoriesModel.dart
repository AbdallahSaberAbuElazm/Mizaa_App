import 'package:test_ecommerce_app/models/categories/CategoryModel.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'SubCategoriesModel.freezed.dart';
part 'SubCategoriesModel.g.dart';

@freezed
class SubCategoriesModel with _$SubCategoriesModel {
  factory SubCategoriesModel({
    required int id,
    required int categoryId,
    required String key,
    required String arName,
    required String enName,
    required String imageUrl,
    String? image,
    CategoryModel? category,
    OfferModel? offers,
  }) = _SubCategoryModel;

  factory SubCategoriesModel.fromJson(JSON json) =>
      _$SubCategoriesModelFromJson(json);
}
