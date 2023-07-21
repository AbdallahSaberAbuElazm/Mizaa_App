import 'dart:async';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final UserAuthenticationController userAuthenticationController = Get.find();
  @override
  void initState() {
    Timer(const Duration(seconds: 4), () {
      Get.offNamed(
        SharedPreferencesClass.getCountryId() == null ||
                SharedPreferencesClass.getCountryId() == '' ||
                SharedPreferencesClass.getCityId() == null ||
                SharedPreferencesClass.getCityId() == ''
            ? '/userLocationScreen'
            : SharedPreferencesClass.getPhoneNumber() == null
                ? '/login'
                : '/home',
      )!
          .then((value) {
        SharedPreferencesClass.getCountryId() == null ||
                SharedPreferencesClass.getCountryId() == '' ||
                SharedPreferencesClass.getCityId() == null ||
                SharedPreferencesClass.getCityId() == ''
            ? Utils.setSystemOverlayForSplash()
            : SharedPreferencesClass.getPhoneNumber() == null
                ? Utils.setSystemOverlayForAuthentication()
                : SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                    statusBarColor: Colors.transparent,
                    statusBarIconBrightness: Brightness.light,
                    statusBarBrightness:
                        Get.isDarkMode ? Brightness.light : Brightness.dark,
                    systemNavigationBarColor: Get.isDarkMode
                        ? ColorConstants.darkMainColor
                        : Colors.white, // navigation bar color
                    systemNavigationBarIconBrightness:
                        Get.isDarkMode ? Brightness.light : Brightness.dark,
                  ));
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils.setSystemOverlayForSplash();
    userAuthenticationController.getCountries();
    userAuthenticationController.getCities(
        countryId: (SharedPreferencesClass.getCountryId() == null ||
                SharedPreferencesClass.getCountryId() == "")
            ? '1'
            : SharedPreferencesClass.getCountryId().toString());
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? ColorConstants.darkMainColor
          : ColorConstants.mainColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash_screen.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Align(
            alignment: Alignment.center,
            child: Image.asset(
              'assets/images/mizaaLogo.png',
              height: 150,
              // color: Colors.white,
              fit: BoxFit.cover,
            ),
          )
        ],
      ),
    );
  }
}
