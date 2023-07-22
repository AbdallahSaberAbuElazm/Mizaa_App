import 'dart:convert';
import 'package:test_ecommerce_app/models/location/city/CityModel.dart';
import 'package:test_ecommerce_app/models/location/country/CountryModel.dart';
import 'package:test_ecommerce_app/models/user/basic_info/user_basic_info.dart';
import 'package:test_ecommerce_app/models/user/wallet/wallet_model.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:http/http.dart' as http;
import 'package:test_ecommerce_app/models/user/user_service.dart';
import 'package:test_ecommerce_app/shared/error/exception.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class UserAuthenticationRepository {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future<UserService> otpLogin(
      {required String mobileNo, required String password}) async {
    String? fcmToken = await messaging.getToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ApiConstants.otpLoginUrl);
    Map<String, dynamic> bodyData = {};

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode(
          {"mobile": mobileNo, "password": password, 'token': fcmToken!}),
    );

    if (response.statusCode == 200) {
      // bodyData = ( json.decode(response.body) is Map) ? json.decode(response.body) : {};
      bodyData = json.decode(response.body);
    }
    if (bodyData['isAuthenticated'] == true) {
      return UserService.fromJson(bodyData);
    } else {
      return UserService(firstName: "", phoneNumber: "", token: "");
    }
  }

  Future<UserBasicInfo> getUserBasicInfo(
      {required String phoneNumber, required String token}) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer $token",
    };

    var url = Uri.parse(ApiConstants.getUserBasicInfo + phoneNumber.toString());
    Map<String, dynamic> bodyData = {};

    var response = await http.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      // bodyData = ( json.decode(response.body) is Map) ? json.decode(response.body) : {};
      bodyData = json.decode(response.body);
      print('body data of user basic info $bodyData');
    }

    return UserBasicInfo.fromJson(bodyData);
  }

  Future<Map<String, dynamic>> recoverPasswordOtp(
      {required String password,
      required String mobile,
      required String otp}) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ApiConstants.recoveryOtpUrl);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"password": password, 'mobile': mobile, "otp": otp}),
    );
    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    return bodyData;
  }

  Future<Map<String, dynamic>> recoverPassword(
      {required String password, required String mobile}) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ApiConstants.recoveryUrl + mobile);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "password": password,
        'mobile': mobile,
      }),
    );
    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }

    print('recovery response is $bodyData and recovery url is $url');
    // return UserService.fromJson(bodyData);
    return bodyData;
  }

  Future<Map<String, dynamic>> register({
    required String mobileNo,
    required String firstName,
    required String password,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ApiConstants.registerUrl);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "firstName": firstName,
        "mobile": mobileNo,
        "password": password,
        'city': SharedPreferencesClass.getCityId().toString(),
        'country': SharedPreferencesClass.getCountryId().toString(),
      }),
    );
    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    return bodyData;
    // return loginResponseJson(response.body);
  }

  Future<Map<String, dynamic>> registerOtp({
    required String mobileNo,
    required String firstName,
    required String password,
    required String otpCode,
  }) async {
    String? fcmToken = await messaging.getToken();
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ApiConstants.verifyOTPUrl + otpCode);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "mobile": mobileNo,
        "password": password,
        "firstName": firstName,
        "DeviceToken": fcmToken!
      }),
    );
    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    if (bodyData['firstName'] != null) {
      print('first name is ${bodyData['firstName']}');
      return bodyData;
    } else {
      return {};
    }

    // return loginResponseJson(response.body);
  }

  // add device token
  Future<String> addDeviceToken() async {
    String? fcmToken = await messaging.getToken();

    var url = Uri.parse(ApiConstants.getDeviceToken + fcmToken!);
    Map<String, dynamic> bodyData = {};

    var response = await http.get(
      url,
    );

    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    return bodyData['message'];
  }

  //// update user data
  Future<Map<String, dynamic>> updateUserDate({
    required String mobileNo,
    required String name,
    required String email,
    required DateTime dateOfBrith,
    required int gender,
    required int cityId,
    required int countryId,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${SharedPreferencesClass.getToken().toString()}",
    };

    var url = Uri.parse(ApiConstants.updateUserData);
    var body = {
      "name": name,
      "email": email,
      "mobile": mobileNo,
      "dob": dateOfBrith.toIso8601String(),
      "gender": gender,
      "cityId": cityId,
      "countryId": countryId,
    };
    var response = await http.put(
      url,
      body: json.encode(body),
      headers: requestHeaders,
    );

    print(
        'the response status of update user data is ${response.statusCode} ,url is $url , body is $body and token ${SharedPreferencesClass.getToken()}');

    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
      return bodyData;
    } else {
      return bodyData;
    }
  }

  //// reset password
  Future<Map<String, dynamic>> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String mobile,
  }) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
      "Authorization": "Bearer ${SharedPreferencesClass.getToken()}",
    };

    var url = Uri.parse(ApiConstants.resetPassword);

    var response = await http.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "mobile": mobile
      }),
    );
    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    if (bodyData['isSuccess'] != null) {
      return bodyData;
    } else {
      return {};
    }
  }

  Future<List<CountryModel>> getCountries() async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ApiConstants.countryUrl);
    List<dynamic> bodyData = [];

    var response = await http.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      // bodyData = ( json.decode(response.body) is Map) ? json.decode(response.body) : {};
      bodyData = json.decode(response.body);
    }
    return bodyData.map((body) => CountryModel.fromJson(body)).toList();
  }

  Future<List<CityModel>> getCites({required String id}) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(ApiConstants.cityUrl + id);
    List<dynamic> bodyData = [];

    var response = await http.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      // bodyData = ( json.decode(response.body) is Map) ? json.decode(response.body) : {};
      bodyData = json.decode(response.body);
      return bodyData.map((body) => CityModel.fromJson(body)).toList();
    } else {
      return [];
    }
  }

  Future<WalletModel> getUserWallet() async {
    var response = await http.get(
        Uri.parse(
            '${ApiConstants.userWallet}${SharedPreferencesClass.getPhoneNumber()}'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${SharedPreferencesClass.getToken()}',
        });
    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return WalletModel.fromJson(body);
    } else {
      throw ServerException();
    }
  }
}
