import 'dart:convert';

import 'package:mizaa/models/merchant/merchant_detail_model/merchant_detail_model.dart';
import 'package:mizaa/models/merchant/merchant_model.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/models/search/search_model.dart';
import 'package:mizaa/services/networking/ApiConstants.dart';
import 'package:mizaa/shared/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:mizaa/shared/shared_preferences.dart';

class SearchRepository {
  Map<String, String> requestHeaders = {
    'Content-Type': 'application/json',
  };
  Future<List<SearchModel>> getOffersAndSellersInCity(
      {required int cityId,
      required String searchKeyWord,
      required String userMobile,
      required String deviceToken}) async {
    var response = await http.post(
      Uri.parse(ApiConstants.searchOffersOrSellersInCity),
      headers: requestHeaders,
      body: jsonEncode({
        "cityId": cityId,
        "searchKeyWord": searchKeyWord,
        "userMobile": userMobile,
        "deviceToken": deviceToken
      }),
    );
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => SearchModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  Future<List<SearchModel>> getOffersInMainCategoryWithCity(
      {required int cityId,
      required String searchKeyWord,
      required int mainCatId,
      required String userMobile,
      required String deviceToken}) async {
    var response = await http.post(
      Uri.parse(ApiConstants.searchOffersInMainCategory),
      headers: requestHeaders,
      body: jsonEncode({
        "cityId": cityId,
        "searchKeyWord": searchKeyWord,
        "mainCatId": 1,
        "userMobile": userMobile,
        "deviceToken": deviceToken
      }),
    );
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => SearchModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  Future<List<SearchModel>> getOffersInSubCategoryWithCity(
      {required int cityId,
      required String searchKeyWord,
      required int subCatId,
      required String userMobile,
      required String deviceToken}) async {
    var response = await http.post(
      Uri.parse(ApiConstants.searchOffersInSubCategory),
      headers: requestHeaders,
      body: jsonEncode({
        "cityId": cityId,
        "searchKeyWord": searchKeyWord,
        "mainCatId": 1,
        "userMobile": userMobile,
        "deviceToken": deviceToken
      }),
    );
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => SearchModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  getMerchantsInSubCategoryWithCity() {}

  Future<List<MerchantModel>> getMerchantsInSearch({
    required int cityId,
    required String searchKeyWord,
  }) async {
    var response = await http.post(
      Uri.parse(ApiConstants.findMerchant),
      headers: requestHeaders,
      body: jsonEncode({
        "cityId": cityId,
        "searchKeyWord": searchKeyWord,
      }),
    );
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => MerchantModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  Future<OfferModel> getOffer({required String offerKey}) async {
    var response = await http.get(Uri.parse(
        '${ApiConstants.offerDetailsByOfferKeyUrl}$offerKey/TOKEN/${SharedPreferencesClass.getPhoneNumber()}'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return OfferModel.fromJson(body);
    } else {
      throw ServerException();
    }
  }

  Future<MerchantDetailModel> getMerchant({required String merchantKey}) async {
    var response = await http
        .get(Uri.parse('${ApiConstants.getMerchantById}$merchantKey/'));
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return MerchantDetailModel.fromJson(body);
    } else {
      throw ServerException();
    }
  }

  // Future<CompanyModel> getMerchant(
  //     {required String cityId, required String categoryId}) async {
  //   var response = await http.get(Uri.parse(
  //       '${ApiConstants.companiesByCityIdAndCatId}$cityId/$categoryId'));
  //   if (response.statusCode == 200) {
  //     final List<dynamic> body = json.decode(response.body);
  //     return CompanyModel.fromJson(body[0]);
  //   } else {
  //     throw ServerException();
  //   }
  // }
}
