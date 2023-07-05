import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/build_intro_text.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';
import 'package:test_ecommerce_app/views/widgets/custom_password_form_field.dart';
import 'package:test_ecommerce_app/views/widgets/custom_confirm_password_field.dart';
import 'package:test_ecommerce_app/views/widgets/phone_number_field.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
as translation;

class RecoverPassword extends GetView<UserAuthenticationController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    controller.recoveryListenerTextEditingController();
    Controllers.directionalityController.isPasswordAndConfirmPasswordMatched.value = false;

    return WillPopScope(
      onWillPop: () async {
        controller.clearRecoveryTextFieldData();
        Get.offAllNamed('/login');
        return true;
      },
      child: SafeArea(
        child: Scaffold(
              backgroundColor: Get.isDarkMode? ColorConstants.darkMainColor:  Colors.white,
              appBar: AppBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                toolbarHeight: 90,
                leadingWidth: 200,
                leading: Padding(
                  padding: const EdgeInsets.only(left: 14, right: 14),
                  child: GestureDetector(
                    onTap: () {
                      controller.clearRecoveryTextFieldData();
                      Get.offAllNamed('/login');
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
                          translation.backText.tr,
                          style:  TextStyle(
                              color: Get.isDarkMode? Colors.white:Colors.black,
                              fontSize: 16,
                              fontFamily: 'Noto Kufi Arabic',
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    ),
                  ),
                ),
                actions: [
                  Padding(
                    padding: const EdgeInsets.only(left: 14, right: 14),
                    child: Utils.buildLogo(),
                  ),
                ],
              ),
              body: Form(
                key: _formKey,
                child: Container(
                  alignment: Alignment.topRight,
                  margin: const EdgeInsets.only(right: 14, left: 14),
                  child: ListView(
                    children: [
                      BuildIntroText(
                        headerText:
                        translation.recoverHeader.tr,
                      ),
                      const SizedBox(height: 40),
                      PhoneNumberField(
                        controller: controller.phoneNumberController,
                        countries: controller.countries,
                        headerName: translation.phoneNumber.tr,
                      ),
                      const SizedBox(height: 4),
                      CustomPasswordFormField(
                        hintText:
                        translation.password.tr,
                        controller: controller.passwordController,
                      ),
                      const SizedBox(height: 20),
                      CustomConfirmPasswordFormField(
                        hintText:
                        translation.confirmPassword.tr,
                        controller: controller.confirmPasswordController,
                        passwordController: controller.passwordController,
                      ),
                      const SizedBox(height: 27),
                      recoverPasswordBtn(context),
                    ],
                  ),
                ),
              )
        ),
      ),
    );
  }

  Widget recoverPasswordBtn(BuildContext context) {
    return Obx(
      () => CustomButton(
          btnText: translation.continueText.tr,
          textColor: Colors.white,
          textSize: 17,
          btnBackgroundColor: ColorConstants.mainColor,
          btnOnpressed: (controller.isButtonEnabled.value && Controllers.userAuthenticationController.passwordErrorText.isEmpty)
              ? () async {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: ColorConstants.mainColor,
                            )));
                    controller.recoverPassword(
                      password: controller.passwordController.text,
                      mobileNo: controller.phoneNumberController.text,
                      context: context,
                    );
                  } else {
                    controller.phoneNumberController.addListener(() {
                      _formKey.currentState!.validate();
                    });
                    controller.passwordController.addListener(() {
                      _formKey.currentState!.validate();
                    });
                  }
                }
              : null),
    );
  }
}
