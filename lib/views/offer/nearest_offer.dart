import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mizaa/controllers/cart/cart_controller.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/home/HomeController.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:mizaa/controllers/offers/search_binding.dart';
import 'package:mizaa/controllers/offers/search_offer_controller.dart';
import 'package:mizaa/models/favourite/favourite_model.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/cart/cart_screen.dart';
import 'package:mizaa/views/offer/offer_detail.dart';
import 'package:mizaa/views/widgets/center_image_for_empty_data.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/views/widgets/search_in_sub_categories.dart';
import 'package:mizaa/views/widgets/search_screen.dart';
import 'package:mizaa/views/widgets/shimmer_container.dart';
import 'package:mizaa/views/offer/OfferCard.dart';
import 'package:mizaa/views/offer/widget/sorted_by.dart';

class NearestOffer extends StatefulWidget {
  final List<OfferModel> offers;
  const NearestOffer({
    Key? key,
    required this.offers,
  }) : super(key: key);

  @override
  State<NearestOffer> createState() => _NearestOfferState();
}

class _NearestOfferState extends State<NearestOffer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
            value: SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
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
        toolbarHeight: 85,
        leading: Utils.buildLeadingAppBar(
          title: translation.nearOffersText.tr,
        ),
        leadingWidth: 260,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16, left: 16),
            child: _buildActionsAppBar(context: context),
          )
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(38.0),
            child: SearchInSubCategories(searchOnPressed: () {
              Get.put(SearchOfferController(Get.find()));
              Get.to(
                  () => SearchScreen(
                      typeOfSearch: TypeOfSearch.offersInMainCategory,
                      categoryId: -1),
                  binding: SearchBinding());
            }, sortedByOnPressed: () {
              Get.bottomSheet(const SortedBy());
            })),
      ),
      floatingActionButton: const ChattingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: OfferTab(
          offers: widget.offers,
        ),
      ),
    );
  }

  Widget _buildActionsAppBar({required BuildContext context}) {
    return Row(
      children: [
        appBarIcon(
            icon: Icons.notifications,
            iconColor: ColorConstants.mainColor,
            onTap: () {}),
        const SizedBox(
          width: 8,
        ),
        Stack(
          alignment: Alignment.center,
          children: [
            appBarIcon(
                icon: Icons.shopping_cart_rounded,
                iconColor: ColorConstants.mainColor,
                onTap: () {
                  if (SharedPreferencesClass.getToken() == null ||
                      SharedPreferencesClass.getToken() == '') {
                    Utils.showAlertDialogForRegisterLogin(context: context);
                  } else {
                    Get.put(CartController(Get.find()));
                    Get.to(() => const CartScreen(
                          comingForCart: ComingForCart.offerListCategory,
                        ));
                  }
                }),
            Controllers.cartController.cartItems.isNotEmpty
                ? Transform.translate(
                    offset: const Offset(-9, -18),
                    child: Align(
                        alignment: Controllers
                                    .directionalityController.languageBox.value
                                    .read('language') ==
                                'ar'
                            ? Alignment.centerLeft
                            : Alignment.centerRight,
                        child: Obx(() => Stack(
                              alignment: Alignment.center,
                              children: [
                                Container(
                                  width: 19,
                                  height: 19,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        offset: Offset(0,
                                            1.4), // controls the offset of the shadow
                                        blurRadius:
                                            3, // controls the blur radius of the shadow
                                        spreadRadius:
                                            0, // controls the spread radius of the shadow
                                      ),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Text(
                                      Controllers
                                          .cartController.cartItems.length
                                          .toString(),
                                      style: const TextStyle(
                                          color: ColorConstants.mainColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ))),
                  )
                : const SizedBox.shrink()
          ],
        ),
      ],
    );
  }

  Widget appBarIcon(
      {required IconData icon,
      required Color iconColor,
      required dynamic onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
          width: 37,
          height: 37,
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          child: Icon(
            icon,
            color: iconColor,
            size: 25,
          )),
    );
  }
}

class OfferTab extends StatefulWidget {
  final List<OfferModel> offers;
  const OfferTab({Key? key, required this.offers}) : super(key: key);
  @override
  State<OfferTab> createState() => _OfferTabState();
}

class _OfferTabState extends State<OfferTab> {
  final HomeController homeController = Get.find();

  @override
  void initState() {
    setState(() {
      Controllers.offerController.filteredListOfferMainCategory.value =
          widget.offers;
      homeController.selectedSubCategories.value = '';
    });

    Future.delayed(const Duration(milliseconds: 900), () {
      Controllers.homeController.isLoadingOffersMainCategory.value = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: ListView(physics: const ScrollPhysics(), children: [
        _buildMainCategory(),
        const SizedBox(
          height: 15,
        ),
        _buildListOfOffers()
      ]),
    );
  }

  Widget _buildMainCategory() {
    return SizedBox(
        height: 38,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => ListView.builder(
              itemCount: homeController.mainCategories.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      homeController.selectedSubCategories.value =
                          Utils.getTranslatedText(
                              arText: homeController
                                  .mainCategories[index].arName
                                  .toString(),
                              enText: homeController
                                  .mainCategories[index].enName
                                  .toString());
                    });
                    // homeController.getOffersForMainCategories(
                    //     categoryId:
                    //     homeController.mainCategories[index].id.toString());

                    Controllers.offerController.filteredListOfferMainCategory
                            .value =
                        widget.offers
                            .where((offer) =>
                                homeController.mainCategories[index].id ==
                                offer.companyId)
                            .toList();
                  },
                  child: Container(
                      height: 38,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 11, vertical: 4),
                      margin: const EdgeInsets.only(right: 4, left: 4),
                      decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        border: Border.all(
                            width: 0.5,
                            color: homeController.selectedSubCategories.value ==
                                    Utils.getTranslatedText(
                                        arText: homeController
                                            .mainCategories[index].arName
                                            .toString(),
                                        enText: homeController
                                            .mainCategories[index].enName
                                            .toString())
                                ? Colors.transparent
                                : ColorConstants.greyColor),
                        color: homeController.selectedSubCategories.value ==
                                Utils.getTranslatedText(
                                    arText: homeController
                                        .mainCategories[index].arName
                                        .toString(),
                                    enText: homeController
                                        .mainCategories[index].enName
                                        .toString())
                            ? ColorConstants.mainColor
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          homeController.mainCategories[index].arName,
                          style: TextStyle(
                            fontSize: 15,
                            color: homeController.selectedSubCategories.value ==
                                    Utils.getTranslatedText(
                                        arText: homeController
                                            .mainCategories[index].arName
                                            .toString(),
                                        enText: homeController
                                            .mainCategories[index].enName
                                            .toString())
                                ? Colors.white
                                : ColorConstants.greyColor,
                            height: 1.7,
                            fontFamily: 'Noto Kufi Arabic',
                          ),
                        ),
                      )),
                );
              }),
        ));
  }

  Widget _buildListOfOffers() {
    return Obx(
      () => Controllers.homeController.isLoadingOffersMainCategory.value == true
          ? ListView.builder(
              shrinkWrap: true,
              padding: const EdgeInsets.only(
                left: 12,
                right: 12,
                bottom: 5,
              ),
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 2,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: ShimmerContainer(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: 250,
                    topPadding: 0,
                    bottomPadding: 0,
                    rightPadding: 0,
                    leftPadding: 0),
              ),
            )
          :
          // widget.offers.isNotEmpty
          Controllers.offerController.filteredListOfferMainCategory.isNotEmpty
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  padding: const EdgeInsets.only(
                    left: 12,
                    right: 12,
                    bottom: 10,
                  ),
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: Controllers
                      .offerController.filteredListOfferMainCategory.length,
                  // widget.offers.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Get.put(OfferController(Get.find()));
                        Get.to(() => OfferDetail(
                            offerModel:
                                // widget.offers[index]
                                Controllers.offerController
                                    .filteredListOfferMainCategory[index]));
                      },
                      child: OfferCard(
                        isComingFromFavourite: false,
                        typeOfComingOffer:
                            TypeOfComingOffer.comingFromNearestOffer,
                        offerModel: Controllers.offerController
                            .filteredListOfferMainCategory[index],
                        onTapFavourite: () {
                          if (SharedPreferencesClass.getToken() == null ||
                              SharedPreferencesClass.getToken() == '') {
                            Utils.showAlertDialogForRegisterLogin(
                                context: context);
                          } else {
                            if (Controllers
                                .offerController
                                .filteredListOfferMainCategory[index]
                                .isFavourite!) {
                              Controllers.favouriteController
                                  .getUserFavourites()
                                  .then((favouriteList) {
                                FavouriteModel favouriteModel =
                                    favouriteList.firstWhere((offer) =>
                                        Controllers
                                            .offerController
                                            .filteredListOfferMainCategory[
                                                index]
                                            .id ==
                                        offer.offerId);
                                setState(() {
                                  Controllers
                                          .homeController.nearestOffers[index] =
                                      Controllers
                                          .homeController.nearestOffers[index]
                                          .copyWith(isFavourite: false);
                                });
                                Controllers.favouriteController
                                    .deleteFromFavourites(
                                        favouriteKey: favouriteModel.key,
                                        context: context);
                              });
                            } else {
                              Controllers.favouriteController.addToFavourites(
                                  offerId: Controllers.offerController
                                      .filteredListOfferMainCategory[index].id!,
                                  context: context);
                              setState(() {
                                Controllers
                                        .homeController.nearestOffers[index] =
                                    Controllers
                                        .homeController.nearestOffers[index]
                                        .copyWith(isFavourite: true);
                              });
                            }
                          }
                        },
                        width: MediaQuery.of(context).size.width,
                        height: 248,
                      ),
                    );
                  })
              : Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.width / 2),
                  child: CenterImageForEmptyData(
                      imagePath: 'assets/images/offer_empty.png',
                      text: translation.noOffersAvailable.tr),
                ),
    );
  }
}
