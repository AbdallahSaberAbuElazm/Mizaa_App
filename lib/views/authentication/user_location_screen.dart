import 'package:flutter/material.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/main.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class UserLocationScreen extends StatefulWidget {
  UserLocationScreen({Key? key}) : super(key: key);

  @override
  State<UserLocationScreen> createState() => _UserLocationScreenState();
}

class _UserLocationScreenState extends State<UserLocationScreen> {


  @override
  void initState() {
    Controllers.directionalityController.dropLanguageData.value =
        languageBox.read('language') == 'en' ? 'English' : 'العربية';
    print('user location language is ${languageBox.read('language')}');
    Controllers
        .directionalityController.languageBox.value
        .write('language',languageBox.read('language') == 'ar' ?'ar':'en');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Get.isDarkMode? ColorConstants.darkMainColor : ColorConstants.mainColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash_screen.png',
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 88, left: 16, right: 16),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/mizaaLogo.png',
                    height: 140,
                    fit: BoxFit.cover,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    translation.userLocationScreenHeader.tr,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold),
                  ),
                  // Stack(
                  //   children: [
                  const SizedBox(
                    height: 45,
                  ),

                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildDropHeader(text: translation.language.tr),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => Utils.drawDropDownListStringsBtn(
                          optionName: translation.language.tr,
                          dropDownValue: Controllers
                              .directionalityController.dropLanguageData.value,
                          onChanged: (value) {
                            Controllers.directionalityController
                                .dropLanguageData.value = value;

                            if (Controllers.directionalityController
                                    .dropLanguageData.value ==
                                'العربية') {
                              Controllers.directionalityController
                                  .changeLanguage('ar');
                            } else if (Controllers.directionalityController
                                    .dropLanguageData.value ==
                                'English') {
                              Controllers.directionalityController
                                  .changeLanguage('en');
                            }

                            Utils.updatePadding();

                            SharedPreferencesClass.setUserLanguageCode(
                                language: (Controllers.directionalityController
                                            .dropLanguageData.value ==
                                        'العربية')
                                    ? 'ar'
                                    : 'en');
                            SharedPreferencesClass.setUserLanguageName(
                                language: Controllers.directionalityController
                                    .dropLanguageData.value);

                            Controllers.directionalityController.dropCountryData
                                .value = '';
                            Controllers.directionalityController.dropCityData
                                .value = '';
                          },
                          menu: [
                            'العربية',
                            'English',
                          ],
                          context: context,
                          iconSize: 34,
                          containerBorderColor: Colors.white,
                          textColor: ColorConstants.mainColor)),
                      const SizedBox(
                        height: 14,
                      ),
                      _buildDropHeader(text: translation.selectCountry.tr),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(() => Utils.drawDropDownListCountriesBtn(
                          optionName: translation.selectCountry.tr,
                          dropDownValue: Controllers
                              .directionalityController.dropCountryData.value,
                          onChanged: (country) {
                            Controllers.directionalityController.dropCountryData
                                    .value =
                                Utils.getTranslatedText(
                                    arText: country.arName,
                                    enText: country.enName);

                            // setState(() {
                            SharedPreferencesClass.setUserCountryId(
                                countryId: country.id.toString());
                            // });

                            Controllers.userAuthenticationController
                                .getCities(countryId: country.id.toString());

                            Controllers.directionalityController.dropCityData
                                .value = "";
                          },
                          menu: Controllers.directionalityController.countries,
                          context: context,
                          iconSize: 34,
                          containerBorderColor: Colors.white,
                          textColor: ColorConstants.mainColor)),
                      const SizedBox(
                        height: 14,
                      ),
                      _buildDropHeader(text: translation.selectCity.tr),
                      const SizedBox(
                        height: 8,
                      ),
                      Obx(
                        () => Utils.drawDropDownListCitiesBtn(
                            optionName: translation.selectCity.tr,
                            dropDownValue: Controllers
                                .directionalityController.dropCityData.value,
                            onChanged: (city) {
                              Controllers.directionalityController.dropCityData
                                      .value =
                                  Utils.getTranslatedText(
                                      arText: city.arName, enText: city.enName);

                              // setState(() {
                              SharedPreferencesClass.setUserCity(
                                  cityId: city.id.toString());
                              // });
                            },
                            menu: Controllers.directionalityController.cities,
                            context: context,
                            iconSize: 34,
                            containerBorderColor: Colors.white,
                            textColor: ColorConstants.mainColor),
                      ),
                      const SizedBox(
                        height: 45,
                      ),
             CustomButton(
                          btnText: translation.userLocationScreenBtn.tr,
                          textColor: ColorConstants.mainColor,
                          textSize: 17,
                          btnBackgroundColor: Colors.white,
                          btnOnpressed: () {
                            print(
                                'user loc ${SharedPreferencesClass.getLanguageCode()} ${SharedPreferencesClass.getCountryId()}  ${SharedPreferencesClass.getCityId()}');
                            if (SharedPreferencesClass.getCountryId() != null &&
                                SharedPreferencesClass.getCityId() != null) {
                              if (Controllers
                                  .directionalityController.dropLanguageData.value ==
                                  'العربية') {
                                Controllers.directionalityController.changeLanguage('ar');
                              } else if (Controllers
                                  .directionalityController.dropLanguageData.value ==
                                  'English') {
                                print('english');
                                Controllers.directionalityController.changeLanguage('en');
                              }

                                Utils.updatePadding();
                              Get.offAllNamed('/login');
                            } else {
                              Utils.snackBar(
                                  context: context,
                                  textColor: Colors.white,
                                  background: ColorConstants.redColor,
                                  msg: translation.completeDataText.tr, );
                            }
                          }),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropHeader({required String text}) {
    return Text(
      text,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 17,
        fontWeight: FontWeight.w500,
        fontFamily: 'Noto Kufi Arabic',
      ),
    );
  }
}
