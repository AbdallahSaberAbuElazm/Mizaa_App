

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:test_ecommerce_app/models/location/city/CityModel.dart';
import 'package:test_ecommerce_app/models/location/country/CountryModel.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';

class DirectionalityController extends GetxController{

  final direction = TextDirection.rtl.obs;

  final languageBox = GetStorage().obs;

  final dropLanguageData = ''.obs;
  final  dropCountryData = ''.obs;
  final countryId = ''.obs;
  final dropCityData = ''.obs;
  final cityId = ''.obs;

  final countries = <CountryModel>[].obs;
  final cities = <CityModel>[].obs;


  // Is password and confirm password  matched
  final isPasswordAndConfirmPasswordMatched = false.obs;

  @override
  onInit(){
    super.onInit();
  }

  void changeLanguage(String languageCode) {
    late Locale locale;
    if (languageCode == 'en') {
      locale = Locale('en');
    } else if(languageCode == 'ar'){
      locale = Locale('ar');
    }

    Get.updateLocale(locale);
    languageBox.value.write('language', languageCode);
  }


  updateCountries({required  List<CountryModel> countriesData}){
    countries.value = countriesData;
    update();
  }

  updateCities({required  List<CityModel> citiesData}){
    cities.value = citiesData;
    update();
  }

  //
  // TextDirection getDirection(String languageCode) {
  //   switch (languageCode) {
  //     case 'ar':
  //       return TextDirection.rtl; // Right-to-left for Arabic
  //     default:
  //       return TextDirection.ltr; // Left-to-right for other languages
  //   }
  // }
  //
  // TextAlign getTextAlign(String languageCode) {
  //   switch (languageCode) {
  //     case 'ar':
  //       return TextAlign.right; // Right alignment for Arabic
  //     default:
  //       return TextAlign.left; // Left alignment for other languages
  //   }
  // }
}