import 'package:mizaa/models/favourite/favourite_model.dart';
import 'package:mizaa/services/networking/ApiConstants.dart';
import 'package:mizaa/shared/error/exception.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class FavouriteRepository {
  Future<bool> addToFavourites({required int offerId}) async {
    final body = {
      "userMobile": SharedPreferencesClass.getPhoneNumber(),
      "token": SharedPreferencesClass.getToken(),
      "offerId": offerId,
    };

    final response = await http.post(
      Uri.parse(ApiConstants.addToFavourite),
      body: json.encode(body),
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
      },
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> deleteFromFavourites({required String favouriteKey}) async {
    final response = await http.delete(
        Uri.parse('${ApiConstants.deleteFromFavourite}/$favouriteKey'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPreferencesClass.getToken()}',
        });
    if (response.statusCode == 200) {
      return true;
      // Update your app's cart or show a success message
    } else {
      return false;
    }
  }

  Future<List<FavouriteModel>> getFavourites() async {
    var response = await http.get(
        Uri.parse(
            '${ApiConstants.getFavouriteByMobile}${SharedPreferencesClass.getPhoneNumber()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPreferencesClass.getToken()}',
        });
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => FavouriteModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
