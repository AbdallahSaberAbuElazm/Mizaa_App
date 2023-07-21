import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_ecommerce_app/controllers/controllers.dart';
import 'package:test_ecommerce_app/controllers/favourite/favourite_controller.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/offer/OfferCard.dart';
import 'package:test_ecommerce_app/views/widgets/chatting_btn.dart';
import 'package:test_ecommerce_app/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:test_ecommerce_app/views/widgets/shimmer_container.dart';

class FavoriteTab extends GetView<FavouriteController> {
  const FavoriteTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Controllers.favouriteController.getUserFavourites();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: controller.appBarFavouriteTabColor.value,
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
        leadingWidth: 260,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
        ),
        leading: Padding(
          padding: EdgeInsets.only(
              right: Utils.rightPadding12Right, left: Utils.leftPadding12Left),
          child: Row(children: [
            Text(
              translation.favouriteText.tr,
              style: TextStyle(
                  color: Get.isDarkMode ? Colors.white : Colors.black,
                  fontSize: 15,
                  fontFamily: 'Noto Kufi Arabic',
                  fontWeight: FontWeight.bold),
            ),
          ]),
        ),
      ),
      floatingActionButton: const ChattingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: _drawFavouriteList(),
    );
  }

  Widget _drawFavouriteList() {
    // final HomeController homeController = HomeController(Get.find());
    return Obx(() => Controllers
                .favouriteController.isLoadingFavouriteList.value ==
            true
        ? ListView.builder(
            padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: ShimmerContainer(
                  width: MediaQuery.of(context).size.width / 1.3,
                  height: 248,
                  topPadding: 0,
                  bottomPadding: 0,
                  rightPadding: 0,
                  leftPadding: 0),
            ),
          )
        : (Controllers.favouriteController.favouriteList.isNotEmpty)
            ? ListView.builder(
                controller: controller.scrollFavouriteTabController,
                padding: const EdgeInsets.only(left: 12, right: 12, bottom: 12),
                itemCount: Controllers.favouriteController.favouriteList.length,
                itemBuilder: (context, index) {
                  final offerModel = OfferModel.fromJson(Controllers
                      .favouriteController.favouriteList[index].offer);
                  return OfferCard(
                      isComingFromFavourite: true,
                      offerModel: offerModel,
                      typeOfComingOffer: TypeOfComingOffer.comingFromOffer,
                      onTapFavourite: () {
                        Controllers.favouriteController
                            .deleteFromFavourites(
                                favouriteKey: Controllers.favouriteController
                                    .favouriteList[index].key,
                                context: context)
                            .then((value) {
                          if (value) {
                            print('value of delete is $value');
                            Controllers.homeController.getTodayOffers();
                            Controllers.homeController.getSpecialOffers();
                            Controllers.homeController.getMostSalesOffers();
                          }
                        });
                      },
                      width: MediaQuery.of(context).size.width,
                      height: 248);
                })
            : const SizedBox());
  }
}
