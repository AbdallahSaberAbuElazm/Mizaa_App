import 'package:mizaa/models/categories/sub_categories/SubCategoriesModel.dart';
import 'package:mizaa/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'CategoryModel.freezed.dart';
part 'CategoryModel.g.dart';

@freezed
class CategoryModel with _$CategoryModel {
  factory CategoryModel({
    required int id,
    required String key,
    required String arName,
    required String enName,
    required String imageUrl,
    String? image,
    required int order,
    List<SubCategoriesModel>? subCategories,
  }) = _CategoryModel;

  factory CategoryModel.fromJson(JSON json) => _$CategoryModelFromJson(json);
}
