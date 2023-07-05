import 'package:test_ecommerce_app/models/user/basic_info/user_basic_info.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_ecommerce_app/models/user/user_login_data.dart';

class SharedPreferencesClass{
  static SharedPreferences? _sharedPreferences;

  static Future init() async =>
      _sharedPreferences = await SharedPreferences.getInstance();

  static setUserData({required UserLoginData userLoginData})async {
    await _sharedPreferences!.setString('firstName', userLoginData.firstName);
    await _sharedPreferences!.setString('phoneNumber', userLoginData.phoneNumber);
    await _sharedPreferences!.setString('token', userLoginData.token);
  }


  static setUserBasicInfo({required UserBasicInfo userBasicInfo})async {
    await _sharedPreferences!.setString('applicationUserId', userBasicInfo.applicationUserId);
    await _sharedPreferences!.setString('balance', userBasicInfo.balance.toString());
    await _sharedPreferences!.setString('points', userBasicInfo.points.toString());
  }

  static setUserLocation({required String countryId, required String cityId,required String language})async{
    await _sharedPreferences!.setString('countryId', countryId);
    await _sharedPreferences!.setString('cityId', cityId);
    await _sharedPreferences!.setString('language', cityId);
  }

  static setUserLanguageCode({required String language})async{
    await _sharedPreferences!.setString('languageCode', language);
  }

  static setUserLanguageName({required String language})async{
    await _sharedPreferences!.setString('language', language);
  }

  static setUserCountryId({required String countryId})async{
    await _sharedPreferences!.setString('countryId', countryId);
  }

  static setUserCity({required String cityId})async{
    await _sharedPreferences!.setString('cityId', cityId);
  }

  static removeDataForLogout()async {
    await _sharedPreferences!.remove('phoneNumber');
    await _sharedPreferences!.remove('firstName');
    await _sharedPreferences!.remove('token');
    // await _sharedPreferences!.remove('countryId');
    // await _sharedPreferences!.remove('cityId');
  }

  static String? getUserId() => _sharedPreferences!.getString('userId');
  static String? getPhoneNumber() =>_sharedPreferences!.getString('phoneNumber');
  static String? getFirstName() =>_sharedPreferences!.getString('firstName');
  static String? getToken() =>_sharedPreferences!.getString('token');
  static String? getApplicationUserId() =>_sharedPreferences!.getString('applicationUserId');
  static String? getBalance() =>_sharedPreferences!.getString('balance');
  static String? getPoints() =>_sharedPreferences!.getString('points');
  static String? getCountryId() =>_sharedPreferences!.getString('countryId');
  static String? getCityId() =>_sharedPreferences!.getString('cityId');
  static String? getLanguageCode() =>_sharedPreferences!.getString('languageCode');
  static String? getLanguageName() =>_sharedPreferences!.getString('language');
}


