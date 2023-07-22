import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/user/user_authentication_controller.dart';
import 'package:mizaa/models/location/city/CityModel.dart';
import 'package:mizaa/models/location/country/CountryModel.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:get/get.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/views/widgets/arrow_back.dart';
import 'package:mizaa/views/widgets/custom_button.dart';
import 'package:mizaa/views/widgets/custom_text_form_field.dart';
import 'package:mizaa/views/widgets/phone_number_field.dart';

class EditProfileScreen extends GetView<UserAuthenticationController> {
  EditProfileScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.firstNameController.text =
        SharedPreferencesClass.getFirstName().toString();
    controller.phoneNumberController.text =
        SharedPreferencesClass.getPhoneNumber().toString();

    return Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Get.isDarkMode
              ? ColorConstants.bottomAppBarDarkColor
              : Colors.white,
          flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarIconBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
                statusBarBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
                statusBarColor: Get.isDarkMode
                    ? ColorConstants.bottomAppBarDarkColor
                    : Colors.white,
                systemNavigationBarColor: Get.isDarkMode
                    ? ColorConstants.darkMainColor
                    : Colors.white, // navigation bar color
                systemNavigationBarIconBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
              ),
              child: Container()),
          // backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          leadingWidth: double.infinity,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: ArrowBack(
              onTap: () {
                Get.back();
              },
              text: translation.updateData.tr,
            ),
          ),
        ),
        floatingActionButton: const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: Form(
          key: _formKey,
          child: Container(
            alignment: Alignment.topRight,
            margin: const EdgeInsets.symmetric(horizontal: 12),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 25),
                CustomTextFormField(
                    name: translation.username.tr,
                    type: TextInputType.name,
                    controller: controller.firstNameController,
                    lines: 1),
                const SizedBox(height: 25),
                CustomTextFormField(
                    name: translation.email.tr,
                    type: TextInputType.emailAddress,
                    controller: controller.emailController,
                    lines: 1),
                const SizedBox(height: 25),
                PhoneNumberField(
                    controller: controller.phoneNumberController,
                    countries: controller.countries,
                    headerName: translation.phoneNumber.tr),
                const SizedBox(height: 5),

                // select date
                _buildDateOfBirth(context: context),

                const SizedBox(height: 25),
                // select country - city
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 18,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    translation.selectCountry.tr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : ColorConstants.black0,
                                        height: 1,
                                        fontFamily: 'Noto Kufi Arabic',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => drawDropDownListCountriesBtn(
                                    optionName: translation.selectCountry.tr,
                                    dropDownValue:
                                        controller.countryController.value,
                                    onChanged: (country) {
                                      controller.countryController.value =
                                          Utils.getTranslatedText(
                                              arText: country.arName,
                                              enText: country.enName);

                                      Controllers.userAuthenticationController
                                          .getCitiesForSelectedCountry(
                                              countryId: country.id.toString());

                                      controller.cityIdController.value = -1;
                                      controller.cityController.value = '';
                                      controller.countryIdController.value =
                                          country.id;
                                    },
                                    menu: Controllers
                                        .directionalityController.countries,
                                    context: context,
                                    iconSize: 34,
                                    containerBorderColor:
                                        ColorConstants.greyColor,
                                    textColor: ColorConstants.black0),
                              )
                            ])),
                    const SizedBox(
                      width: 12,
                    ),
                    SizedBox(
                        width: MediaQuery.of(context).size.width / 2 - 18,
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    translation.selectCity.tr,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : ColorConstants.black0,
                                        height: 1,
                                        fontFamily: 'Noto Kufi Arabic',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Obx(
                                () => drawDropDownListCitiesBtn(
                                    optionName: translation.selectCity.tr,
                                    dropDownValue:
                                        controller.cityController.value,
                                    onChanged: (city) {
                                      controller.cityController.value =
                                          Utils.getTranslatedText(
                                              arText: city.arName,
                                              enText: city.enName);

                                      controller.cityIdController.value =
                                          city.id;
                                    },
                                    menu: Controllers
                                        .userAuthenticationController
                                        .citiesForSelectedCountry,
                                    context: context,
                                    iconSize: 34,
                                    containerBorderColor:
                                        ColorConstants.greyColor,
                                    textColor: ColorConstants.black0),
                              )
                            ])),
                  ],
                ),
                const SizedBox(height: 25),

                // select gender
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        translation.selectGender.tr,
                        style: TextStyle(
                            fontSize: 14,
                            color: Get.isDarkMode
                                ? Colors.white
                                : ColorConstants.black0,
                            height: 1,
                            fontFamily: 'Noto Kufi Arabic',
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Obx(() => Utils.drawDropDownListStringsBtn(
                      leftPadding: 12,
                      rightPadding: 12,
                      optionName: translation.selectGender.tr,
                      dropDownValue: controller.genderNameController.value,
                      onChanged: (gender) {
                        controller.genderNameController.value = gender;
                        if (gender == 'ذكر' || gender == 'Male') {
                          controller.genderIdController.value = 1;
                        } else {
                          controller.genderIdController.value = 2;
                        }
                      },
                      menu: [
                        translation.maleText.tr,
                        translation.femaleText.tr
                      ],
                      context: context,
                      iconSize: 24,
                      containerColor: Colors.transparent,
                      containerBorderColor: ColorConstants.greyColor,
                      optionNameColor:
                          Get.isDarkMode ? Colors.white : Colors.black,
                      textColor: ColorConstants.black0))
                ]),
                const SizedBox(height: 25),
                updateBtn(context),
                const SizedBox(height: 24),
                // loginBtn(),
              ],
            ),
          ),
        ));
  }

  Widget _buildDateOfBirth({required BuildContext context}) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            translation.dateOfBirth.tr,
            style: TextStyle(
                fontSize: 14,
                color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
                height: 1,
                fontFamily: 'Noto Kufi Arabic',
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      GestureDetector(
          onTap: () {
            _selectDate(context);
          },
          child: Stack(children: [
            Container(
                height: 54,
                width: MediaQuery.of(context).size.width,
                padding: const EdgeInsets.only(left: 12, right: 12),
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: const BorderRadius.all(Radius.circular(12)),
                    border: Border.all(
                        width: 1.2, color: ColorConstants.greyColor)),
                child: Obx(() => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          Utils.getDateTime(
                            dateTime: controller.selectedDate.value,
                          ),
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ],
                    ))),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 54,
              child: Container(
                color: Colors.transparent,
              ),
            ),
          ]))
    ]);
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: controller.selectedDate.value,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != controller.selectedDate.value) {
      controller.selectedDate.value = picked;
    }
  }

  Widget updateBtn(BuildContext context) {
    return CustomButton(
        btnText: translation.updateText.tr,
        textColor: Colors.white,
        textSize: 17,
        btnBackgroundColor: ColorConstants.mainColor,
        btnOnpressed: () async {
          if (_formKey.currentState!.validate() &&
              controller.phoneNumberController.text.isNotEmpty &&
              controller.firstNameController.text.isNotEmpty &&
              controller.emailController.text.isNotEmpty &&
              controller.selectedDate.value.isBefore(DateTime.now()) &&
              controller.genderIdController.value > 0 &&
              controller.cityIdController.value > 0 &&
              controller.countryIdController.value > 0) {
            showDialog(
                context: context,
                builder: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: ColorConstants.mainColor,
                    )));
            print('phone number is ${controller.phoneNumberController.text}');
            controller.updateUserDate(
                mobileNo: controller.phoneNumberController.text,
                name: controller.firstNameController.text,
                email: controller.emailController.text,
                dateOfBrith: controller.selectedDate.value,
                gender: controller.genderIdController.value,
                cityId: controller.cityIdController.value,
                countryId: controller.countryIdController.value,
                context: context);
          } else {
            Utils.snackBar(
                context: context,
                msg: translation.completeDataText.tr,
                background: ColorConstants.redColor,
                textColor: Colors.white);
          }
        });
  }

  Widget drawDropDownListCountriesBtn(
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
      padding: const EdgeInsets.only(left: 12, right: 12),
      decoration: BoxDecoration(
          color: Colors.transparent,
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
                    color: Get.isDarkMode ? Colors.white : Colors.black,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    fontFamily: 'Noto Kufi Arabic',
                  ),
                )
              : Text(
                  dropDownValue,
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 11,
                      fontFamily: 'Noto Kufi Arabic',
                      fontWeight: FontWeight.w600),
                ),
          isExpanded: true,
          onChanged: onChanged,
          iconSize: 24, iconDisabledColor: ColorConstants.mainColor,
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
                    fontSize: 11,
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

  Widget drawDropDownListCitiesBtn(
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
        padding: const EdgeInsets.only(left: 12, right: 12),
        decoration: BoxDecoration(
            color: Colors.transparent,
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            border: Border.all(width: 1.2, color: containerBorderColor)),
        child: DropdownButton<CityModel>(
            dropdownColor: Colors.white,
            // borderRadius: BorderRadius.circular(5),
            hint: dropDownValue.isEmpty
                ? Text(
                    optionName,
                    style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                      fontFamily: 'Noto Kufi Arabic',
                    ),
                  )
                : Text(
                    dropDownValue,
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 11,
                        fontFamily: 'Noto Kufi Arabic',
                        fontWeight: FontWeight.w600),
                  ),
            isExpanded: true,
            iconSize: 24,
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
                      fontSize: 11,
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
