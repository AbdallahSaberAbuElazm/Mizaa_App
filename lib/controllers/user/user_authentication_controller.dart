import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/models/location/city/CityModel.dart';
import 'package:test_ecommerce_app/models/location/country/CountryModel.dart';
import 'package:test_ecommerce_app/models/user/wallet/wallet_history/wallet_history_model.dart';
import 'package:test_ecommerce_app/models/user/wallet/wallet_model.dart';
import 'package:test_ecommerce_app/providers/user_authentication_provider.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/views/authentication/otp_verifiy_screen.dart';
import 'package:test_ecommerce_app/models/user/user_login_data.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class UserAuthenticationController extends GetxController {
  final UserAuthenticationProvider userAuthenticationProvider;
  UserAuthenticationController(this.userAuthenticationProvider);

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final passwordErrorText = ''.obs;

  // agree policy for register page
  final isChecked = false.obs;

  final otpController = ''.obs;
  final isButtonEnabled = false.obs;

  final selectedCountryPhoneCode = '002'.obs;
  final selectedCountryPhoneLength = 11.obs;

  final countries = <CountryModel>[].obs;
  final cities = <CityModel>[].obs;

  final userWallet = WalletModel(
          name: '',
          mobile: '',
          applicationUserId: '',
          balance: 0.0,
          points: 0,
          city: 0,
          country: 0,
          walletHistory: [])
      .obs;

  final walletHistories = <WalletHistoryModel>[].obs;

  //////// wallet screen attributes

  var num = 0.obs;
  var btnName = translation.all.tr.obs;

  // app bar for wallet screen
  late ScrollController scrollWalletScreenController ;
  final isScrolledWalletScreen = false.obs;
  final appBarWalletScreenColor = Colors.transparent.obs;
  final appBarItemContainerWalletScreenColor = Colors.white.obs;
  final appBarItemWalletScreenColor = Colors.white.obs;

  @override
  void onInit() {
    scrollWalletScreenController = ScrollController()
      ..addListener(_onScrollCartScreen);
    super.onInit();
  }


  void _onScrollCartScreen() {
    if (scrollWalletScreenController.offset > 20 &&
        !isScrolledWalletScreen.value) {
      isScrolledWalletScreen.value = true;
      appBarWalletScreenColor.value = Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white;
      appBarItemContainerWalletScreenColor.value = ColorConstants.mainColor;
      appBarItemWalletScreenColor.value = Colors.black;
    } else if (scrollWalletScreenController.offset <= 20 &&
        isScrolledWalletScreen.value) {
      isScrolledWalletScreen.value = false;
      appBarWalletScreenColor.value = Colors.transparent;
      appBarItemContainerWalletScreenColor.value = Colors.white;
      appBarItemWalletScreenColor.value = Colors.white;
    }
  }

  @override
  void dispose() {
    phoneNumberController.dispose();
    firstNameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  ///////////////////////////////////////////////
  loginListenerTextEditingController() {
    phoneNumberController.addListener(updateButtonStateLoginScreen);
    passwordController.addListener(updateButtonStateLoginScreen);
  }

  recoveryListenerTextEditingController() {
    phoneNumberController.addListener(updateButtonStateRecoveryScreen);
    passwordController.addListener(updateButtonStateRecoveryScreen);
    confirmPasswordController.addListener(updateButtonStateRecoveryScreen);
  }

  registerListenerTextEditingController() {
    phoneNumberController.addListener(updateButtonStateRegisterScreen);
    firstNameController.addListener(updateButtonStateRegisterScreen);
    passwordController.addListener(updateButtonStateRegisterScreen);
    confirmPasswordController.addListener(updateButtonStateRegisterScreen);
  }

  void updateButtonStateLoginScreen() {
    isButtonEnabled.value = phoneNumberController.text.isNotEmpty &&
        phoneNumberController.text.length == selectedCountryPhoneLength.value &&
        passwordController.text.isNotEmpty;
  }

  void updateButtonStateRegisterScreen() {
    isButtonEnabled.value = phoneNumberController.text.isNotEmpty &&
        phoneNumberController.text.length == selectedCountryPhoneLength.value &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text &&
        firstNameController.text.isNotEmpty;
  }

  void updateButtonStateRecoveryScreen() {
    isButtonEnabled.value = phoneNumberController.text.isNotEmpty &&
        phoneNumberController.text.length == selectedCountryPhoneLength.value &&
        passwordController.text.isNotEmpty &&
        confirmPasswordController.text.isNotEmpty &&
        passwordController.text == confirmPasswordController.text;
  }

  ///////////
  //update isChecked agree policy in register
  updateIsChecked({required bool isCheckedValue}) {
    isChecked.value = isCheckedValue;
    update();
  }

  ///////////////////////////////////////////////

  void clearLoginTextFieldData() {
    phoneNumberController.text = '';
    passwordController.text = '';
  }

  void clearRecoveryTextFieldData() {
    phoneNumberController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  void clearRegisterTextFieldData() {
    phoneNumberController.text = '';
    firstNameController.text = '';
    passwordController.text = '';
    confirmPasswordController.text = '';
  }

  ///////////////////////////////////////////////

  void getCountries() {
    userAuthenticationProvider.getCountries().then((value) {
      countries.value = value;
      Controllers.directionalityController
          .updateCountries(countriesData: value);
    });
  }

  void getCities({required String countryId}) {
    userAuthenticationProvider.getCites(id: countryId).then((value) {
      cities.value = value;
      Controllers.directionalityController.updateCities(citiesData: value);
    });
  }

  void otpLogin(
      {required String mobileNo,
      required String password,
      required BuildContext context}) {
    userAuthenticationProvider
        .otpLogin(mobileNo: mobileNo, password: password)
        .then((userService) {
      Get.back();
      if (userService.firstName != '') {
        SharedPreferencesClass.setUserData(
            userLoginData: UserLoginData(
                firstName: userService.firstName,
                phoneNumber: userService.phoneNumber,
                token: userService.token));
        userAuthenticationProvider.getUserBasicInfo(phoneNumber:userService.phoneNumber, token: userService.token ).then((value) {
          SharedPreferencesClass.setUserBasicInfo(userBasicInfo: value);
        });

        isButtonEnabled.value = false;
        Get.offNamed('/home')!.then((value) {
          clearLoginTextFieldData();
        });
      } else {
        Utils.snackBar(
            context: context,
            msg: translation.loginInfoIncorrect.tr,
            background: ColorConstants.redColor,
            textColor: Colors.white);
      }
    });
  }

  void recoverPasswordOtp(
      {required String password,
      required String mobileNo,
      required String otp,
      required BuildContext context}) {
    userAuthenticationProvider
        .recoverPasswordOtp(password: password, mobile: mobileNo, otp: otp)
        .then((value) {
      Get.back();
      if (value['isSuccess'] == true) {
        Utils.snackBar(
            context: context,
            msg: Utils.getTranslatedText(
                arText: value['message'], enText: value['enmessage']),
            background: ColorConstants.greenColor,
            textColor: Colors.white);
        Get.offAllNamed('/login');
      } else {
        Utils.snackBar(
            context: context,
            msg: Utils.getTranslatedText(
                arText: value['message'], enText: value['enmessage']),
            background: ColorConstants.redColor,
            textColor: Colors.white);
      }
    });
  }

  void recoverPassword(
      {required String password,
      required String mobileNo,
      required BuildContext context}) {
    userAuthenticationProvider
        .recoverPassword(password: password, mobile: mobileNo)
        .then((value) {
      Get.back();
      if (value['isSuccess'] == true) {
        isButtonEnabled.value = false;
        clearRecoveryTextFieldData();
        Get.to(() => OTPVerifyScreen(
              data: {'mobileNo': mobileNo, 'password': password},
              routeName: 'recover',
            ));
      } else {
        Utils.snackBar(
            context: context,
            msg: translation.verifyDataText.tr,
            background: ColorConstants.redColor,
            textColor: Colors.white);
      }
    });
  }

  void register(
      {required String mobileNo,
      required String firstName,
      required String password,
      required BuildContext context}) {
    userAuthenticationProvider
        .register(
      mobileNo: mobileNo,
      password: password,
      firstName: firstName,
    )
        .then((value) {
      Get.back();
      if (value['isAuthenticated'] == true) {
        isButtonEnabled.value = false;
        Get.to(() => OTPVerifyScreen(
              data: {
                'mobileNo': mobileNo,
                'password': password,
                'firstName': firstName
              },
              routeName: 'register',
            ));
        clearRegisterTextFieldData();
      } else {
        Utils.snackBar(
            context: context,
            msg: value['message'],
            background: ColorConstants.yellowColor,
            textColor: ColorConstants.black0);
      }
    });
  }

  void registerOtp({
    required String mobileNo,
    required String firstName,
    required String password,
    required BuildContext context,
    required String otpCode,
  }) {
    userAuthenticationProvider
        .registerOtp(
            mobileNo: mobileNo,
            firstName: firstName,
            password: password,
            otpCode: otpCode)
        .then((value) {
      if (value['isAuthenticated'] == true) {
        otpController.value = '';
        Utils.snackBar(
            context: context,
            msg: translation.accountCreatedSuccessfully.tr,
            background: ColorConstants.greenColor,
            textColor: Colors.white);
        Get.offAllNamed('/login');
      } else {
        Get.back();
        Utils.snackBar(
            context: context,
            msg: translation.codeEnteredIncorrect.tr,
            background: ColorConstants.redColor,
            textColor: Colors.white);
      }
    });
  }

  //////////// User Wallet /////////

  Future<WalletModel> getUserWallet(){
    return userAuthenticationProvider.getUserWallet().then((wallet) {
      walletHistories.value = wallet.walletHistory
          .map((walletHistory) => WalletHistoryModel.fromJson(walletHistory))
          .toList();

      return userWallet.value = wallet;
    });
  }

  getUserIncomeWallet(){
      walletHistories.value = userWallet.value.walletHistory.where((walletHistory) => walletHistory['money'] > 0)
          .map((walletHistory) => WalletHistoryModel.fromJson(walletHistory))
          .toList();
  }

  getUserSpendingWallet(){
      walletHistories.value = userWallet.value.walletHistory.where((walletHistory) => walletHistory['money'] < 0)
          .map((walletHistory) =>WalletHistoryModel.fromJson(walletHistory))
          .toList();
  }

  var incomePrice = 0.0.obs;
  double getIncomePrice(){
    incomePrice.value = 0.0;
    userWallet.value.walletHistory.forEach((walletHistory){
      final WalletHistoryModel walletHistoryModel = WalletHistoryModel.fromJson(walletHistory);
      if(walletHistoryModel.money > 0){
        incomePrice.value += walletHistoryModel.money;
      }
      });
    return incomePrice.value;
  }

  var spendingPrice = 0.0.obs;
  double getSpendingPrice(){
    spendingPrice.value = 0.0;
    userWallet.value.walletHistory.forEach((walletHistory){
      final WalletHistoryModel walletHistoryModel = WalletHistoryModel.fromJson(walletHistory);
      if(walletHistoryModel.money < 0){
        spendingPrice.value += walletHistoryModel.money;
      }
    });
    return spendingPrice.value;
  }

  setBtnNameAndNum({required String name, required int number}){
    btnName.value = name;
    num.value = number;
    update();
  }
}
