import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/views/widgets/arrow_back.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/views/widgets/chatting_btn.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({Key? key}) : super(key: key);

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
              text: translation.contactUs.tr,
            ),
          ),
        ),
        floatingActionButton: const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          children: [
            const SizedBox(
              height: 25,
            ),
            Text(
              translation.followUsThrough.tr,
              style: Theme.of(context).textTheme.subtitle1,
            ),
            const SizedBox(
              height: 25,
            ),
            contactInfo(),
            const SizedBox(
              height: 25,
            ),
          ],
        ));
  }

  Widget contactInfo() {
    return Row(
      children: [
        _contactIcon(imagePath: 'assets/images/website.png'),
        const SizedBox(
          width: 12,
        ),
        _contactIcon(imagePath: 'assets/images/facebook.png'),
      ],
    );
  }

  Widget _contactIcon({required String imagePath}) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: 37,
        height: 37,
        padding: const EdgeInsets.all(9),
        decoration:
            const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
        child: Image.asset(
          imagePath,
          color: ColorConstants.black0,
        ),
      ),
    );
  }
}
