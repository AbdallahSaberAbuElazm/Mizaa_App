import 'package:flutter/services.dart';
import 'package:restart_app/restart_app.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/theme/ThemesController.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/helpers/extensions/StringExtension.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/views/wallet/wallet_screen.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/custom_button.dart';

class UserTab extends StatefulWidget {
  UserTab({Key? key}) : super(key: key);

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  final ThemesController _themesController = Get.find();

  @override
  Widget build(BuildContext context) {
    print(
        'language is ${SharedPreferencesClass.getLanguageName()}  ${SharedPreferencesClass.getLanguageCode()} ');

    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
          // headerSliverBuilder: (context, innerBoxIsScrolled) {
          //   return <Widget>[
          //     //  SliverAppBar(
          //     //   expandedHeight: 100.0,
          //     //   floating: false,
          //     //   pinned: true,
          //     //   flexibleSpace: FlexibleSpaceBar(
          //     //     centerTitle: false,
          //     //     titlePadding: const EdgeInsets.symmetric(horizontal: 16),
          //     //     title: Text(translation.settings.tr,
          //     //         style: const TextStyle(
          //     //             color: Colors.black,
          //     //             fontSize: 18,
          //     //             fontFamily: 'Noto Kufi Arabic',
          //     //             fontWeight: FontWeight.w500)),
          //     //   ),
          //     // ),
          //   ];
          // },
          body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                Text(translation.account.tr,
                    style: TextStyle(
                        color: Get.isDarkMode ? Colors.white : Colors.black,
                        fontSize: 18,
                        fontFamily: 'Noto Kufi Arabic',
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 16),
                SharedPreferencesClass.getToken() == null ||
                        SharedPreferencesClass.getToken() == ''
                    ? CustomButton(
                        btnText: Utils.getTranslatedText(
                            arText: 'تسجيل الدخول / انشاء حساب',
                            enText: "Login / Register"),
                        textSize: 15,
                        textColor: Colors.white,
                        btnBackgroundColor: ColorConstants.mainColor,
                        btnOnpressed: () {
                          Get.offAllNamed('/login');
                        })
                    : const SizedBox.shrink(),
                const SizedBox(height: 32),
                Text(translation.settings.tr,
                    style: theme.textTheme.headline6
                        ?.copyWith(fontWeight: FontWeight.w400, fontSize: 16)),
                const SizedBox(height: 16),
                SharedPreferencesClass.getToken() != null &&
                    SharedPreferencesClass.getToken() != ''
                    ?  _buildListTile(translation.wallet.tr, Icons.wallet, '',
                    ColorConstants.mainColor, theme, onTab: () {

                      showDialog(
                          context: context,
                          builder: (context) => const Center(
                              child: CircularProgressIndicator(
                                color: ColorConstants.mainColor,
                              )));
                      Controllers.userAuthenticationController.getUserWallet()
                          .then((wallet) {
                        Get.back();
                        Get.put(UserAuthenticationController(Get.find()));
                        Get.to(() =>  WalletScreen());
                      });



                }) : const SizedBox.shrink(),
                GetBuilder<ThemesController>(builder: (_) {
                  return _buildListTile(
                      translation.appearance.tr,
                      Icons.dark_mode,
                      _.theme.toCapitalized(),
                      Colors.purple,
                      theme,
                      onTab: () => _showAppearanceModal(theme, _.theme));
                  // return Text(_.theme);
                }),
                const SizedBox(height: 8),
                SharedPreferencesClass.getToken() != null &&
                        SharedPreferencesClass.getToken() != ''
                    ? _buildListTile(translation.logout.tr, Icons.exit_to_app,
                        '', Colors.red, theme, onTab: () {
                        print(
                            'user data ${SharedPreferencesClass.getPhoneNumber()}  ${SharedPreferencesClass.getFirstName()}');
                        SharedPreferencesClass.removeDataForLogout();
                        Get.offAllNamed('/login');
                      })
                    : const SizedBox.shrink(),
              ],
            ),
            Text("Version 1.0.0",
                style: theme.textTheme.bodyText2
                    ?.copyWith(color: Colors.grey.shade500)),
          ],
        ),
      )),
    );
  }

  Widget _buildListTile(
      String title, IconData icon, String trailing, Color color, theme,
      {onTab}) {
    return ListTile(
        contentPadding: const EdgeInsets.all(0),
        leading: Container(
          width: 46,
          height: 46,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: color.withAlpha(30)),
          child: Center(
            child: Icon(
              icon,
              color: color,
            ),
          ),
        ),
        title: Text(title,
            style: theme.textTheme.subtitle1?.copyWith(fontSize: 13.0)),
        trailing: SizedBox(
          width: 90,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(trailing,
                  style: theme.textTheme.bodyText1
                      ?.copyWith(color: Colors.grey.shade600, fontSize: 13.0)),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
              ),
            ],
          ),
        ),
        onTap: onTab);
  }

  _showLanguageModal(ThemeData theme, String current) {
    Get.bottomSheet(Container(
        padding: const EdgeInsets.all(16),
        height: 270,
        decoration: BoxDecoration(
            color: Get.isDarkMode ? Colors.grey.shade900 : Colors.grey.shade200,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            )),
        child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Select a Language",
                style: theme.textTheme.subtitle1,
              ),
              const SizedBox(height: 32),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: ColorConstants.mainColor,
                ),
                title: Text("العربية", style: theme.textTheme.bodyText1),
                onTap: () async {
                  setState(() {
                    SharedPreferencesClass.setUserLanguageName(
                        language: 'العربية');
                    SharedPreferencesClass.setUserLanguageCode(language: 'ar');
                  });
                  // Get.back();
                  await Restart.restartApp();
                },
                trailing: Icon(
                  Icons.check,
                  color: current == 'العربية'
                      ? ColorConstants.mainColor
                      : Colors.transparent,
                ),
              ),
              const SizedBox(height: 16),
              ListTile(
                leading: const Icon(
                  Icons.language,
                  color: ColorConstants.mainColor,
                ),
                title: Text("English", style: theme.textTheme.bodyText1),
                onTap: () async {
                  setState(() {
                    SharedPreferencesClass.setUserLanguageName(
                        language: 'English');
                    SharedPreferencesClass.setUserLanguageCode(language: 'en');
                  });
                  // Get.back();
                  await Restart.restartApp();
                },
                trailing: Icon(
                  Icons.check,
                  color:
                      current == 'English' ? Colors.orange : Colors.transparent,
                ),
              ),
            ])));
  }

  _showAppearanceModal(ThemeData theme, String current) {
    Get.bottomSheet(
      Container(
        padding: const EdgeInsets.all(14),
        height: 320,
        decoration: BoxDecoration(
          color: Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              translation.selectTheme.tr,
              style: theme.textTheme.subtitle1,
            ),
            const SizedBox(height: 32),
            ListTile(
              leading: const Icon(
                Icons.brightness_5,
                color: Colors.blue,
              ),
              title: Text("Light", style: theme.textTheme.bodyText1),
              onTap: () {
                _themesController.setTheme('light');

                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(
                    systemNavigationBarColor: Colors.white, // navigation bar color
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.white, // status bar color
                    statusBarIconBrightness: Brightness.dark,
                  ),
                );
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                color: current == 'light' ? Colors.blue : Colors.transparent,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.brightness_2,
                color: Colors.orange,
              ),
              title: Text("Dark", style: theme.textTheme.bodyText1),
              onTap: () {
                _themesController.setTheme('dark');

                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(
                    systemNavigationBarColor: ColorConstants.darkMainColor, // navigation bar color
                    systemNavigationBarIconBrightness: Brightness.light,
                    statusBarColor: ColorConstants.darkMainColor, // status bar color
                    statusBarIconBrightness: Brightness.light,
                  ),
                );
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                color: current == 'dark' ? Colors.orange : Colors.transparent,
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: const Icon(
                Icons.brightness_6,
                color: Colors.blueGrey,
              ),
              title: Text("System", style: theme.textTheme.bodyText1),
              onTap: () {
                _themesController.setTheme('system');

                SystemChrome.setSystemUIOverlayStyle(
                  SystemUiOverlayStyle(
                    systemNavigationBarColor: Get.isDarkMode
                        ? ColorConstants.darkMainColor
                        : Colors.white, // navigation bar color
                    systemNavigationBarIconBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
                    statusBarColor: Get.isDarkMode ? ColorConstants.darkMainColor : Colors.white, // status bar color
                    statusBarIconBrightness: Get.isDarkMode ? Brightness.light : Brightness.dark,
                  ),
                );
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                color: current == 'system' ? Colors.blueGrey : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }

}
