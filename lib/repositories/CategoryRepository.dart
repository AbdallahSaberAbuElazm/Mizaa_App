import 'dart:convert';

import 'package:test_ecommerce_app/models/categories/CategoryModel.dart';
import 'package:test_ecommerce_app/models/categories/sub_categories/SubCategoriesModel.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:test_ecommerce_app/shared/error/exception.dart';

class CategoryRepository {
  // final ApiService _apiService;
  //
  // CategoryRepository(this._apiService);

  Future<List<CategoryModel>> getMainCategories() async {
    var response =  await http.get(Uri.parse(ApiConstants.mainCategoryUrl));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => CategoryModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }

  Future<List<SubCategoriesModel>> getSubCategoriesByMainCategoryId({required String mainCategoryId}) async {
    var response =  await http.get(Uri.parse(ApiConstants.subCategoriesByCatIdUrl + mainCategoryId));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => SubCategoriesModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }


}
