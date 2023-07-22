import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:get/get.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/views/widgets/chatting_btn.dart';

class OfferTermsConditions extends GetView<OfferController> {
  final String htmlText;
  const OfferTermsConditions({Key? key, required this.htmlText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.resetTermsAndConditionsScrolling();
    return Obx(
      () => Scaffold(
        // backgroundColor: ColorConstants.backgroundContainer,
        // extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor:
              // Colors.transparent,
              controller.appBarTermsConditionsColor.value,
          flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
              value: SystemUiOverlayStyle(
                statusBarIconBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
                statusBarBrightness:
                    Get.isDarkMode ? Brightness.light : Brightness.dark,
              ),
              child: Container()),
          elevation: 0,
          toolbarHeight: 80,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20),
              bottomRight: Radius.circular(20),
            ),
          ),
          leadingWidth: 270,
          leading: Utils.buildLeadingAppBar(
              title: translation.termsConditionsText.tr),
        ),
        floatingActionButton: const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: ListView(
          controller: controller.scrollTermsConditionsController,
          padding:
              const EdgeInsets.only(left: 16, right: 16, top: 25, bottom: 25),
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
              decoration: BoxDecoration(
                  color: Get.isDarkMode
                      ? ColorConstants.darkMainColor
                      : Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(12))),
              child: Html(
                data: htmlText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
