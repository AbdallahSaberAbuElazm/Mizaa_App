import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/user/user_authentication_controller.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/widgets/arrow_back.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/views/widgets/custom_button.dart';
import 'package:mizaa/views/widgets/phone_number_field.dart';

class DeleteUserAccount extends GetView<UserAuthenticationController> {
  DeleteUserAccount({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              text: translation.deleteMyAccount.tr,
            ),
          ),
        ),
        floatingActionButton: const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 25,
                  ),
                  Text(
                    translation.deleteUserAccountMessage.tr,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  PhoneNumberField(
                      controller: controller.phoneNumberController,
                      countries: controller.countries,
                      headerName: translation.phoneNumber.tr),
                  const SizedBox(
                    height: 25,
                  ),
                  deleteBtn(context),
                ],
              )),
        ));
  }

  Widget deleteBtn(BuildContext context) {
    return CustomButton(
        btnText: translation.deleteText.tr,
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
          } else {
            Utils.snackBar(
                context: context,
                msg: translation.completeDataText.tr,
                background: ColorConstants.redColor,
                textColor: Colors.white);
          }
        });
  }
}
