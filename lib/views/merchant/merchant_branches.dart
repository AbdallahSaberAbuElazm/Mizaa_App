import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/companies/company_controller.dart';
import 'package:test_ecommerce_app/models/companies/company_branches/CompanyBranchesModel.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/views/widgets/center_image_for_empty_data.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/views/widgets/custom_texts.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';
import 'package:url_launcher/url_launcher.dart';

class MerchantBranches extends GetView<CompanyController> {
  final String companyKey;
  const MerchantBranches({Key? key, required this.companyKey})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.resetMerchantBranches();
    print('company id is $companyKey');
    controller.getCompanyBranches(companyKey: companyKey);
    return Obx(() => Scaffold(
          // backgroundColor: ColorConstants.backgroundContainer,
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor:
                // Colors.transparent,
                // Colors.white,
                controller.appBarMerchantBranchesColor.value,
            flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarIconBrightness: Get.isDarkMode
                      ? Brightness.light
                      : controller.appBarMerchantBranchesColor.value ==
                              Colors.white
                          ? Brightness.dark
                          : Brightness.dark,
                  statusBarBrightness:
                      Get.isDarkMode ? Brightness.light : Brightness.dark,
                  systemNavigationBarColor: Get.isDarkMode
                      ? ColorConstants.darkMainColor
                      : Colors.white, // navigation bar color
                  systemNavigationBarIconBrightness:
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
            leadingWidth: 260,
            leading: Utils.buildLeadingAppBar(
                title: translation.availableBranches.tr),
          ),
          floatingActionButton: const ChattingBtn(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          body: (controller.isLoadingCompanyBranches.value)
              ? ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 2),
                      child: ShimmerContainer(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 76,
                          topPadding: 0,
                          bottomPadding: 0,
                          rightPadding: 0,
                          leftPadding: 0),
                    ),
                  ),
                )
              : (controller.companyBranches.isNotEmpty ||
                      controller.companyBranches != null)
                  ? ListView.builder(
                      controller: controller.scrollMerchantBranchesController,
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 20, bottom: 20),
                      itemCount: controller.companyBranches.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            _buildBranchCard(
                                context: context,
                                companyBranchesModel:
                                    controller.companyBranches[index]),
                            Divider(
                              color: ColorConstants.greyColor,
                              height: 0.5,
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                          ],
                        );
                      },
                    )
                  : CenterImageForEmptyData(
                      imagePath: 'assets/images/ratings_empty.png',
                      text: translation.noOtherBranches.tr),
        ));
  }

  Widget _buildBranchCard(
      {required BuildContext context,
      required CompanyBranchesModel companyBranchesModel}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 76,
      padding: EdgeInsets.only(
          right: Utils.rightPadding10Right,
          left: Utils.leftPadding10Left,
          top: 8,
          bottom: 8),
      decoration: const BoxDecoration(
        color: Colors.transparent,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon
              const Icon(
                Icons.location_on_sharp,
                color: ColorConstants.mainColor,
                size: 21,
              ),
              const SizedBox(
                width: 20,
              ),
              // column
              SizedBox(
                width: MediaQuery.of(context).size.width / 2.46,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                            translation.offerName.trParams({
                              'offerName': Utils.getTranslatedText(
                                  arText: companyBranchesModel.title.toString(),
                                  enText:
                                      companyBranchesModel.enTitle.toString())
                            }),
                            style: TextStyle(
                                color: Get.isDarkMode
                                    ? Colors.white
                                    : ColorConstants.black0,
                                fontSize: 15,
                                fontFamily: 'Noto Kufi Arabic',
                                fontWeight: FontWeight.w600,
                                height: 1.5))),
                    SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Text(
                          translation.offerName.trParams({
                            'offerName': Utils.getTranslatedText(
                                arText: companyBranchesModel.address.toString(),
                                enText:
                                    companyBranchesModel.enAddress.toString())
                          }),
                          style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white
                                : ColorConstants.greyColor,
                            fontSize: 12,
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        )),
                  ],
                ),
              )
            ],
          ),

          /////// second row
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              customButton(
                  btnText: translation.map.tr,
                  textColor: Colors.white,
                  btnBackgroundColor: ColorConstants.mainColor,
                  borderColor: Colors.transparent,
                  textSize: 10,
                  imagePath: 'assets/images/map.png',
                  btnOnPressed: () async {
                    if (!await launchUrl(
                      Uri.parse(
                          'https://www.google.com/maps/search/?api=1&query=${companyBranchesModel.lat}, ${companyBranchesModel.long}'),
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch ');
                    }
                  }),
              const SizedBox(
                width: 6,
              ),
              customButton(
                  btnText: translation.call.tr,
                  textColor: Get.isDarkMode ? Colors.white : Colors.black,
                  btnBackgroundColor: Colors.transparent,
                  borderColor: ColorConstants.greyColor,
                  textSize: 10,
                  imagePath: 'assets/images/call.png',
                  btnOnPressed: () async {
                    if (!await launchUrl(
                      Uri.parse('tel:${companyBranchesModel.phone}'),
                      mode: LaunchMode.externalApplication,
                    )) {
                      throw Exception('Could not launch ');
                    }
                  }),
            ],
          ),
        ],
      ),
    );
  }

  Widget customButton({
    required String btnText,
    required Color textColor,
    required Color btnBackgroundColor,
    required Color borderColor,
    required double textSize,
    required String imagePath,
    required dynamic btnOnPressed,
  }) {
    return SizedBox(
        width: 75,
        height: 33,
        child: InkWell(
          onTap: btnOnPressed,
          child: Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: btnBackgroundColor,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: borderColor, width: 0.5),
              ),
              child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      btnText,
                      style: TextStyle(
                          color: textColor,
                          fontSize: textSize,
                          fontFamily: 'Noto Kufi Arabic',
                          fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 5),
                    Image.asset(
                      imagePath,
                      width: 17,
                      height: 17,
                      color: textColor,
                      fit: BoxFit.cover,
                    ),
                  ])),
        ));
  }
}
