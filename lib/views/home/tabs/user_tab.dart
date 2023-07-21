import 'package:flutter/services.dart';
import 'package:test_ecommerce_app/views/authentication/delete_user_account.dart';
import 'package:test_ecommerce_app/views/merchant/contact_us.dart';
import 'package:test_ecommerce_app/views/user_setttings/user_settings_screen.dart';
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
import 'package:test_ecommerce_app/views/widgets/custom_list_tile.dart';

class UserTab extends StatefulWidget {
  UserTab({Key? key}) : super(key: key);

  @override
  State<UserTab> createState() => _UserTabState();
}

class _UserTabState extends State<UserTab> {
  final ThemesController _themesController = Get.find();

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Get.isDarkMode
            ? ColorConstants.darkMainColor
            : Colors.white, // navigation bar color
        systemNavigationBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
        statusBarColor: Get.isDarkMode
            ? ColorConstants.bottomAppBarDarkColor
            : Colors.white,
        statusBarIconBrightness:
            Get.isDarkMode ? Brightness.light : Brightness.dark,
      ),
    );
    final theme = Theme.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(),
        body: ListView(
          children: [
            Controllers.userAuthenticationController.isLoggedIn.value
                ? Container(
                    width: MediaQuery.of(context).size.width,
                    height: 110,
                    padding: const EdgeInsets.only(left: 6, right: 6),
                    decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(35),
                            bottomRight: Radius.circular(35)),
                        color: Get.isDarkMode
                            ? ColorConstants.bottomAppBarDarkColor
                            : Colors.white),
                    child: Row(
                      children: [
                        Container(
                          height: 75,
                          width: 75,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.asset(
                            'assets/images/person.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(SharedPreferencesClass.getFirstName().toString(),
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w500)),
                      ],
                    ))
                : const SizedBox.shrink(),

            // const SizedBox(height: 16),

            Controllers.userAuthenticationController.isLoggedIn.value
                ? const SizedBox.shrink()
                : Padding(
                    padding: const EdgeInsets.only(
                      left: 12,
                      right: 12,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(translation.welcome.tr,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 18,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.bold)),

                        // const SizedBox(height: 12,),
                        Text(translation.loginHeader.tr,
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 15,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w500)),
                        const SizedBox(
                          height: 12,
                        ),
                        CustomButton(
                            btnText: Utils.getTranslatedText(
                                arText: 'تسجيل الدخول / انشاء حساب',
                                enText: "Login / Register"),
                            textSize: 15,
                            textColor: Colors.white,
                            btnBackgroundColor: ColorConstants.mainColor,
                            btnOnpressed: () {
                              Get.offAllNamed('/login');
                            }),
                      ],
                    ),
                  ),

            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // wallet
                  Controllers.userAuthenticationController.isLoggedIn.value
                      ? CustomListTile(
                          title: translation.wallet.tr,
                          icon: Icons.wallet,
                          trailing: '',
                          color: ColorConstants.mainColor,
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) => const Center(
                                        child: CircularProgressIndicator(
                                      color: ColorConstants.mainColor,
                                    )));
                            Controllers.userAuthenticationController
                                .getUserWallet()
                                .then((wallet) {
                              Get.back();
                              Get.put(UserAuthenticationController(Get.find()));
                              Get.to(() => WalletScreen());
                            });
                          })
                      : const SizedBox.shrink(),

                  // Appearance mode
                  GetBuilder<ThemesController>(builder: (_) {
                    return CustomListTile(
                        title: translation.appearance.tr,
                        icon: Icons.dark_mode,
                        trailing: '',
                        color: Colors.purple,
                        onTap: () => _showAppearanceModal(theme, _.theme));
                    // return Text(_.theme);
                  }),

                  // contact us
                  CustomListTile(
                      title: translation.contactUs.tr,
                      icon: Icons.phone,
                      trailing: '',
                      color: Colors.lightBlue,
                      onTap: () {
                        Get.to(() => const ContactUs());
                      }),

                  // delete account
                  Controllers.userAuthenticationController.isLoggedIn.value
                      ? CustomListTile(
                          title: translation.deleteUserAccount.tr,
                          icon: Icons.delete,
                          trailing: '',
                          color: Colors.red,
                          onTap: () {
                            Get.to(() => DeleteUserAccount());
                          })
                      : const SizedBox.shrink(),

                  //version number of app
                  _buildListTileWithLeading(translation.version.tr,
                      'assets/images/google_play.png', '1.0.0', theme),

                  // logout
                  Controllers.userAuthenticationController.isLoggedIn.value
                      ? CustomListTile(
                          title: translation.logout.tr,
                          icon: Icons.exit_to_app,
                          trailing: '',
                          color: Colors.red,
                          onTap: () {
                            print(
                                'user data ${SharedPreferencesClass.getPhoneNumber()}  ${SharedPreferencesClass.getFirstName()}');
                            SharedPreferencesClass.removeDataForLogout();
                            Controllers.userAuthenticationController.isLoggedIn
                                .value = false;
                            Get.offAllNamed('/login');
                          })
                      : const SizedBox.shrink(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /////// App bar /////
  _buildAppBar() {
    return Controllers.userAuthenticationController.isLoggedIn.value
        ? AppBar(
            elevation: 0,
            backgroundColor: Get.isDarkMode
                ? ColorConstants.bottomAppBarDarkColor
                : Colors.white,
            // backgroundColor: Colors.transparent,
            toolbarHeight: 80,
            leadingWidth: 260,
            // shape: const RoundedRectangleBorder(
            //   borderRadius: BorderRadius.only(
            //     bottomLeft: Radius.circular(20),
            //     bottomRight: Radius.circular(20),
            //   ),
            // ),
            leading: Padding(
              padding: EdgeInsets.only(
                  right: Utils.rightPadding12Right,
                  left: Utils.leftPadding12Left),
              child: Row(children: [
                Text(
                  translation.account.tr,
                  style: TextStyle(
                      color: Get.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 18,
                      fontFamily: 'Noto Kufi Arabic',
                      fontWeight: FontWeight.w800),
                ),
              ]),
            ),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 12, right: 12),
                child: GestureDetector(
                  onTap: () {
                    Get.to(() => const UserSettingsScreen());
                  },
                  child: Container(
                    width: 30,
                    height: 30,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: ColorConstants.gray100,
                          offset: const Offset(
                              0, 2), // controls the offset of the shadow
                          blurRadius:
                              4, // controls the blur radius of the shadow
                          spreadRadius:
                              0, // controls the spread radius of the shadow
                        ),
                      ],
                    ),
                    child: Icon(
                      Icons.settings,
                      color: ColorConstants.black0,
                      size: 18,
                    ),
                  ),
                ),
              ),
            ],
          )
        : AppBar(
            backgroundColor: Colors.transparent,
            leading: const SizedBox.shrink(),
          );
  }

  Widget _buildListTile(
      String title, IconData icon, String trailing, Color color, theme,
      {onTab}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white),
      child: ListTile(
          leading: Container(
            width: 42,
            height: 42,
            decoration: BoxDecoration(
                shape: BoxShape.circle, color: color.withAlpha(30)),
            child: Center(
              child: Icon(
                icon,
                color: color,
              ),
            ),
          ),
          title: Text(title,
              style: const TextStyle(
                  color: Colors.black,
                  fontSize: 13.0,
                  fontWeight: FontWeight.bold)),
          trailing: SizedBox(
            width: 90,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(trailing,
                    style:
                        const TextStyle(color: Colors.black, fontSize: 13.0)),
                const Icon(
                  Icons.arrow_forward_ios,
                  size: 16,
                  color: Colors.black,
                ),
              ],
            ),
          ),
          onTap: onTab),
    );
  }

  Widget _buildListTileWithLeading(
      String title, String imagePath, String trailing, theme) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 9),
      margin: const EdgeInsets.symmetric(vertical: 6),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: Colors.white),
      child: ListTile(
        leading: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.transparent,
              border: Border.all(
                  color: ColorConstants.backgroundContainerLightColor,
                  width: 1)),
          child: Center(
            child: Image.asset(imagePath,
                width: 33, height: 33, fit: BoxFit.contain),
          ),
        ),
        title: Text(title,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 13.0,
                fontWeight: FontWeight.bold)),
        trailing: Text(trailing,
            style: const TextStyle(
                color: Colors.black,
                fontSize: 15.0,
                fontWeight: FontWeight.bold)),
      ),
    );
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
          color: Get.isDarkMode
              ? ColorConstants.bottomAppBarDarkColor
              : Colors.white,
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
                    systemNavigationBarColor:
                        Colors.white, // navigation bar color
                    systemNavigationBarIconBrightness: Brightness.dark,
                    statusBarColor: Colors.transparent,
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
                    systemNavigationBarColor:
                        ColorConstants.darkMainColor, // navigation bar color
                    systemNavigationBarIconBrightness: Brightness.light,
                    statusBarColor: Colors.transparent, // status bar color
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
                    systemNavigationBarIconBrightness:
                        Get.isDarkMode ? Brightness.light : Brightness.dark,
                    statusBarColor: Get.isDarkMode
                        ? ColorConstants.darkMainColor
                        : Colors.white, // status bar color
                    statusBarIconBrightness:
                        Get.isDarkMode ? Brightness.light : Brightness.dark,
                  ),
                );
                Get.back();
              },
              trailing: Icon(
                Icons.check,
                color:
                    current == 'system' ? Colors.blueGrey : Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
