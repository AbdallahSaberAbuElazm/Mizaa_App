import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/models/location/country/CountryModel.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';

class PhoneNumberField extends StatefulWidget {
  final TextEditingController controller;
  final List<CountryModel> countries;
  final String headerName;
  PhoneNumberField(
      {Key? key,
      required this.controller,
      required this.countries,
      required this.headerName})
      : super(key: key);

  @override
  State<PhoneNumberField> createState() => _PhoneNumberFieldState();
}

class _PhoneNumberFieldState extends State<PhoneNumberField> {
  final UserAuthenticationController userAuthenticationController = Get.find();
  String dropDownValue = Utils.generateCountryFlag(countryCode: 'eg');
  String phoneNumber = '';

  @override
  Widget build(BuildContext context) {
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            widget.headerName,
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
      Directionality(
        textDirection: TextDirection.ltr,
        child: Container(
          width: double.infinity,
          height: 54,
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),
          decoration: BoxDecoration(
            border: Border.all(
                color: phoneNumber.length == 0
                    ? ColorConstants.greyColor
                    : phoneNumber.length ==
                            userAuthenticationController
                                .selectedCountryPhoneLength.value
                        ? ColorConstants.greyColor
                        : ColorConstants.mainColor),
            borderRadius: const BorderRadius.all(
              Radius.circular(12),
            ),
          ),
          child: Row(children: [
            Container(
                width: 60,
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
                // decoration: BoxDecoration(
                //   // border: Border.all(color: ColorConstants.greyColor),
                //   /borderRadius: const BorderRadius.only(
                //       topLeft: Radius.circular(12),
                //       bottomLeft: Radius.circular(12)),
                // ),
                child: Obx(
                  () => DropdownButtonHideUnderline(
                      child: SizedBox(
                    height: 38,
                    child: DropdownButton<CountryModel>(
                      // borderRadius: BorderRadius.circular(5),
                      hint: dropDownValue.isEmpty
                          ? const Text(
                              'الدولة',
                              style: TextStyle(
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
                      iconSize: 29,
                      iconDisabledColor: ColorConstants.mainColor,
                      iconEnabledColor: ColorConstants.mainColor,

                      // alignment: Alignment.center,
                      style: const TextStyle(
                        color: ColorConstants.mainColor,
                        fontFamily: 'Noto Kufi Arabic',
                      ),
                      items: userAuthenticationController.countries
                          .map<DropdownMenuItem<CountryModel>>(
                        (CountryModel country) {
                          return DropdownMenuItem<CountryModel>(
                            alignment: Alignment.topRight,
                            value: country,
                            child: Text(
                              generateCountryFlag(
                                  countryCode: country.shortName),
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
                      onChanged: (country) {
                        userAuthenticationController.selectedCountryPhoneCode
                            .value = country!.phoneCode.toString();
                        userAuthenticationController.selectedCountryPhoneLength
                            .value = country.mobileMaxLength;
                        setState(() {
                          dropDownValue = generateCountryFlag(
                              countryCode: country.shortName);
                        });
                      },
                    ),
                  )),
                )
                // Obx(()=>  Utils.drawDropDownListCountriesWithFlagBtn(
                //     optionName: 'الدولة',
                //     dropDownValue:
                //         Utils.generateCountryFlag(countryCode: 'eg'),
                //     onChanged: (country) {
                //       userAuthenticationController.selectedCountryPhoneCode.value = country.phoneCode;
                //     },
                //     menu: userAuthenticationController.countries,
                //     context: context,
                //     iconSize: 30))

                ),
            Container(
              margin: const EdgeInsets.only(right: 8),
              color: ColorConstants.greyColor,
              width: 1,
              height: 54,
            ),
            Container(
                padding: const EdgeInsets.only(left: 5),
                width: 55,
                child: Obx(() => Text(
                      userAuthenticationController
                          .selectedCountryPhoneCode.value,
                      style: const TextStyle(
                          color: ColorConstants.mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ))),
            Expanded(
              child: TextFormField(
                // autofocus: true,
                textAlignVertical: TextAlignVertical.center,
                scrollPadding: EdgeInsets.zero,
                cursorColor: Get.isDarkMode ? Colors.white : Colors.black,
                controller: widget.controller,
                keyboardType: TextInputType.phone,
                // maxLength: userAuthenticationController
                //     .selectedCountryPhoneLength.value,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(userAuthenticationController
                      .selectedCountryPhoneLength
                      .value), // Restrict to 10 characters
                ],
                decoration: InputDecoration(
                    border: InputBorder.none,
                    fillColor: Get.isDarkMode ? Colors.white : Colors.black,
                    focusColor: Get.isDarkMode ? Colors.white : Colors.black,
                    hoverColor: Get.isDarkMode ? Colors.white : Colors.black,
                    hintText: 'e.g.01234567890',
                    // SharedPreferencesClass.getLanguageCode() == 'ar'?'ادخل رقم الموبايل':'Enter phone number',
                    hintStyle: Theme.of(context).textTheme.subtitle2),
                style: Theme.of(context).textTheme.subtitle1,
                // : Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.left,
                // Utils.textAlign,
                onChanged: (value) {
                  setState(() {
                    phoneNumber = value;
                  });
                },
                validator: (value) {
                  // if (value!.isEmpty) {
                  //   return 'Please enter your phone number!';
                  // } else if (value.length < 11) {
                  //   return 'Too short for a phone number!';
                  // }
                  return null;
                },
              ),
            ),
          ]),
        ),
      ),
      const SizedBox(
        height: 8,
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '${phoneNumber.length}/${userAuthenticationController.selectedCountryPhoneLength}',
            style: TextStyle(
              fontSize: 13,
              height: 1,
              color: ColorConstants.greyColor,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    ]);
  }

  String generateCountryFlag({required String countryCode}) {
    String flag = countryCode.toUpperCase().replaceAllMapped(RegExp(r'[A-Z]'),
        (match) => String.fromCharCode(match.group(0)!.codeUnitAt(0) + 127397));

    return flag;
  }
}
