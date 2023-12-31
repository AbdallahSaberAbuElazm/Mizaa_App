import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mizaa/controllers/cart/cart_controller.dart';
import 'package:mizaa/controllers/companies/company_controller.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/home/HomeController.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:mizaa/controllers/offers/search_binding.dart';
import 'package:mizaa/controllers/offers/search_offer_controller.dart';
import 'package:mizaa/models/favourite/favourite_model.dart';
import 'package:mizaa/models/merchant/merchant_model.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/providers/company_provider.dart';
import 'package:mizaa/repositories/company_repository.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/cart/cart_screen.dart';
import 'package:mizaa/views/merchant/merchant_detail.dart';
import 'package:mizaa/views/offer/offer_detail.dart';
import 'package:mizaa/views/offer/widget/filtration_screen.dart';
import 'package:mizaa/views/offer/widget/merchant_logo.dart';
import 'package:mizaa/views/widgets/center_image_for_empty_data.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/views/widgets/search_screen.dart';
import 'package:mizaa/views/widgets/shimmer_container.dart';
import 'package:mizaa/views/offer/OfferCard.dart';
import 'package:mizaa/views/widgets/custom_texts.dart';
import 'package:mizaa/views/widgets/search_in_categories.dart';
import 'package:mizaa/views/offer/widget/sorted_by.dart';

enum TypeOfCategory { mainCategory, specificOffers }

class OfferListForMainCategoryPage extends StatefulWidget {
  final String mainCategoryName;
  final int categoryId;
  final TypeOfCategory typeOfCategory;
  final List<OfferModel> offers;
  const OfferListForMainCategoryPage(
      {Key? key,
      required this.mainCategoryName,
      required this.categoryId,
      required this.offers,
      required this.typeOfCategory})
      : super(key: key);

  @override
  State<OfferListForMainCategoryPage> createState() =>
      _OfferListForMainCategoryPageState();
}

