import 'package:mizaa/models/location/city/CityModel.dart';
import 'package:mizaa/models/location/country/CountryModel.dart';
import 'package:mizaa/models/user/basic_info/user_basic_info.dart';
import 'package:mizaa/models/user/user_service.dart';
import 'package:mizaa/models/user/wallet/wallet_model.dart';
import 'package:mizaa/repositories/user_authentication_repository.dart';

class UserAuthenticationProvider {
  final UserAuthenticationRepository userAuthenticationRepository;
  UserAuthenticationProvider(this.userAuthenticationRepository);

  Future<UserService> otpLogin(
      {required String mobileNo, required String password}) async {
    return await userAuthenticationRepository.otpLogin(
        mobileNo: mobileNo, password: password);
  }

  Future<UserBasicInfo> getUserBasicInfo(
      {required String phoneNumber, required String token}) async {
    return await userAuthenticationRepository.getUserBasicInfo(
        phoneNumber: phoneNumber, token: token);
  }

  Future<Map<String, dynamic>> recoverPasswordOtp(
      {required String password,
      required String mobile,
      required String otp}) async {
    return await userAuthenticationRepository.recoverPasswordOtp(
        password: password, mobile: mobile, otp: otp);
  }

  Future<Map<String, dynamic>> recoverPassword({
    required String password,
    required String mobile,
  }) async {
    return await userAuthenticationRepository.recoverPassword(
      password: password,
      mobile: mobile,
    );
  }

  Future<Map<String, dynamic>> register({
    required String mobileNo,
    required String firstName,
    required String password,
  }) async {
    return await userAuthenticationRepository.register(
        mobileNo: mobileNo, firstName: firstName, password: password);
  }

  Future<Map<String, dynamic>> registerOtp({
    required String mobileNo,
    required String firstName,
    required String password,
    required String otpCode,
  }) async {
    return await userAuthenticationRepository.registerOtp(
        mobileNo: mobileNo,
        firstName: firstName,
        password: password,
        otpCode: otpCode);
  }

  Future<Map<String, dynamic>> updateUserDate({
    required String mobileNo,
    required String name,
    required String email,
    required DateTime dateOfBrith,
    required int gender,
    required int cityId,
    required int countryId,
  }) async {
    return await userAuthenticationRepository.updateUserDate(
        mobileNo: mobileNo,
        name: name,
        email: email,
        dateOfBrith: dateOfBrith,
        gender: gender,
        cityId: cityId,
        countryId: countryId);
  }

  Future<Map<String, dynamic>> resetPassword({
    required String oldPassword,
    required String newPassword,
    required String mobile,
  }) async {
    return await userAuthenticationRepository.resetPassword(
        oldPassword: oldPassword, newPassword: newPassword, mobile: mobile);
  }

  Future<String> addDeviceToken() async {
    return await userAuthenticationRepository.addDeviceToken();
  }

  Future<List<CountryModel>> getCountries() async {
    return await userAuthenticationRepository.getCountries();
  }

  Future<List<CityModel>> getCites({required String id}) async {
    return await userAuthenticationRepository.getCites(id: id);
  }

  Future<WalletModel> getUserWallet() async {
    return await userAuthenticationRepository.getUserWallet();
  }
}
