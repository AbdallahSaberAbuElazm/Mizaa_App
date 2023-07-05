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

class UserAuthenticationRepository{

   var client = http.Client();

   Future<UserService> otpLogin(
      {required String mobileNo, required String password}) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url =  Uri.parse(ApiConstants.otpLoginUrl);
    Map<String, dynamic> bodyData = {};

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({"mobile": mobileNo, "password": password}),
    );

    if (response.statusCode == 200) {
      // bodyData = ( json.decode(response.body) is Map) ? json.decode(response.body) : {};
      bodyData = json.decode(response.body);
    }
    if(bodyData['isAuthenticated'] == true){
    return UserService.fromJson(bodyData);}else{
      return UserService(firstName: "", phoneNumber: "", token: "") ;
     }
  }

   Future<UserBasicInfo> getUserBasicInfo({required String phoneNumber, required String token}) async {
     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json',
       "Authorization": "Bearer $token",
     };

     var url =  Uri.parse(ApiConstants.getUserBasicInfo+ phoneNumber.toString());
     Map<String, dynamic> bodyData = {};

     var response = await client.get(
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

   Future<Map<String, dynamic>> recoverPasswordOtp({required String password, required String mobile, required String otp})async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url =  Uri.parse(
        ApiConstants.recoveryOtpUrl
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "password": password,
        'mobile': mobile,
        "otp": otp
      }),
    );
    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    return bodyData;
  }

   Future<Map<String, dynamic>> recoverPassword({required String password, required String mobile})async {
     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json',
     };

     var url =  Uri.parse(
         ApiConstants.recoveryUrl + mobile
     );

     var response = await client.post(
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

    var url =  Uri.parse(
        ApiConstants.registerUrl
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "firstName": firstName,
        "mobile": mobileNo,
        "password": password,
        'city': SharedPreferencesClass.getCityId().toString(),
        'country':SharedPreferencesClass.getCountryId().toString(),
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
  }
      ) async {
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url = Uri.parse(
        ApiConstants.verifyOTPUrl+ otpCode
    );

    var response = await client.post(
      url,
      headers: requestHeaders,
      body: jsonEncode({
        "mobile": mobileNo,
        "password": password,
        "firstName": firstName,
      }),
    );
    Map<String, dynamic> bodyData = {};
    if (response.statusCode == 200) {
      bodyData = json.decode(response.body);
    }
    if(bodyData['firstName'] !=null){
      print('first name is ${bodyData['firstName']}');
      return bodyData;
    }else{
      return {};
    }

    // return loginResponseJson(response.body);
  }

  Future<List<CountryModel>> getCountries()async{
    Map<String, String> requestHeaders = {
      'Content-Type': 'application/json',
    };

    var url =  Uri.parse(ApiConstants.countryUrl);
    List<dynamic> bodyData =[];
    var client = http.Client();
    var response = await client.get(
      url,
      headers: requestHeaders,
    );

    if (response.statusCode == 200) {
      // bodyData = ( json.decode(response.body) is Map) ? json.decode(response.body) : {};
      bodyData = json.decode(response.body);
    }
      return bodyData.map((body)=> CountryModel.fromJson(body)).toList();

  }

   Future<List<CityModel>> getCites({required String id})async{
     Map<String, String> requestHeaders = {
       'Content-Type': 'application/json',
     };

     var url =  Uri.parse(ApiConstants.cityUrl+ id);
     List<dynamic> bodyData = [];
     var client = http.Client();
     var response = await client.get(
       url,
       headers: requestHeaders,
     );

     if (response.statusCode == 200) {
       // bodyData = ( json.decode(response.body) is Map) ? json.decode(response.body) : {};
       bodyData = json.decode(response.body);
     }
      return bodyData.map((body)=> CityModel.fromJson(body)).toList();

   }

   Future<WalletModel> getUserWallet()async{
     var response = await http.get(Uri.parse('${ApiConstants.userWallet}${SharedPreferencesClass.getPhoneNumber()}'),
         headers: {
           'Content-Type': 'application/json',
           'Authorization': 'Bearer ${SharedPreferencesClass.getToken()}',
         }
     );
     if (response.statusCode == 200) {
       final  body = json.decode(response.body);
       return WalletModel.fromJson(body);
     } else {
       throw ServerException();
     }
   }
}