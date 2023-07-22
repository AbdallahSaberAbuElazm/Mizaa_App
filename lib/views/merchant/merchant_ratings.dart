import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/models/offers/offer_rate/OfferRateModel.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/widgets/center_image_for_empty_data.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/views/widgets/shimmer_container.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mizaa/views/widgets/custom_button.dart';

class MerchantRatings extends GetView<OfferController> {
  final OfferModel offerModel;
  const MerchantRatings({Key? key, required this.offerModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.resetMerchantRatingsScrolling();
    return Obx(() => Scaffold(
          appBar: AppBar(
            backgroundColor:
                // Colors.white,
                controller.appBarOfferRatingsColor.value,
            flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
                value: SystemUiOverlayStyle(
                  statusBarIconBrightness: Get.isDarkMode
                      ? Brightness.light
                      : controller.appBarOfferRatingsColor.value == Colors.white
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
            leading: Utils.buildLeadingAppBar(title: translation.ratings.tr),
            actions: [
              controller.isUserRateOffer.value
                  ? Padding(
                      padding: const EdgeInsets.only(
                        right: 14,
                        left: 14,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        backgroundColor: Get.isDarkMode
                                            ? ColorConstants
                                                .bottomAppBarDarkColor
                                            : Colors.white,
                                        content: Container(
                                          height: 158,
                                          padding: const EdgeInsets.only(
                                            left: 10,
                                            right: 10,
                                            top: 16,
                                          ),
                                          color: Get.isDarkMode
                                              ? ColorConstants
                                                  .bottomAppBarDarkColor
                                              : Colors.white,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                translation.addRatings.tr,
                                                style: TextStyle(
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                    fontSize: 16,
                                                    fontFamily:
                                                        'Noto Kufi Arabic',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                              const SizedBox(
                                                height: 16,
                                              ),
                                              Obx(
                                                () => RatingBar.builder(
                                                  initialRating: controller
                                                      .userRating.value,
                                                  minRating: 1,
                                                  direction: Axis.horizontal,
                                                  allowHalfRating: true,
                                                  // ignoreGestures: true,
                                                  itemSize: 28,
                                                  unratedColor: Colors.grey,
                                                  itemCount: 5,
                                                  itemPadding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 0.5),
                                                  itemBuilder: (context, _) =>
                                                      const Icon(
                                                    Icons.star,
                                                    color: ColorConstants
                                                        .mainColor,
                                                  ),
                                                  onRatingUpdate: (rating) {
                                                    controller.userRating
                                                        .value = rating;
                                                    print(
                                                        'rating is ${controller.userRating.value}');
                                                  },
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              SizedBox(
                                                height: 45,
                                                child: CustomButton(
                                                    btnText:
                                                        translation.saveText.tr,
                                                    textSize: 15,
                                                    textColor: Get.isDarkMode
                                                        ? ColorConstants
                                                            .bottomAppBarDarkColor
                                                        : Colors.white,
                                                    btnBackgroundColor:
                                                        ColorConstants
                                                            .mainColor,
                                                    btnOnpressed: () {
                                                      controller.addRateToOffer(
                                                          offerId:
                                                              offerModel.id!,
                                                          offerKey:
                                                              offerModel.key!,
                                                          rate: controller
                                                              .userRating.value,
                                                          context: context);
                                                      controller.userRating
                                                          .value = 0.0;
                                                    }),
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    });
                              },
                              child: Text(
                                translation.addRatings.tr,
                                style: const TextStyle(
                                    color: ColorConstants.mainColor,
                                    fontSize: 12,
                                    fontFamily: 'Noto Kufi Arabic',
                                    fontWeight: FontWeight.w500),
                              )),
                        ],
                      ),
                    )
                  : const SizedBox()
            ],
          ),
          floatingActionButton: const ChattingBtn(),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.miniEndFloat,
          body: (controller.isLoadingOfferRatings.value)
              ? ListView.builder(
                  itemCount: 3,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(bottom: 16, top: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 9),
                      child: ShimmerContainer(
                          width: MediaQuery.of(context).size.width / 1.5,
                          height: 108,
                          topPadding: 0,
                          bottomPadding: 0,
                          rightPadding: 0,
                          leftPadding: 0),
                    ),
                  ),
                )
              : (controller.offerRatings.length > 0)
                  ? ListView.builder(
                      controller: controller.scrollOfferRatingsController,
                      padding: const EdgeInsets.only(
                          left: 16, right: 16, top: 20, bottom: 20),
                      itemCount: controller.offerRatings.length,
                      itemBuilder: (context, index) {
                        return _buildRatingsCard(
                            context: context,
                            offerRate: controller.offerRatings[index]);
                      },
                    )
                  : CenterImageForEmptyData(
                      imagePath: 'assets/images/merchant_empty.png',
                      text: translation.noRatingsAvailable.tr),
        ));
  }

  Widget _buildRatingsCard(
      {required BuildContext context, required OfferRateModel offerRate}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 108,
      padding: EdgeInsets.only(
          right: Utils.rightPadding12Right, left: Utils.leftPadding12Left),
      margin: const EdgeInsets.only(bottom: 9),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                width: 92,
                height: 31,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: ColorConstants.backgroundRatings,
                    borderRadius: BorderRadius.only(
                      bottomRight: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'ar'
                          ? Radius.circular(12)
                          : Radius.circular(0),
                      bottomLeft: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'ar'
                          ? Radius.circular(0)
                          : Radius.circular(12),
                      topLeft: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'ar'
                          ? Radius.circular(12)
                          : Radius.circular(0),
                      topRight: Controllers
                                  .directionalityController.languageBox.value
                                  .read('language') ==
                              'ar'
                          ? Radius.circular(0)
                          : Radius.circular(12),
                    )),
                child: Utils.buildRatings(
                    ratings: offerRate.rate ?? 0.0,
                    iconSize: 15,
                    unratedColor: Colors.white),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 29,
                        height: 27,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(6)),
                            color: ColorConstants.greyContainerBackground),
                        child: Center(
                            child: Text(
                          offerRate.username![0].toString(),
                          style: TextStyle(
                              color: ColorConstants.black0,
                              fontSize: 14,
                              fontWeight: FontWeight.w600),
                        )),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                          width: MediaQuery.of(context).size.width - 93,
                          child: Row(
                            children: [
                              Text(offerRate.username.toString(),
                                  style: TextStyle(
                                      color: ColorConstants.black0,
                                      fontSize: 13,
                                      fontFamily: 'Noto Kufi Arabic',
                                      fontWeight: FontWeight.w600)),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '(${offerRate.rate ?? 0.0})',
                                style: const TextStyle(
                                  color: ColorConstants.mainColor,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 93,
                      child: Text(
                        Utils.getDateTime(
                            dateTime: offerRate.creation ?? DateTime.now()),
                        style: TextStyle(
                          color: ColorConstants.greyColor,
                          fontSize: 13,
                          fontFamily: 'Noto Kufi Arabic',
                        ),
                      ))
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
