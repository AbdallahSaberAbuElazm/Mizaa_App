import 'package:test_ecommerce_app/models/location/city/CityModel.dart';
import 'package:test_ecommerce_app/models/location/country/CountryModel.dart';
import 'package:test_ecommerce_app/models/user/basic_info/user_basic_info.dart';
import 'package:test_ecommerce_app/models/user/user_service.dart';
import 'package:test_ecommerce_app/models/user/wallet/wallet_model.dart';
import 'package:test_ecommerce_app/repositories/user_authentication_repository.dart';

class UserAuthenticationProvider{
  final UserAuthenticationRepository userAuthenticationRepository;
  UserAuthenticationProvider(this.userAuthenticationRepository);

  Future<UserService> otpLogin(
      {required String mobileNo, required String password}) async {
    return await userAuthenticationRepository.otpLogin(mobileNo: mobileNo, password: password);
  }

  Future<UserBasicInfo> getUserBasicInfo({required String phoneNumber, required String token}) async {
    return await userAuthenticationRepository.getUserBasicInfo(phoneNumber: phoneNumber, token: token);
  }

  Future<Map<String, dynamic>> recoverPasswordOtp({required String password, required String mobile, required String otp})async {
    return await userAuthenticationRepository.recoverPasswordOtp(password: password, mobile: mobile, otp: otp);
  }

  Future<Map<String, dynamic>> recoverPassword({required String password, required String mobile,})async {
    return await userAuthenticationRepository.recoverPassword(password: password, mobile: mobile,);
  }

  Future<Map<String, dynamic>> register({required String mobileNo,
    required String firstName,
    required String password,
  }) async {
    return await userAuthenticationRepository.register(mobileNo: mobileNo, firstName: firstName, password: password);
  }

  Future<Map<String, dynamic>> registerOtp({required String mobileNo,
    required String firstName,
    required String password,
    required String otpCode,
  }) async {
    return await userAuthenticationRepository.registerOtp(mobileNo: mobileNo, firstName: firstName, password: password, otpCode: otpCode);
  }

  Future<List<CountryModel>> getCountries()async{
    return await userAuthenticationRepository.getCountries();
  }

  Future<List<CityModel>> getCites({required String id})async{
    return await userAuthenticationRepository.getCites(id: id);
  }

  Future<WalletModel> getUserWallet()async{
    return await userAuthenticationRepository.getUserWallet();
  }
}