import 'package:flutter/material.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/user/user_authentication_controller.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/widgets/build_intro_text.dart';
import 'package:mizaa/views/widgets/custom_button.dart';
import 'package:mizaa/views/widgets/custom_password_form_field.dart';
import 'package:mizaa/views/widgets/custom_text_btn.dart';
import 'package:mizaa/views/widgets/custom_text_form_field.dart';
import 'package:get/get.dart';
import 'package:mizaa/views/widgets/custom_check_box.dart';
import 'package:mizaa/views/widgets/phone_number_field.dart';
import 'package:mizaa/views/widgets/custom_confirm_password_field.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/views/widgets/arrow_back.dart';

class Register extends GetView<UserAuthenticationController> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Utils.setSystemOverlayForAuthentication();
    controller.registerListenerTextEditingController();
    Controllers.directionalityController.isPasswordAndConfirmPasswordMatched
        .value = false;
    print(
        'agree policy register ${controller.isChecked.value} && ${controller.isButtonEnabled.value}');
    return WillPopScope(
      onWillPop: () async {
        controller.clearRegisterTextFieldData();
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
              toolbarHeight: 80,
              leadingWidth: 200,
              leading: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: ArrowBack(
                  onTap: () {
                    controller.clearRecoveryTextFieldData();
                    Get.offAllNamed('/login');
                  },
                  text: translation.backText.tr,
                ),
              ),
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
                  // crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BuildIntroText(
                      headerText: translation.registerHeader.tr,
                    ),
                    const SizedBox(height: 25),
                    CustomTextFormField(
                        name: translation.username.tr,
                        type: TextInputType.name,
                        controller: controller.firstNameController,
                        lines: 1),
                    const SizedBox(height: 25),

                    PhoneNumberField(
                        controller: controller.phoneNumberController,
                        countries: controller.countries,
                        headerName: translation.phoneNumber.tr),
                    const SizedBox(height: 4),
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

                    // const SizedBox(height: 25),
                    buildConditions(context: context),
                    const SizedBox(height: 20),
                    registerBtn(context),
                    const SizedBox(height: 25),
                    // loginBtn(),
                  ],
                ),
              ),
            )),
      ),
    );
  }

  Widget buildConditions({required BuildContext context}) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width,
      height: 54,
      child: Row(
        children: [
          CustomCheckBox(text: translation.agreeOn.tr),
          CustomTextBtn(
              btnText: translation.termsAndPolicy.tr,
              textColor: ColorConstants.mainColor,
              fontSize: 14,
              btnOnPressed: () {})
        ],
      ),
    );
  }

  Widget registerBtn(BuildContext context) {
    return Obx(
      () => CustomButton(
          btnText: translation.registerHeader.tr,
          textColor: Colors.white,
          textSize: 17,
          btnBackgroundColor: ColorConstants.mainColor,
          btnOnpressed: (controller.isButtonEnabled.value == true &&
                  Controllers.userAuthenticationController.isChecked.value ==
                      true &&
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
                    controller.register(
                      mobileNo: controller.phoneNumberController.text,
                      firstName: controller.firstNameController.text,
                      password: controller.passwordController.text,
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

  // Widget loginBtn() {
  //   return CustomButton(
  //       btnText: 'تسجيل الدخول',
  //       textColor: Colors.black,
  //       textSize: 17,
  //       btnBackgroundColor: ColorConstants.btnBackgroundGrey,
  //       btnOnpressed: () {
  //         Get.offAll(()=>  OTPLoginScreen());
  //       });
  // }
}
