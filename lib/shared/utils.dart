import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/models/location/city/CityModel.dart';
import 'package:mizaa/models/location/country/CountryModel.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mizaa/views/offer/nearest_offer.dart';
import 'package:mizaa/views/widgets/custom_button.dart';
import 'package:intl/intl.dart' as intl;
import 'package:geolocator/geolocator.dart';

enum ComingForCart { homPage, offerListCategory, offerDetail }

class Utils {
  static snackBar(
      {required BuildContext context,
      required String? msg,
      required Color background,
      required Color textColor}) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(milliseconds: 2300),
      padding: const EdgeInsets.all(16),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(16),
      content: Container(
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20))),
        child: Text(
          msg!,
          style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontFamily: 'Noto Kufi Arabic',
              fontWeight: FontWeight.w400),
        ),
      ),
      backgroundColor: background,
    ));
  }

  /////////// login / register alert dialog //////

  static showAlertDialogForRegisterLogin({required BuildContext context}) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Container(
              height: 60,
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 16,
              ),
              child: SizedBox(
                height: 60,
                child: CustomButton(
                    btnText: Utils.getTranslatedText(
                        arText: 'تسجيل الدخول', enText: "Login "),
                    textSize: 15,
                    textColor: Get.isDarkMode
                        ? ColorConstants.bottomAppBarDarkColor
                        : Colors.white,
                    btnBackgroundColor: ColorConstants.mainColor,
                    btnOnpressed: () {
                      Get.offAllNamed('/login');
                    }),
              ),
            ),
          );
        });
  }

  ///////////// App bar ////////////////////

  static Widget buildLeadingAppBar({required String title}) {
    return Padding(
      padding: EdgeInsets.only(
          right: Utils.rightPadding12Right, left: Utils.leftPadding12Left),
      child: GestureDetector(
        onTap: () {
          Get.back();
        },
        child: Row(
          children: [
            Container(
              width: 37,
              height: 37,
              decoration: const BoxDecoration(
                color: ColorConstants.mainColor,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 20,
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontFamily: 'Noto Kufi Arabic',
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  /////////////// Ratings ///////////////
  static Widget buildRatings(
      {required double ratings,
      required double iconSize,
      required Color unratedColor}) {
    return RatingBar.builder(
      initialRating: ratings,
      minRating: 1,
      direction: Axis.horizontal,
      allowHalfRating: true,
      ignoreGestures: true,
      itemSize: iconSize,
      unratedColor: unratedColor,
      itemCount: 5,
      itemPadding: const EdgeInsets.symmetric(horizontal: 0.5),
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: ColorConstants.mainColor,
      ),
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }

  /////////// categories images
  static List<String> categoryImageIcon = [
    'assets/images/outings.png',
    'assets/images/eats_drinks.png',
    'assets/images/entertainment.png',
    'assets/images/services.png',
  ];

  ////////////////////// System overlay /////////////
  static setSystemOverlayForAuthentication() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Get.isDarkMode
            ? ColorConstants.darkMainColor
            : Colors.white, // navigation bar color
        systemNavigationBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarColor:
            Get.isDarkMode ? ColorConstants.darkMainColor : Colors.white,
        statusBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
  }

  static setSystemOverlayForSplash() {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Get.isDarkMode
            ? ColorConstants.darkMainColor
            : ColorConstants.mainColor, // navigation bar color
        systemNavigationBarIconBrightness: Brightness.light,
        statusBarColor: Get.isDarkMode
            ? ColorConstants.darkMainColor
            : ColorConstants.mainColor,
        statusBarIconBrightness: Brightness.light,
      ),
    );
  }

  //////////////////////////////////////

  // padding left and right based on directionality
  static double leftPadding12Left =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0.0
          : 12.0;
  static double rightPadding12Right =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 12.0
          : 0.0;

  static double leftPadding10Left =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0
          : 10;

  static double rightPadding10Right =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 10
          : 0;

  static double leftPadding12Right =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 12.0
          : 0.0;
  static double rightPadding12Left =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0.0
          : 12.0;

  static double leftPadding10FromLeft =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 10.0
          : 0.0;
  static double rightPadding10FromRight =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0.0
          : 10.0;

  static double leftPadding10FromRight =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0.0
          : 10.0;
  static double rightPadding10FromLeft =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 10.0
          : 0.0;

  static double leftPadding8FromLeft =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 8.0
          : 0.0;
  static double rightPadding8FromRight =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0.0
          : 8.0;

  static double leftPadding8FromRight =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0.0
          : 8.0;
  static double rightPadding8FromLeft =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 8.0
          : 0.0;

  static double leftPadding4FromLeft =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 4.0
          : 0.0;
  static double rightPadding4FromRight =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0.0
          : 4.0;

  static double leftPadding4FromRight =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 0.0
          : 4.0;
  static double rightPadding4FromLeft =
      Controllers.directionalityController.languageBox.value.read('language') ==
              'ar'
          ? 4.0
          : 0.0;

  static void updatePadding() {
    leftPadding12Left = Controllers.directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 0.0
        : 16.0;
    rightPadding12Right = Controllers.directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 16.0
        : 0.0;

    leftPadding10FromLeft = Controllers
                .directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 8.0
        : 0.0;
    rightPadding10FromRight = Controllers
                .directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 0.0
        : 8.0;

    leftPadding10FromRight = Controllers
                .directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 0.0
        : 8.0;
    rightPadding10FromLeft = Controllers
                .directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 8.0
        : 0.0;

    leftPadding4FromLeft = Controllers
                .directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 4.0
        : 0.0;
    rightPadding4FromRight = Controllers
                .directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 0.0
        : 4.0;

    leftPadding4FromRight = Controllers
                .directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 0.0
        : 4.0;
    rightPadding4FromLeft = Controllers
                .directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? 4.0
        : 0.0;
  }

  static String getTranslatedText(
      {required String arText, required String enText}) {
    return Controllers.directionalityController.languageBox.value
                .read('language') ==
            'ar'
        ? arText
        : enText;
  }

  ////////////////////////////////////////////////

  static String getMonthName({required DateTime dateTime}) {
    return intl.DateFormat(
            'MMMM',
            Controllers.directionalityController.languageBox.value
                .read('language'))
        .format(dateTime);
  }

  static String getDateTime({required DateTime dateTime}) {
    return '${dateTime.year}-${dateTime.month}-${dateTime.day}';
  }

  static Widget buildLogo() {
    return Center(
        child: Image.asset(
      'assets/images/mizaa_logo_dark.png',
      height: 65,
      fit: BoxFit.cover,
    ));
  }

  //////////////////////////////////////////////
  // handle location premission
  static Future<bool> handleLocationPermission(
      {required BuildContext context}) async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      //     content: Text('Location services are disabled. Please enable the services')));
      // return false;
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     const SnackBar(content: Text('Location permissions are denied')));
        snackBar(
            context: context,
            msg: 'Location permissions are denied',
            background: ColorConstants.yellowColor,
            textColor: ColorConstants.black0);
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      snackBar(
          context: context,
          msg:
              'Location permissions are permanently denied, we cannot request permissions.',
          background: ColorConstants.yellowColor,
          textColor: ColorConstants.black0);
      return false;
    }
    return true;
  }

  ////// get current position for longitude and latitude
  static Future<void> getCurrentPosition(
      {required BuildContext context}) async {
    final hasPermission = await handleLocationPermission(context: context);
    if (!hasPermission) return;
    showDialog(
        context: context,
        builder: (context) => const Center(
                child: CircularProgressIndicator(
              color: ColorConstants.mainColor,
            )));
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      // currentPosition = position;
      Controllers.homeController.userPositionLongitude.value =
          position.longitude.toString();
      Controllers.homeController.userPositionLatitude.value =
          position.latitude.toString();

      Controllers.homeController.getNearestOffers(
          latitude: position.latitude, longitude: position.longitude);
    }).catchError((e) {
      print('exception is ${e.toString()}');
    });
  }

  //////////////////////////////////////////////
  // // localization
  static TextDirection direction = getDirection(
      (SharedPreferencesClass.getLanguageCode() == null ||
              SharedPreferencesClass.getLanguageCode() == '')
          ? 'ar'
          : SharedPreferencesClass.getLanguageCode().toString());
  static TextAlign textAlign =
      getTextAlign(SharedPreferencesClass.getLanguageCode().toString());

  static TextDirection getDirection(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return TextDirection.rtl; // Right-to-left for Arabic
      default:
        return TextDirection.ltr; // Left-to-right for other languages
    }
  }

  static TextAlign getTextAlign(String languageCode) {
    switch (languageCode) {
      case 'ar':
        return TextAlign.right; // Right alignment for Arabic
      default:
        return TextAlign.left; // Left alignment for other languages
    }
  }

  ////////////////////////////////////////////////
  static Widget drawDropDownListStringsBtn(
      {required double leftPadding,
      required double rightPadding,
      required String optionName,
      required String dropDownValue,
      required dynamic onChanged,
      required List menu,
      required BuildContext context,
      required double iconSize,
      required Color containerColor,
      required Color containerBorderColor,
      required Color optionNameColor,
      required Color textColor}) {
    return DropdownButtonHideUnderline(
      child: Container(
        height: 54,
        padding: EdgeInsets.only(left: leftPadding, right: rightPadding),
        decoration: BoxDecoration(
            color: containerColor,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1.2, color: containerBorderColor)),
        child: DropdownButton(
            dropdownColor: Colors.white,
            // borderRadius: BorderRadius.circular(5),
            hint: dropDownValue.isEmpty
                ? Text(
                    optionName,
                    style: TextStyle(
                      color: optionNameColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  )
                : Text(
                    dropDownValue,
                    style: TextStyle(
                        color: optionNameColor,
                        fontFamily: 'Noto Kufi Arabic',
                        fontWeight: FontWeight.w600),
                  ),
            isExpanded: true,
            iconSize: iconSize,
            iconDisabledColor: ColorConstants.mainColor,
            iconEnabledColor: ColorConstants.mainColor,
            // alignment: Alignment.center,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Noto Kufi Arabic',
            ),
            items: menu.map(
              (val) {
                return DropdownMenuItem<String>(
                  alignment: Alignment.topRight,
                  value: val,
                  child: Text(
                    val,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: onChanged),
      ),
    );
  }

  static Widget drawDropDownListCountriesBtn(
      {required String optionName,
      required String dropDownValue,
      required dynamic onChanged,
      required List<CountryModel> menu,
      required BuildContext context,
      required double iconSize,
      required Color containerBorderColor,
      required Color textColor}) {
    return Container(
      height: 54,
      padding: const EdgeInsets.only(left: 20, right: 20),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
          border: Border.all(width: 1.2, color: containerBorderColor)),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<CountryModel>(
          dropdownColor: Colors.white,
          // borderRadius: BorderRadius.circular(5),
          hint: dropDownValue.isEmpty
              ? Text(
                  optionName,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                )
              : Text(
                  dropDownValue,
                  style: TextStyle(
                      color: textColor,
                      fontFamily: 'Noto Kufi Arabic',
                      fontWeight: FontWeight.w600),
                ),
          isExpanded: true,
          onChanged: onChanged,
          iconSize: iconSize, iconDisabledColor: ColorConstants.mainColor,
          iconEnabledColor: ColorConstants.mainColor,
          // alignment: Alignment.center,
          style: TextStyle(
            color: textColor,
            fontFamily: 'Noto Kufi Arabic',
          ),
          items: menu.map<DropdownMenuItem<CountryModel>>(
            (CountryModel country) {
              return DropdownMenuItem<CountryModel>(
                alignment: Controllers
                            .directionalityController.languageBox.value
                            .read('language') ==
                        'ar'
                    ? Alignment.topRight
                    : Alignment.topLeft,
                value: country,
                child: Text(
                  Controllers.directionalityController.languageBox.value
                              .read('language') ==
                          'ar'
                      ? country.arName
                      : country.enName,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    color: textColor,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }

  static Widget drawDropDownListCountriesWithFlagBtn({
    required String optionName,
    required String dropDownValue,
    required dynamic onChanged,
    required List<CountryModel> menu,
    required BuildContext context,
    required double iconSize,
  }) {
    return DropdownButtonHideUnderline(
      child: SizedBox(
        height: 38,
        child: DropdownButton<CountryModel>(
            dropdownColor: Colors.white,
            // borderRadius: BorderRadius.circular(5),
            hint: dropDownValue.isEmpty
                ? Text(
                    optionName,
                    style: const TextStyle(
                      color: ColorConstants.mainColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  )
                : Text(
                    dropDownValue,
                    style: const TextStyle(
                        color: ColorConstants.mainColor,
                        fontFamily: 'Noto Kufi Arabic',
                        fontWeight: FontWeight.w600),
                  ),
            isExpanded: true,
            iconSize: iconSize,
            iconDisabledColor: ColorConstants.mainColor,
            iconEnabledColor: ColorConstants.mainColor,

            // alignment: Alignment.center,
            style: const TextStyle(
              color: ColorConstants.mainColor,
              fontFamily: 'Noto Kufi Arabic',
            ),
            items: menu.map<DropdownMenuItem<CountryModel>>(
              (CountryModel country) {
                return DropdownMenuItem<CountryModel>(
                  alignment: Alignment.topRight,
                  value: country,
                  child: Text(
                    generateCountryFlag(countryCode: country.shortName),
                    textAlign: TextAlign.end,
                    style: const TextStyle(
                      color: ColorConstants.mainColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: onChanged),
      ),
    );
  }

  static String generateCountryFlag({required String countryCode}) {
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }

  static Widget drawDropDownListCitiesBtn(
      {required String optionName,
      required String dropDownValue,
      required dynamic onChanged,
      required List<CityModel> menu,
      required BuildContext context,
      required double iconSize,
      required Color containerBorderColor,
      required Color textColor}) {
    return DropdownButtonHideUnderline(
      child: Container(
        height: 54,
        padding: const EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1.2, color: containerBorderColor)),
        child: DropdownButton<CityModel>(
            dropdownColor: Colors.white,
            // borderRadius: BorderRadius.circular(5),
            hint: dropDownValue.isEmpty
                ? Text(
                    optionName,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  )
                : Text(
                    dropDownValue,
                    style: TextStyle(
                        color: textColor,
                        fontFamily: 'Noto Kufi Arabic',
                        fontWeight: FontWeight.w600),
                  ),
            isExpanded: true,
            iconSize: iconSize,
            // iconDisabledColor: textColor,
            iconDisabledColor: ColorConstants.mainColor,
            iconEnabledColor: ColorConstants.mainColor,
            style: TextStyle(
              color: textColor,
              fontFamily: 'Noto Kufi Arabic',
            ),
            items: menu.map<DropdownMenuItem<CityModel>>(
              (CityModel city) {
                return DropdownMenuItem<CityModel>(
                  alignment: Controllers
                              .directionalityController.languageBox.value
                              .read('language') ==
                          'ar'
                      ? Alignment.topRight
                      : Alignment.topLeft,
                  value: city,
                  child: Text(
                    Controllers.directionalityController.languageBox.value
                                .read('language') ==
                            'ar'
                        ? city.arName
                        : city.enName,
                    textAlign: TextAlign.end,
                    style: TextStyle(
                      color: textColor,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  ),
                );
              },
            ).toList(),
            onChanged: onChanged),
      ),
    );
  }
}
