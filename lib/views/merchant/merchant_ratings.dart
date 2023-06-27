import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:test_ecommerce_app/models/offers/offer_rate/OfferRateModel.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/widgets/center_image_for_empty_data.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';

class MerchantRatings extends GetView<OfferController> {
  const MerchantRatings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          // backgroundColor: ColorConstants.backgroundContainer,
          // extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor:
                // Colors.white,
                controller.appBarOfferRatingsColor.value,
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
          ),
          floatingActionButton: const ChattingBtn(),
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
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
                  :   CenterImageForEmptyData(imagePath: 'assets/images/merchant_empty.png', text: translation.noRatingsAvailable.tr),
        ));
  }

  Widget _buildRatingsCard(
      {required BuildContext context, required OfferRateModel offerRate}) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 108,
      padding: EdgeInsets.only(
          right: Utils.rightPadding16Right, left: Utils.leftPadding16Left),
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
              Container(
                width: 29,
                height: 27,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(Radius.circular(6)),
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
              Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 93,
                        child: Row(
                          children: [
                            Text(offerRate.username.toString(),
                                style:  TextStyle(
                                    color: ColorConstants.black0,
                                    fontSize: 13,fontFamily: 'Noto Kufi Arabic',
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
                    SizedBox(
                        width: MediaQuery.of(context).size.width - 93,
                        child: Text(
                          Utils.getDateTime(
                              dateTime: offerRate.creation ?? DateTime.now()),
                          style: TextStyle(
                            color: ColorConstants.greyColor,
                            fontSize: 13,fontFamily: 'Noto Kufi Arabic',
                          ),
                        ))
                  ])
            ],
          ),
        ],
      ),
    );
  }
}
