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
import 'package:test_ecommerce_app/views/widgets/arrow_back.dart';

class RecoverPassword extends GetView<UserAuthenticationController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Utils.setSystemOverlayForAuthentication();
    controller.recoveryListenerTextEditingController();
    Controllers.directionalityController.isPasswordAndConfirmPasswordMatched
        .value = false;

    return WillPopScope(
      onWillPop: () async {
        controller.clearRecoveryTextFieldData();
        Get.offAllNamed('/login');
        return true;
      },
      child: SafeArea(
        child: Scaffold(
            backgroundColor:
                Get.isDarkMode ? ColorConstants.darkMainColor : Colors.white,
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.transparent,
              toolbarHeight: 90,
              leadingWidth: 200,
              leading: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ArrowBack(
                    onTap: () {
                      controller.clearRecoveryTextFieldData();
                      Get.offAllNamed('/login');
                    },
                    text: translation.backText.tr,
                  )),
              actions: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Utils.buildLogo(),
                ),
              ],
            ),
            body: Form(
              key: _formKey,
              child: Container(
                alignment: Alignment.topRight,
                margin: const EdgeInsets.symmetric(horizontal: 12),
                child: ListView(
                  children: [
                    BuildIntroText(
                      headerText: translation.recoverHeader.tr,
                    ),
                    SizedBox(height: MediaQuery.of(context).size.height / 35),
                    PhoneNumberField(
                      controller: controller.phoneNumberController,
                      countries: controller.countries,
                      headerName: translation.phoneNumber.tr,
                    ),
                    const SizedBox(height: 5),
                    CustomPasswordFormField(
                      hintText: translation.password.tr,
                      controller: controller.passwordController,
                    ),
                    const SizedBox(height: 25),
                    CustomConfirmPasswordFormField(
                      hintText: translation.confirmPassword.tr,
                      controller: controller.confirmPasswordController,
                      passwordController: controller.passwordController,
                    ),
                    const SizedBox(height: 27),
                    recoverPasswordBtn(context),
                  ],
                ),
              ),
            )),
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
          btnOnpressed: (controller.isButtonEnabled.value &&
                  Controllers
                      .userAuthenticationController.passwordErrorText.isEmpty)
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
