import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/views/widgets/arrow_back.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';
import 'package:test_ecommerce_app/views/widgets/custom_confirm_password_field.dart';
import 'package:test_ecommerce_app/views/widgets/custom_password_form_field.dart';

class ChangePasswordScreen extends GetView<UserAuthenticationController> {
  ChangePasswordScreen({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.oldPasswordController.text = '';
        controller.passwordController.text = '';
        controller.confirmPasswordController.text = '';
        return true;
      },
      child: Scaffold(
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
                  controller.oldPasswordController.text = '';
                  controller.passwordController.text = '';
                  controller.confirmPasswordController.text = '';
                  Get.back();
                },
                text: translation.changePassword.tr,
              ),
            ),
          ),
          floatingActionButton: const ChattingBtn(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          body: Form(
            key: _formKey,
            child: ListView(
                padding: const EdgeInsets.only(
                  left: 12,
                  right: 12,
                ),
                children: [
                  const SizedBox(height: 25),
                  CustomPasswordFormField(
                    hintText: translation.oldPassword.tr,
                    controller: controller.oldPasswordController,
                  ),
                  const SizedBox(height: 25),
                  CustomPasswordFormField(
                    hintText: translation.newPassword.tr,
                    controller: controller.passwordController,
                  ),
                  const SizedBox(height: 25),
                  CustomConfirmPasswordFormField(
                    hintText: translation.confirmPassword.tr,
                    controller: controller.confirmPasswordController,
                    passwordController: controller.passwordController,
                  ),
                  const SizedBox(height: 35),
                  changeBtn(context),
                ]),
          )),
    );
  }

  Widget changeBtn(BuildContext context) {
    return CustomButton(
        btnText: translation.updateText.tr,
        textColor: Colors.white,
        textSize: 17,
        btnBackgroundColor: ColorConstants.mainColor,
        btnOnpressed: () async {
          if (_formKey.currentState!.validate() &&
              controller.passwordController.text.isNotEmpty &&
              controller.confirmPasswordController.text.isNotEmpty &&
              controller.oldPasswordController.text.isNotEmpty) {
            showDialog(
                context: context,
                builder: (context) => const Center(
                        child: CircularProgressIndicator(
                      color: ColorConstants.mainColor,
                    )));
            controller.resetPassword(
                mobile: SharedPreferencesClass.getPhoneNumber().toString(),
                newPassword: controller.passwordController.text,
                oldPassword: controller.oldPasswordController.text,
                context: context);
            controller.oldPasswordController.text = '';
            controller.passwordController.text = '';
            controller.confirmPasswordController.text = '';
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