class _OfferListForMainCategoryPageState
    extends State<OfferListForMainCategoryPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  int tabIndex = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        setState(() {
          switch (_tabController.index) {
            case 0:
              setState(() {
                tabIndex = 0;
              });
              break;
            case 1:
              setState(() {
                tabIndex = 1;
              });
              break;
          }
        });
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: ColorConstants.backgroundContainer,
      appBar: AppBar(
        elevation: 0,
        // backgroundColor: ColorConstants.backgroundContainer,
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
        toolbarHeight:
            widget.typeOfCategory == TypeOfCategory.mainCategory ? 125 : 85,
        leading: Utils.buildLeadingAppBar(
          title: widget.mainCategoryName,
        ),
        leadingWidth: 260,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, left: 12),
            child: _buildActionsAppBar(context: context),
          )
        ],
        bottom: PreferredSize(
            preferredSize: const Size.fromHeight(48.0),
            child: Column(
              children: [
                widget.typeOfCategory == TypeOfCategory.mainCategory
                    ? SearchInCategories(searchOnPressed: () {
                        Get.put(SearchOfferController(Get.find()));
                        Get.to(
                            () => SearchScreen(
                                typeOfSearch: (tabIndex == 0)
                                    ? TypeOfSearch.offersInMainCategory
                                    : TypeOfSearch.merchant,
                                categoryId: widget.categoryId),
                            binding: SearchBinding());
                      }, filterOnPressed: () {
                        setState(() {
                          Controllers
                              .offerController
                              .filteredListOfferMainCategory
                              .value = widget.offers;
                          Controllers
                              .homeController.selectedSubCategories.value = '';
                          Get.to(() => const FiltrationScreen());
                        });
                      }, sortedByOnPressed: () {
                        Get.bottomSheet(const SortedBy());
                      })
                    : const SizedBox.shrink(),
                TabBar(
                  padding: EdgeInsets.only(
                      left: 16,
                      right: 16,
                      top: widget.typeOfCategory == TypeOfCategory.mainCategory
                          ? 10
                          : 0),
                  controller: _tabController,
                  labelColor: ColorConstants
                      .mainColor, // Change the selected tab text color
                  unselectedLabelColor:
                      Get.isDarkMode ? Colors.white : ColorConstants.black0,
                  labelStyle: const TextStyle(
                      fontFamily: 'Noto Kufi Arabic',
                      fontSize: 15,
                      fontWeight: FontWeight.w700),
                  unselectedLabelStyle: TextStyle(
                      fontFamily: 'Noto Kufi Arabic',
                      fontSize: 15,
                      color: ColorConstants.greyColor,
                      fontWeight: FontWeight.w500),

                  dividerColor: ColorConstants.mainColor,
                  indicatorColor: ColorConstants.mainColor,
                  tabs: [
                    Tab(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/offer_icon.png',
                            width: 23,
                            height: 23,
                            color: tabIndex == 0
                                ? ColorConstants.mainColor
                                : ColorConstants.greyColor),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          translation.offersText.tr,
                        ),
                      ],
                    )),
                    Tab(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset('assets/images/merchant_icon.png',
                            width: 23,
                            height: 23,
                            color: tabIndex == 1
                                ? ColorConstants.mainColor
                                : ColorConstants.greyColor),
                        const SizedBox(
                          width: 7,
                        ),
                        Text(
                          translation.merchantsText.tr,
                        ),
                      ],
                    )),
                  ],
                ),
              ],
            )),
      ),
      floatingActionButton: const ChattingBtn(),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      body: Padding(
        padding: const EdgeInsets.only(top: 27),
        child: TabBarView(
          controller: _tabController,
          children: [
            OfferTab(
              typeOfCategory: widget.typeOfCategory,
              offers: widget.offers,
            ),
            MerchantTab(),
          ],
        ),
      ),
    );
  }

  Widget _buildActionsAppBar({required BuildContext context}) {
    return Row(
      children: [
        widget.typeOfCategory == TypeOfCategory.mainCategory
            ? const SizedBox.shrink()
            : appBarIcon(
                onTap: () {},
                icon: Icons.search,
                iconColor: ColorConstants.mainColor),
        const SizedBox(
          width: 8,
        ),
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
  final TypeOfCategory typeOfCategory;
  const OfferTab({Key? key, required this.typeOfCategory, required this.offers})
      : super(key: key);
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

    Future.delayed(const Duration(milliseconds: 1050), () {
      Controllers.homeController.isLoadingOffersMainCategory.value = false;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: ListView(physics: const ScrollPhysics(), children: [
            Controllers.offerController.filteredListOfferMainCategory.isNotEmpty
                ? widget.typeOfCategory == TypeOfCategory.mainCategory
                    ? _buildSubCategoriesForMainCategory()
                    : const SizedBox.shrink()
                : const SizedBox.shrink(),
            _buildListOfOffers()
          ])),
    );
  }

  Widget _buildSubCategoriesForMainCategory() {
    return SizedBox(
        height: 38,
        width: MediaQuery.of(context).size.width,
        child: Obx(
          () => ListView.builder(
              itemCount: homeController.subCategories.length,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              shrinkWrap: true,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      homeController.selectedSubCategories.value =
                          Utils.getTranslatedText(
                              arText: homeController.subCategories[index].arName
                                  .toString(),
                              enText: homeController.subCategories[index].enName
                                  .toString());
                    });
                    homeController.getOffersForSubCategories(
                        subCategoryId:
                            homeController.subCategories[index].id.toString());
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
                                            .subCategories[index].arName
                                            .toString(),
                                        enText: homeController
                                            .subCategories[index].enName
                                            .toString())
                                ? Colors.transparent
                                : ColorConstants.greyColor),
                        color: homeController.selectedSubCategories.value ==
                                Utils.getTranslatedText(
                                    arText: homeController
                                        .subCategories[index].arName
                                        .toString(),
                                    enText: homeController
                                        .subCategories[index].enName
                                        .toString())
                            ? ColorConstants.mainColor
                            : Colors.transparent,
                      ),
                      child: Center(
                        child: Text(
                          homeController.subCategories[index].arName,
                          style: TextStyle(
                            fontSize: 15,
                            color: homeController.selectedSubCategories.value ==
                                    Utils.getTranslatedText(
                                        arText: homeController
                                            .subCategories[index].arName
                                            .toString(),
                                        enText: homeController
                                            .subCategories[index].enName
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
              padding: EdgeInsets.only(
                  left: 12,
                  right: 12,
                  bottom: 5,
                  top: widget.typeOfCategory == TypeOfCategory.mainCategory
                      ? 20
                      : 0),
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
                  padding: EdgeInsets.only(
                      left: 12,
                      right: 12,
                      bottom: 10,
                      top: widget.typeOfCategory == TypeOfCategory.mainCategory
                          ? 20
                          : 0),
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
                        typeOfComingOffer: TypeOfComingOffer.comingFromOffer,
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
                                  Controllers.offerController
                                              .filteredListOfferMainCategory[
                                          index] =
                                      Controllers.offerController
                                          .filteredListOfferMainCategory[index]
                                          .copyWith(isFavourite: false);
                                });

                                print(
                                    'isFavourite for offerModel is ${Controllers.offerController.filteredListOfferMainCategory[index].isFavourite}');

                                Controllers.favouriteController
                                    .deleteFromFavourites(
                                        favouriteKey: favouriteModel.key,
                                        context: context);
                              });
                            } else {
                              setState(() {
                                Controllers.offerController
                                        .filteredListOfferMainCategory[index] =
                                    Controllers.offerController
                                        .filteredListOfferMainCategory[index]
                                        .copyWith(isFavourite: true);
                              });
                              Controllers.favouriteController.addToFavourites(
                                  offerId: Controllers.offerController
                                      .filteredListOfferMainCategory[index].id!,
                                  context: context);
                              print(
                                  'isFavourite for offerModel is ${Controllers.offerController.filteredListOfferMainCategory[index].isFavourite}');
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

class MerchantTab extends GetView<OfferController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => controller.merchants.isNotEmpty
        ? ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            itemCount: controller.merchants.length,
            itemBuilder: (context, index) {
              return _buildMerchantCard(
                  context: context, companyModel: controller.merchants[index]);
            })
        : CenterImageForEmptyData(
            imagePath: 'assets/images/merchant_empty.png',
            text: translation.noMerchantsAvailable.tr));
  }

  Widget _buildMerchantCard(
      {required BuildContext context, required MerchantModel companyModel}) {
    return GestureDetector(
      onTap: () {
        // print('merchant key is ${searchModel.key.toString()}');
        showDialog(
            context: context,
            builder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: ColorConstants.mainColor,
                )));
        Controllers.searchOfferController
            .getMerchant(merchantKey: companyModel.key.toString())
            .then((companyModel) {
          Get.back();
          Get.put(CompanyRepository());
          Get.put(CompanyProvider(Get.find()));
          Get.put(CompanyController(Get.find()));

          Get.to(
            () => MerchantDetail(
              companyModel: companyModel,
            ),
          );
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width,
          height: 88,
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            color: Colors.white,
          ),
          child: ListTile(
            leading: MerchantLogo(
                merchantLogo: companyModel.logo.toString(),
                containerWidth: 55,
                containerHeight: 60,
                logoWidth: 32,
                logoHeight: 32),
            trailing: Controllers.directionalityController.languageBox.value
                        .read('language') ==
                    'ar'
                ? Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: ColorConstants.greyColor,
                    size: 18,
                  )
                : Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: ColorConstants.greyColor,
                    size: 18,
                  ),
            title: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomTexts.textTitle(
                    text: translation.offerName.trParams({
                  'offerName': Utils.getTranslatedText(
                      arText: companyModel.arname.toString(),
                      enText: companyModel.enname.toString())
                })),
                const SizedBox(
                  height: 5,
                ),
                Container(
                  height: 22,
                  width: 70,
                  decoration: const BoxDecoration(
                    color: ColorConstants.mainColor,
                    borderRadius: BorderRadius.all(
                      Radius.circular(6),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    '${companyModel.count} ${translation.offersText.tr}',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontFamily: 'Noto Kufi Arabic',
                        height: 1.4),
                    // textAlign: TextAlign.center,
                  )),
                )
              ],
            ),
          )),
    );
  }
}
