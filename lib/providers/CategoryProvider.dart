import 'package:mizaa/models/categories/CategoryModel.dart';
import 'package:mizaa/models/categories/sub_categories/SubCategoriesModel.dart';
import 'package:mizaa/repositories/CategoryRepository.dart';

class CategoryProvider {
  final CategoryRepository _categoryRepository;

  CategoryProvider(this._categoryRepository);

  Future<List<CategoryModel>> getMainCategories() async {
    var categories = await _categoryRepository.getMainCategories();
    return categories
        .map((category) => CategoryModel.fromJson(category.toJson()))
        .toList();
  }

  Future<List<SubCategoriesModel>> getSubCategoriesByMainCategoryId(
      {required String mainCategoryId}) async {
    var categories = await _categoryRepository.getSubCategoriesByMainCategoryId(
        mainCategoryId: mainCategoryId);
    return categories
        .map((category) => SubCategoriesModel.fromJson(category.toJson()))
        .toList();
  }
}
