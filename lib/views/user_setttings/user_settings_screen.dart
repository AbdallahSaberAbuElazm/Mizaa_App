import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/user_setttings/change_password_screen.dart';
import 'package:mizaa/views/user_setttings/edit_profile_screen.dart';
import 'package:mizaa/views/widgets/arrow_back.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/views/widgets/custom_button.dart';
import 'package:mizaa/views/widgets/custom_list_tile.dart';

class UserSettingsScreen extends StatelessWidget {
  const UserSettingsScreen({Key? key}) : super(key: key);

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
            text: translation.settings.tr,
          ),
        ),
      ),
      floatingActionButton: const ChattingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: ListView(
        padding: const EdgeInsets.only(left: 12, right: 12, top: 16),
        children: [
          CustomListTile(
              title: translation.updateData.tr,
              icon: Icons.person,
              trailing: '',
              color: Colors.orange,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => const Center(
                            child: CircularProgressIndicator(
                          color: ColorConstants.mainColor,
                        )));
                Controllers
                    .userAuthenticationController.userAuthenticationProvider
                    .getUserBasicInfo(
                        phoneNumber:
                            SharedPreferencesClass.getPhoneNumber().toString(),
                        token: SharedPreferencesClass.getToken().toString())
                    .then((value) {
                  SharedPreferencesClass.setUserBasicInfo(userBasicInfo: value);
                  Get.back();
                  Get.to(() => EditProfileScreen());
                });
              }),
          CustomListTile(
              title: translation.changePassword.tr,
              icon: Icons.lock_reset_outlined,
              trailing: '',
              color: Colors.lightBlue,
              onTap: () {
                Get.to(() => ChangePasswordScreen());
              }),
          CustomListTile(
              title: translation.locationPermission.tr,
              icon: Icons.location_on,
              trailing: '',
              color: ColorConstants.mainColor,
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) => locationPermission(context: context));
              }),
        ],
      ),
    );
  }

  locationPermission({required BuildContext context}) {
    return AlertDialog(
      backgroundColor:
          Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white,
      content: Container(
          height: 140,
          width: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.only(
            left: 10,
            right: 10,
            top: 10,
          ),
          color: Get.isDarkMode
              ? ColorConstants.bottomAppBarDarkColor
              : Colors.white,
          child: Column(
            children: [
              Text(
                'السماح بتحديد الموقع',
                style: TextStyle(
                    color:
                        Get.isDarkMode ? Colors.white : ColorConstants.black0,
                    fontSize: 13,
                    fontFamily: 'Noto Kufi Arabic',
                    fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                'بتحديد موقعك الحالي سوف نستطيع تقديم العروض القريبة منك بشكل دقيق',
                style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
                  fontSize: 13,
                  fontFamily: 'Noto Kufi Arabic',
                ),
                textAlign: TextAlign.center,
              ),
            ],
          )),
      actions: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: TextButton(
              style: ButtonStyle(
                  overlayColor: MaterialStateProperty.all(
                      ColorConstants.backgroundContainerLightColor)),
              onPressed: () {
                Get.back();
              },
              child: const Text(
                'لا شكرا',
                style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: ColorConstants.mainColor,
                ),
              )),
        ),
        SizedBox(
            width: MediaQuery.of(context).size.width / 3,
            child: CustomButton(
                btnText: translation.settings.tr,
                textSize: 11,
                textColor: Colors.white,
                btnBackgroundColor: ColorConstants.mainColor,
                btnOnpressed: () {
                  Utils.handleLocationPermission(context: context);
                })),
      ],
    );
  }
}
