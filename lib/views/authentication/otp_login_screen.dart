import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/build_intro_text.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';
import 'package:test_ecommerce_app/views/widgets/custom_password_form_field.dart';
import 'package:test_ecommerce_app/views/widgets/custom_text_btn.dart';
import 'package:test_ecommerce_app/views/widgets/phone_number_field.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;

class OTPLoginScreen extends GetView<UserAuthenticationController> {
  bool enableBtn = false;
  bool isAPICallProcess = false;
  final UserAuthenticationController userAuthenticationController = Get.find();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Utils.setSystemOverlayForAuthentication();
    controller.loginListenerTextEditingController();

    return SafeArea(
      child: Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor:
              Get.isDarkMode ? ColorConstants.darkMainColor : Colors.white,
          body: Form(
            key: _formKey,
            child: Container(
              alignment: Alignment.topRight,
              margin: const EdgeInsets.only(right: 12, left: 12),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.039,
                  ),
                  Utils.buildLogo(),
                  SizedBox(height: MediaQuery.of(context).size.height / 40),
                  BuildIntroText(
                    headerText: translation.loginHeader.tr,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height / 25),
                  PhoneNumberField(
                    controller: controller.phoneNumberController,
                    countries: controller.countries,
                    headerName: translation.phoneNumber.tr,
                  ),
                  const SizedBox(height: 4),
                  CustomPasswordFormField(
                    hintText: translation.password.tr,
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: 6),
                  recoverPassword(),
                  const SizedBox(height: 6),
                  loginBtn(context: context),
                  const SizedBox(height: 14),
                  Center(
                    child: Text(
                      translation.dontHaveAnAccount.tr,
                      style: TextStyle(
                          color: Get.isDarkMode ? Colors.white : Colors.black,
                          fontSize: 15,
                          fontFamily: 'Noto Kufi Arabic',
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  const SizedBox(height: 14),
                  createAccount(),
                  const SizedBox(height: 6),
                  goToHomePage(),
                ],
              ),
            ),
          )),
    );
  }

  Widget loginBtn({required BuildContext context}) {
    return Obx(
      () => CustomButton(
          btnText: translation.login.tr,
          textColor: Colors.white,
          textSize: 17,
          btnBackgroundColor: ColorConstants.mainColor,
          btnOnpressed: (controller.isButtonEnabled.value &&
                  Controllers
                      .userAuthenticationController.passwordErrorText.isEmpty)
              ? () {
                  if (_formKey.currentState!.validate()) {
                    showDialog(
                        context: context,
                        builder: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: ColorConstants.mainColor,
                            )));
                    controller.otpLogin(
                        mobileNo: controller.phoneNumberController.text,
                        password: controller.passwordController.text,
                        context: context);
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

  Widget createAccount() {
    return CustomButton(
        btnText: translation.createAccount.tr,
        textColor: Colors.black,
        textSize: 17,
        btnBackgroundColor: ColorConstants.btnBackgroundGrey,
        btnOnpressed: () {
          controller.phoneNumberController.text = '';
          controller.passwordController.text = '';
          Get.toNamed('/register');
        });
  }

  Widget recoverPassword() {
    return Center(
        child: CustomTextBtn(
            btnText: translation.forgetPassword.tr,
            textColor: ColorConstants.mainColor,
            fontSize: 15,
            btnOnPressed: () {
              controller.phoneNumberController.text = '';
              controller.passwordController.text = '';
              Get.toNamed('/recovery');
            }));
  }

  Widget goToHomePage() {
    return Center(
        child: CustomTextBtn(
            btnText: translation.goToHomePage.tr,
            textColor: ColorConstants.mainColor,
            fontSize: 15,
            btnOnPressed: () {
              Controllers.userAuthenticationController.isLoggedIn.value = false;
              Get.offNamed('/home');
            }));
  }
}
