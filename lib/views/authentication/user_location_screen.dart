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
    Controllers.directionalityController.languageBox.value
        .write('language', languageBox.read('language') == 'ar' ? 'ar' : 'en');
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Utils.setSystemOverlayForSplash();
    return Scaffold(
      backgroundColor: Get.isDarkMode
          ? ColorConstants.darkMainColor
          : ColorConstants.mainColor,
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splash_screen.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.cover,
            // color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.only(
              // top: MediaQuery.of(context).size.height * 0.1,
              left: 12,
              right: 12,
            ),
            child: Align(
              alignment: Alignment.topCenter,
              child: ScrollConfiguration(
                behavior: const ScrollBehavior(),
                child: GlowingOverscrollIndicator(
                  axisDirection: AxisDirection.down,
                  color: ColorConstants.mainColor,
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.087,
                          ),
                          Image.asset(
                            'assets/images/mizaaLogo.png',
                            height: MediaQuery.of(context).size.height * 0.2,
                            fit: BoxFit.cover,
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.008,
                          ),
                          Text(
                            translation.userLocationScreenHeader.tr,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.018,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildDropHeader(text: translation.language.tr),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.008,
                              ),
                              Obx(
                                () => Utils.drawDropDownListStringsBtn(
                                  leftPadding: 20,
                                  rightPadding: 20,
                                  optionName: translation.language.tr,
                                  dropDownValue: Controllers
                                      .directionalityController
                                      .dropLanguageData
                                      .value,
                                  onChanged: (value) {
                                    Controllers.directionalityController
                                        .dropLanguageData.value = value;

                                    if (Controllers.directionalityController
                                            .dropLanguageData.value ==
                                        'العربية') {
                                      Controllers.directionalityController
                                          .changeLanguage('ar');
                                    } else if (Controllers
                                            .directionalityController
                                            .dropLanguageData
                                            .value ==
                                        'English') {
                                      Controllers.directionalityController
                                          .changeLanguage('en');
                                    }

                                    Utils.updatePadding();

                                    SharedPreferencesClass.setUserLanguageCode(
                                      language: (Controllers
                                                  .directionalityController
                                                  .dropLanguageData
                                                  .value ==
                                              'العربية')
                                          ? 'ar'
                                          : 'en',
                                    );
                                    SharedPreferencesClass.setUserLanguageName(
                                      language: Controllers
                                          .directionalityController
                                          .dropLanguageData
                                          .value,
                                    );

                                    Controllers.directionalityController
                                        .dropCountryData.value = '';
                                    Controllers.directionalityController
                                        .dropCityData.value = '';
                                  },
                                  menu: [
                                    'العربية',
                                    'English',
                                  ],
                                  context: context,
                                  iconSize: 34,
                                  containerBorderColor: Colors.white,
                                  containerColor: Colors.white,
                                  optionNameColor: ColorConstants.mainColor,
                                  textColor: ColorConstants.mainColor,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.018,
                              ),
                              _buildDropHeader(
                                  text: translation.selectCountry.tr),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.008,
                              ),
                              Obx(
                                () => Utils.drawDropDownListCountriesBtn(
                                  optionName: translation.selectCountry.tr,
                                  dropDownValue: Controllers
                                      .directionalityController
                                      .dropCountryData
                                      .value,
                                  onChanged: (country) {
                                    Controllers
                                        .directionalityController
                                        .dropCountryData
                                        .value = Utils.getTranslatedText(
                                      arText: country.arName,
                                      enText: country.enName,
                                    );

                                    SharedPreferencesClass.setUserCountryId(
                                      countryId: country.id.toString(),
                                    );

                                    Controllers.userAuthenticationController
                                        .getCities(
                                      countryId: country.id.toString(),
                                    );

                                    Controllers.directionalityController
                                        .dropCityData.value = "";
                                    SharedPreferencesClass.setUserCity(
                                      cityId: '',
                                    );
                                  },
                                  menu: Controllers
                                      .directionalityController.countries,
                                  context: context,
                                  iconSize: 34,
                                  containerBorderColor: Colors.white,
                                  textColor: ColorConstants.mainColor,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.018,
                              ),
                              _buildDropHeader(text: translation.selectCity.tr),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.008,
                              ),
                              Obx(
                                () => Utils.drawDropDownListCitiesBtn(
                                  optionName: translation.selectCity.tr,
                                  dropDownValue: Controllers
                                      .directionalityController
                                      .dropCityData
                                      .value,
                                  onChanged: (city) {
                                    Controllers
                                        .directionalityController
                                        .dropCityData
                                        .value = Utils.getTranslatedText(
                                      arText: city.arName,
                                      enText: city.enName,
                                    );

                                    SharedPreferencesClass.setUserCity(
                                      cityId: city.id.toString(),
                                    );
                                  },
                                  menu: Controllers
                                      .directionalityController.cities,
                                  context: context,
                                  iconSize: 34,
                                  containerBorderColor: Colors.white,
                                  textColor: ColorConstants.mainColor,
                                ),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.050,
                              ),
                              CustomButton(
                                btnText: translation.userLocationScreenBtn.tr,
                                textColor: ColorConstants.mainColor,
                                textSize: 17,
                                btnBackgroundColor: Colors.white,
                                btnOnpressed: () {
                                  print(
                                      'user loc ${SharedPreferencesClass.getLanguageCode()} ${SharedPreferencesClass.getCountryId()}  ${SharedPreferencesClass.getCityId()}');
                                  if (SharedPreferencesClass.getCountryId() !=
                                          null &&
                                      SharedPreferencesClass.getCountryId() !=
                                          '' &&
                                      SharedPreferencesClass.getCityId() !=
                                          '' &&
                                      SharedPreferencesClass.getCityId() !=
                                          null) {
                                    if (Controllers.directionalityController
                                            .dropLanguageData.value ==
                                        'العربية') {
                                      Controllers.directionalityController
                                          .changeLanguage('ar');
                                    } else if (Controllers
                                            .directionalityController
                                            .dropLanguageData
                                            .value ==
                                        'English') {
                                      print('english');
                                      Controllers.directionalityController
                                          .changeLanguage('en');
                                    }

                                    Utils.updatePadding();
                                    Get.offAllNamed('/login')!.then((value) {
                                      Utils.setSystemOverlayForAuthentication();
                                    });
                                  } else {
                                    Utils.snackBar(
                                      context: context,
                                      textColor: Colors.white,
                                      background: ColorConstants.redColor,
                                      msg: translation.completeDataText.tr,
                                    );
                                  }
                                },
                              ),
                            ],
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                ),
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
