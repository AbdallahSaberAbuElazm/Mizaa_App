import 'dart:convert';
import 'package:test_ecommerce_app/models/merchant/merchant_model.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/models/offers/offer_rate/OfferRateModel.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/error/exception.dart';
import 'package:http/http.dart' as http;
import 'package:test_ecommerce_app/shared/shared_preferences.dart';

class OfferRepository {

  Future<List<OfferModel>> getCarouselOffers({required String cityId}) async {
    var response =  await http.get(Uri.parse('${ApiConstants.carouselHomePageOfferByCityUrl}$cityId'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
     return  body.map((json) => OfferModel.fromJson(json)).toList();

  }else {
      throw ServerException();
    }
  }

  Future<List<OfferModel>> getTodayOffers({required String cityId}) async {
    var response =  await http.get(Uri.parse('${ApiConstants.todayOfferByCityUrl}$cityId'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => OfferModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }

  Future<List<OfferModel>> getSpecialOffers({required String cityId}) async {
    var response =  await http.get(Uri.parse('${ApiConstants.newOfferByCityUrl}$cityId'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => OfferModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }

  Future<List<OfferModel>> getMostSalesOffers({required String cityId}) async {
    var response =  await http.get(Uri.parse('${ApiConstants.mostSalesOfferByCityUrl}$cityId'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => OfferModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }

  Future<List<OfferModel>> getOffersForMainCategories({required String categoryId, required String city})async {
    var response =  await http.get(Uri.parse('${ApiConstants.offersByMainCategoryIdUrl}$categoryId/$city'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => OfferModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }

  Future<List<OfferModel>> getOffersForSubCategories({required String subCategoryId, required String city})async {
    var response =  await http.get(Uri.parse('${ApiConstants.offersBySubCategoryIdUrl}$subCategoryId/$city'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => OfferModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }

  Future<List<OfferRateModel>> getOfferRate({required String id})async{
    var response =  await http.get(Uri.parse('${ApiConstants.offerRateUrl}$id'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => OfferRateModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }

  Future<List<MerchantModel>> getMerchants({required String categoryId, required String cityId})async{
    var response =  await http.get(Uri.parse('${ApiConstants.companiesByCityIdAndCatId}$cityId/$categoryId'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return  body.map((json) => MerchantModel.fromJson(json)).toList();

    }else {
      throw ServerException();
    }
  }


  Future<OfferModel> getOffer({required String offerKey} )async {

    var response =  await http.get(Uri.parse('${ApiConstants.offerDetailsByOfferKeyUrl}$offerKey/TOKEN/${SharedPreferencesClass.getPhoneNumber()}'));
    if (response.statusCode == 200) {
      final  body = json.decode(response.body);
      return OfferModel.fromJson(body)  ;

    }else {
      throw ServerException();
    }
  }

  Future<bool> addRateToOffer({required int offerId, required String offerKey, required double rate})async{

    final body = {
      "offerId": offerId,
      "OfferKey":offerKey,
      "rate": rate,
      "applicationUserId":SharedPreferencesClass.getApplicationUserId()
    };

    print('user application id is ${SharedPreferencesClass.getApplicationUserId()} and body is $body');

    final response = await http.post(
      Uri.parse(ApiConstants.addRateToOffer),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
      },
    );

    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    print('response code is ${response.statusCode}');
    if(bodyData['isDone'] == true){
      print('rate added');
      return true;
    }else {
      return false;
    }
  }

  Future<bool> checkIfUserRatedBefore({required int offerId, required String offerKey})async{
    final body = {
      "offerId": offerId,
      "OfferKey":offerKey,
      "applicationUserId":SharedPreferencesClass.getApplicationUserId()
    };



    final response = await http.post(
      Uri.parse(ApiConstants.checkIfUserRateBefore),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
      },
    );
    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    print('response code is ${response.statusCode}');
    if(bodyData['isRatedBefor'] == true){
      print(' user rated before ${bodyData['isRatedBefor']} token is ${SharedPreferencesClass.getToken()} and user mobile is ${SharedPreferencesClass.getPhoneNumber()}');
      return true;
    }else {
      return false;
    }
  }
}
