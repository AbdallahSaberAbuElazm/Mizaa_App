import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/services.dart';
import 'package:mizaa/controllers/home/HomeController.dart';
import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:mizaa/controllers/controllers.dart';
import 'package:mizaa/controllers/offers/search_offer_controller.dart';
import 'package:mizaa/controllers/offers/search_binding.dart';
import 'package:mizaa/models/categories/CategoryModel.dart';
import 'package:mizaa/models/companies/CompanyModel.dart';
import 'package:mizaa/models/favourite/favourite_model.dart';
import 'package:mizaa/models/location/city/CityModel.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/views/cart/cart_screen.dart';
import 'package:mizaa/views/offer/offer_detail.dart';
import 'package:mizaa/views/offer/sub_categories.dart';
import 'package:mizaa/views/offer/OfferCard.dart';
import 'package:mizaa/views/offer/new_offer_card.dart';
import 'package:mizaa/views/offer/most_seller_offer_card.dart';
import 'package:mizaa/views/widgets/chatting_btn.dart';
import 'package:mizaa/views/widgets/custom_button.dart';
import 'package:mizaa/views/widgets/search_screen.dart';
import 'package:mizaa/views/widgets/shimmer_container.dart';
import 'package:mizaa/services/networking/ApiConstants.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mizaa/views/widgets/shimmer_list_view.dart';
import 'package:mizaa/views/offer/OfferListForMainCategoryPage.dart';
import 'package:mizaa/views/offer/OfferListForSubCategoryPage.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import 'package:mizaa/views/widgets/custom_text_line_through.dart';
import 'package:mizaa/views/widgets/custom_indicator_carousel.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;

class ExploreTab extends GetView<HomeController> {
  ExploreTab({Key? key}) : super(key: key);

  // final UserAuthenticationController userAuthenticationController = Get.find();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    // Get.put(CartController(Get.find()));

    controller.resetOfferPageScrolling();

    return Scaffold(
        body: Stack(children: <Widget>[
      Scaffold(
        extendBodyBehindAppBar: true, // Extend the body behind the app bar
        appBar: PreferredSize(
            preferredSize: Size(MediaQuery.of(context).size.width, 80),
            child: Obx(() => AppBar(
                backgroundColor: controller.appBarColor
                    .value, // Set the background color to transparent
                flexibleSpace: AnnotatedRegion<SystemUiOverlayStyle>(
                    value: SystemUiOverlayStyle(
                      statusBarColor: Colors.transparent,
                      statusBarIconBrightness:
                          controller.appBarColor.value == Colors.white
                              ? Brightness.dark
                              : Brightness.light,
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
                title: _buildAppBar(context: context)))),
        floatingActionButton: const ChattingBtn(),
        floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
        body: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: ListView(
              controller: controller.scrollController,
              padding: EdgeInsets.zero,
              children: [
                Obx(() => _buildOfferCarousel(context)),
                Transform.translate(
                    offset: const Offset(0, -50),
                    child: Obx(() => CustomIndicatorCarousel(
                        list: controller.activeCarouselOffers,
                        currentBanner: controller.currentBanner.value))),

                _buildCashback(context: context),

                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                    height: 118,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(
                      () => (controller.mainCategories.isNotEmpty)
                          ? ListView(
                              physics: const ScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              children: [
                                _buildLocationCategory(
                                    theme: theme, context: context),
                                _buildCategories(theme),
                              ],
                            )
                          : Padding(
                              padding: EdgeInsets.only(
                                  left: Utils.leftPadding10FromRight,
                                  right: Utils.rightPadding10FromLeft),
                              child: ShimmerListView(
                                width: 118,
                                height: 112,
                                topPadding: 0,
                                bottomPadding: 0,
                                leftPadding: Utils.leftPadding4FromRight,
                                rightPadding: Utils.rightPadding4FromLeft,
                              ),
                            ),
                    )),
                const SizedBox(
                  height: 23,
                ),
                _buildSection(
                    title: translation.hotOffersText.tr,
                    onPressed: () {
                      controller.isLoadingOffersMainCategory.value = false;
                      Get.to(
                        () =>
                            // HomePage(recentPage:
                            OfferListForMainCategoryPage(
                                typeOfCategory: TypeOfCategory.specificOffers,
                                mainCategoryName: translation.hotOffersText.tr,
                                categoryId: -1,
                                offers: Controllers.homeController.todayOffers),
                        // selectedIndex: 0)
                      );
                      Get.put(OfferController(Get.find()))
                          .getMerchant(catId: '1');
                    },
                    theme: theme),
                const SizedBox(
                  height: 14,
                ),
                // TODO Controllers.homeController.todayOffers
                Obx(() => (Controllers.homeController.todayOffers.isNotEmpty)
                    ? _buildTheHotOffers(
                        // offerModels: Controllers.homeController.todayOffers,
                        theme: theme,
                      )
                    : _shimmerForListViewForOffer(height: 245)),
                const SizedBox(
                  height: 23,
                ),
                _buildSection(
                    title: translation.outingsText.tr,
                    onPressed: () {
                      Get.to(
                        () =>
                            // HomePage(recentPage:
                            SubCategoryPage(
                                categories: controller.subCategoryOutings,
                                subCategoryName: translation.outingsText.tr),
                        // selectedIndex: 0)
                      );
                    },
                    theme: theme),
                const SizedBox(
                  height: 14,
                ),
                _buildSubCategoryOutings(theme),
                const SizedBox(
                  height: 23,
                ),
                _buildSection(
                    title: translation.mostSellerText.tr,
                    onPressed: () {
                      controller.isLoadingOffersMainCategory.value = false;
                      Get.to(
                        () =>
                            // HomePage(recentPage:
                            OfferListForMainCategoryPage(
                                typeOfCategory: TypeOfCategory.specificOffers,
                                mainCategoryName: translation.mostSellerText.tr,
                                categoryId: -1,
                                offers: Controllers
                                    .homeController.mostSellerOffers),
                        // selectedIndex:0)
                      );
                      Get.put(OfferController(Get.find()))
                          .getMerchant(catId: '1');
                    },
                    theme: theme),
                const SizedBox(
                  height: 14,
                ),
                Obx(() =>
                    (Controllers.homeController.mostSellerOffers.isNotEmpty)
                        ? _buildMostSellerOffers(
                            offerModels:
                                Controllers.homeController.mostSellerOffers,
                            theme: theme,
                          )
                        : _shimmerForListViewForOffer(height: 231)),
                const SizedBox(
                  height: 23,
                ),
                _buildSection(
                    title: translation.newOfferText.tr,
                    onPressed: () {
                      Get.to(() =>
                              // HomePage(recentPage:
                              OfferListForMainCategoryPage(
                                  typeOfCategory: TypeOfCategory.specificOffers,
                                  mainCategoryName: translation.newOfferText.tr,
                                  categoryId: -1,
                                  offers:
                                      Controllers.homeController.specialOffers)
                          // , selectedIndex: 0)
                          );
                      Get.put(OfferController(Get.find()))
                          .getMerchant(catId: '1');
                    },
                    theme: theme),
                const SizedBox(
                  height: 14,
                ),
                Obx(() => (Controllers.homeController.specialOffers.isNotEmpty)
                    ? _buildNewOfferCard(
                        offerModels: Controllers.homeController.specialOffers,
                        theme: theme,
                        context: context)
                    // Obx(() => (Controllers.homeController.todayOffers.isNotEmpty)
                    //     ? _buildNewOfferCard(
                    //         offerModels: Controllers.homeController.todayOffers,
                    //         theme: theme,
                    //         context: context)
                    : _shimmerForListViewForOffer(height: 123)),

                const SizedBox(
                  height: 23,
                ),

                Obx(() => CustomIndicatorCarousel(
                    list: Controllers.homeController.specialOffers,
                    currentBanner: controller.currentBannerNewOffer.value)),
                const SizedBox(
                  height: 25,
                ),
              ]),
        ),
      )
    ]));
  }

  ////////////////////////////////////////////////
  Widget _buildAppBar({required BuildContext context}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        appBarDropDown(context: context),
        Row(
          children: [
            Obx(() => appBarIcon(
                onPressed: () {
                  Get.put(SearchOfferController(Get.find()));
                  Get.to(
                      () => SearchScreen(
                          typeOfSearch: TypeOfSearch.globalSearchWithCity,
                          categoryId: -1),
                      binding: SearchBinding());
                },
                icon: Icons.search,
                containerColor: controller.appBarItemContainerColor.value,
                iconColor: controller.appBarItemColor.value)),
            const SizedBox(
              width: 6,
            ),
            Obx(() => appBarIcon(
                onPressed: () {},
                icon: Icons.notifications,
                containerColor: controller.appBarItemContainerColor.value,
                iconColor: controller.appBarItemColor.value)),
            const SizedBox(
              width: 6,
            ),
            Obx(() => Stack(
                  alignment: Alignment.center,
                  children: [
                    appBarIcon(
                        onPressed: () {
                          if (SharedPreferencesClass.getToken() == null ||
                              SharedPreferencesClass.getToken() == '') {
                            Utils.showAlertDialogForRegisterLogin(
                                context: context);
                          } else {
                            Get.to(() => const CartScreen(
                                  comingForCart: ComingForCart.homPage,
                                ));
                          }
                        },
                        icon: Icons.shopping_cart_rounded,
                        containerColor:
                            controller.appBarItemContainerColor.value,
                        iconColor: controller.appBarItemColor.value),
                    Controllers.cartController.cartItems.isNotEmpty
                        ? Transform.translate(
                            offset: const Offset(-9, -18),
                            child: Align(
                                alignment: Controllers.directionalityController
                                            .languageBox.value
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
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.white,
                                            boxShadow: [
                                              BoxShadow(
                                                color: ColorConstants.gray100,
                                                offset: const Offset(0,
                                                    2), // controls the offset of the shadow
                                                blurRadius:
                                                    4, // controls the blur radius of the shadow
                                                spreadRadius:
                                                    0, // controls the spread radius of the shadow
                                              ),
                                            ],
                                          ),
                                        ),
                                        Center(
                                          child: Text(
                                              Controllers.cartController
                                                  .cartItems.length
                                                  .toString(),
                                              style: const TextStyle(
                                                  color:
                                                      ColorConstants.mainColor,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                      ],
                                    ))),
                          )
                        : const SizedBox.shrink()
                  ],
                )),
          ],
        )
      ],
    );
  }

  Widget appBarDropDown({required BuildContext context}) {
    CityModel city = Controllers.directionalityController.cities
        .where((city) =>
            city.id == int.parse(SharedPreferencesClass.getCityId().toString()))
        .single;
    return GestureDetector(
      onTap: () => _buildBottomSheet(context: context),
      child: Container(
        height: 37,
        width: 140,
        padding: const EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(Radius.circular(12)),
            color: controller.appBarItemContainerColor.value),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(
              Icons.location_on_sharp,
              color: controller.appBarItemColor.value,
              size: 24,
            ),
            const SizedBox(width: 3),
            Text(
              Utils.getTranslatedText(arText: city.arName, enText: city.enName),
              style: TextStyle(
                color: controller.appBarItemColor.value,
                fontFamily: 'Noto Kufi Arabic',
                fontSize: 13,
              ),
            ),
            const SizedBox(width: 3),
            Icon(
              Icons.arrow_drop_down,
              color: controller.appBarItemColor.value,
              size: 24,
            ),
          ],
        ),
      ),
    );
  }

  //to detect ( language - country - city)
  _buildBottomSheet({required BuildContext context}) {
    Get.bottomSheet(
        isDismissible: true,
        Container(
          padding: const EdgeInsets.all(14),
          height: 484,
          decoration: BoxDecoration(
              color:
                  Get.isDarkMode ? ColorConstants.darkMainColor : Colors.white,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              )),
          child: ListView(
            children: [
              _buildDropHeader(
                text: translation.language.tr,
              ),
              const SizedBox(
                height: 8,
              ),
              Obx(() => Utils.drawDropDownListStringsBtn(
                  leftPadding: 20,
                  rightPadding: 20,
                  optionName: translation.language.tr,
                  dropDownValue: Controllers
                      .directionalityController.dropLanguageData.value,
                  onChanged: (value) {
                    showDialog(
                        context: context,
                        builder: (context) => const Center(
                                child: CircularProgressIndicator(
                              color: ColorConstants.mainColor,
                            )));
                    Controllers.directionalityController.dropLanguageData
                        .value = value;

                    if (Controllers
                            .directionalityController.dropLanguageData.value ==
                        'العربية') {
                      Controllers.directionalityController.changeLanguage('ar');
                    } else if (Controllers
                            .directionalityController.dropLanguageData.value ==
                        'English') {
                      Controllers.directionalityController.changeLanguage('en');
                    }

                    Utils.updatePadding();

                    SharedPreferencesClass.setUserLanguageCode(
                        language: (Controllers.directionalityController
                                    .dropLanguageData.value ==
                                'العربية')
                            ? 'ar'
                            : 'en');
                    SharedPreferencesClass.setUserLanguageName(
                        language: Controllers
                            .directionalityController.dropLanguageData.value);

                    controller.dropCountryData.value = '';
                    controller.dropCityData.value = '';
                    Get.back();
                  },
                  menu: [
                    'العربية',
                    'English',
                  ],
                  context: context,
                  iconSize: 34,
                  containerColor: Colors.white,
                  containerBorderColor: ColorConstants.greyColor,
                  optionNameColor: ColorConstants.black0,
                  textColor: ColorConstants.black0)),
              const SizedBox(
                height: 14,
              ),
              _buildDropHeader(text: translation.selectCountry.tr),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Utils.drawDropDownListCountriesBtn(
                    optionName: translation.selectCountry.tr,
                    dropDownValue: controller.dropCountryData.value,
                    onChanged: (country) {
                      controller.dropCountryData.value =
                          Utils.getTranslatedText(
                              arText: country.arName, enText: country.enName);

                      Controllers.userAuthenticationController
                          .getCitiesForSelectedCountry(
                              countryId: country.id.toString());

                      controller.dropCityData.value = "";
                      controller.cityId.value = '';
                      controller.countryId.value = country.id.toString();
                    },
                    menu: Controllers.directionalityController.countries,
                    context: context,
                    iconSize: 34,
                    containerBorderColor: ColorConstants.greyColor,
                    textColor: ColorConstants.black0),
              ),
              const SizedBox(
                height: 14,
              ),
              _buildDropHeader(text: translation.selectCity.tr),
              const SizedBox(
                height: 8,
              ),
              Obx(
                () => Utils.drawDropDownListCitiesBtn(
                    optionName: translation.selectCity.tr,
                    dropDownValue: controller.dropCityData.value,
                    onChanged: (city) {
                      controller.dropCityData.value = Utils.getTranslatedText(
                          arText: city.arName, enText: city.enName);

                      controller.cityId.value = city.id.toString();
                    },
                    menu: Controllers
                        .userAuthenticationController.citiesForSelectedCountry,
                    context: context,
                    iconSize: 34,
                    containerBorderColor: ColorConstants.greyColor,
                    textColor: ColorConstants.black0),
              ),
              const SizedBox(
                height: 30,
              ),
              CustomButton(
                  btnText: translation.saveText.tr,
                  textColor: Colors.white,
                  textSize: 17,
                  btnBackgroundColor: ColorConstants.mainColor,
                  btnOnpressed: () {
                    if (controller.countryId.value != '' &&
                        controller.cityId.value != '') {
                      // print('city id is ${Controllers.directionalityController.cityId.value} country id is ${Controllers.directionalityController.countryId.value}');
                      Get.back();
                      Controllers.directionalityController.countryId.value =
                          controller.countryId.value;
                      Controllers.directionalityController.cityId.value =
                          controller.cityId.value;
                      showDialog(
                          context: context,
                          builder: (context) => const Center(
                                  child: CircularProgressIndicator(
                                color: ColorConstants.mainColor,
                              )));
                      ////// language //////
                      if (Controllers.directionalityController.dropLanguageData
                              .value ==
                          'العربية') {
                        Controllers.directionalityController
                            .changeLanguage('ar');
                      } else if (Controllers.directionalityController
                              .dropLanguageData.value ==
                          'English') {
                        Controllers.directionalityController
                            .changeLanguage('en');
                      }

                      Utils.updatePadding();

                      ////// country //////
                      SharedPreferencesClass.setUserCountryId(
                          countryId: Controllers
                              .directionalityController.countryId.value);
                      ////// city //////
                      Controllers.userAuthenticationController.getCities(
                          countryId: Controllers
                              .directionalityController.countryId
                              .toString());
                      SharedPreferencesClass.setUserCity(
                          cityId: Controllers
                              .directionalityController.cityId.value);
                      ////// get offers based on city id //////
                      controller.getCarouselOffers();
                      Controllers.homeController.getTodayOffers();
                      Controllers.homeController.getSpecialOffers();
                      Controllers.homeController.getMostSalesOffers();
                      controller.getMainCategories();
                      controller.getSubCategoryOutings(categoryId: '1');
                      Get.back();
                    } else {
                      Get.snackbar(translation.selectLocation.tr,
                          translation.completeDataText.tr,
                          backgroundColor: ColorConstants.redColor,
                          colorText: Colors.white,
                          snackPosition: SnackPosition.BOTTOM,
                          borderRadius: 12.0,
                          margin: const EdgeInsets.all(14));
                    }
                  }),
            ],
          ),
        ));
  }

  Widget _buildDropHeader({required String text}) {
    return Text(text,
        style: TextStyle(
          color: Get.isDarkMode ? Colors.white : ColorConstants.black0,
          fontSize: 17,
          fontWeight: FontWeight.w500,
          fontFamily: 'Noto Kufi Arabic',
        ));
  }

  Widget appBarIcon(
      {required IconData icon,
      required Color containerColor,
      required Color iconColor,
      required dynamic onPressed}) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
          width: 37,
          height: 37,
          decoration:
              BoxDecoration(shape: BoxShape.circle, color: containerColor),
          child: Icon(
            icon,
            color: iconColor,
            size: 24,
          )),
    );
  }

  // build Carousel for offers
  Widget _buildOfferCarousel(context) {
    return SizedBox(
      height: 290,
      width: MediaQuery.of(context).size.width,
      child: Stack(
        children: [
          SizedBox(
            height: 290,
            width: MediaQuery.of(context).size.width,
            child: CarouselSlider.builder(
                carouselController: controller.carouselController,
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  viewportFraction: 1,
                  aspectRatio: 1,
                  initialPage: 0,
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  onPageChanged: (index, reason) =>
                      controller.changeBanner(index),
                ),
                itemCount: controller.activeCarouselOffers.length,
                itemBuilder: (BuildContext contextCarousel, int itemIndex,
                    int pageViewIndex) {
                  if (controller.activeCarouselOffers.isNotEmpty &&
                      itemIndex < controller.activeCarouselOffers.length) {
                    return _buildCarouselItem(
                        controller.activeCarouselOffers[itemIndex], context);
                  } else {
                    return ShimmerContainer(
                      width: MediaQuery.of(context).size.width,
                      height: 290,
                      topPadding: 0,
                      bottomPadding: 0,
                      leftPadding: 14,
                      rightPadding: 14,
                    );
                  }
                }),
          ),
          Transform.translate(
            offset: const Offset(0, 2),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 18,
                decoration: BoxDecoration(
                    color: Get.isDarkMode
                        ? ColorConstants.darkMainColor
                        : ColorConstants.backgroundContainer,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(12),
                        topLeft: Radius.circular(12))),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCashback({required BuildContext context}) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: 78,
          margin: const EdgeInsets.symmetric(horizontal: 14),
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(12)),
            gradient: LinearGradient(
              begin: Alignment.topRight,
              end: Alignment.bottomLeft,
              colors: [ColorConstants.mainColor, Colors.white],
            ),
          ),
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  translation.cashbackSentence.tr,
                  style: TextStyle(
                      color: ColorConstants.black0,
                      fontSize: 14.5,
                      height: 1.4,
                      fontWeight: FontWeight.w500),
                ),
                const SizedBox(
                  height: 5,
                ),
                SizedBox(
                    width: 120,
                    height: 27,
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            elevation: 0,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6),
                            )),
                        onPressed: () {},
                        child: Text(
                          translation.useNow.tr,
                          style: const TextStyle(
                              color: ColorConstants.mainColor,
                              fontSize: 12,
                              fontFamily: 'Noto Kufi Arabic',
                              fontWeight: FontWeight.w600),
                        )))
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 22, top: 4),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Image.asset(
              'assets/images/cashback.png',
              width: 129,
              height: 71,
              fit: BoxFit.cover,
            ),
          ),
        )
      ],
    );
  }

  // build carousel item
  Widget _buildCarouselItem(OfferModel offer, BuildContext context) {
    CompanyModel companyModel = CompanyModel.fromJson(
        offer.company!.map((key, value) => MapEntry(key.toString(), value)));
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) => const Center(
                    child: CircularProgressIndicator(
                  color: ColorConstants.mainColor,
                )));
        Controllers.offerController
            .getOffer(offerKey: offer.key.toString())
            .then((offer) {
          Get.back();
          Get.put(OfferController(Get.find()));
          Controllers.offerController.cartItemsOfferDetail.clear();
          Controllers.offerController.cartItemsOfferDetail.clear();
          Get.to(() => OfferDetail(offerModel: offer));
        });
      },
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
                image: DecorationImage(
              image: CachedNetworkImageProvider(
                ApiConstants.storageURL + offer.mainImage.toString(),
              ),
              fit: BoxFit.cover,
            )),
          ),
          Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.black.withAlpha(110),
              ),
              child: Padding(
                padding: EdgeInsets.only(
                    bottom: 50,
                    right: Utils.rightPadding12Right,
                    left: Utils.leftPadding12Left),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        translation.companyName.trParams({
                          'companyName': Utils.getTranslatedText(
                              arText: companyModel.arName.toString(),
                              enText: companyModel.enName.toString())
                        }),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontFamily: 'Noto Kufi Arabic',
                            fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                              width: MediaQuery.of(context).size.width * 0.66,
                              height: 60,
                              child: Text(
                                translation.companyName.trParams({
                                  'companyName': Utils.getTranslatedText(
                                      arText: offer.arTitle.toString(),
                                      enText: offer.enTitle.toString())
                                }),
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontFamily: 'Noto Kufi Arabic',
                                    height: 1.3,
                                    fontWeight: FontWeight.w600),
                              )),
                          Container(
                            decoration: BoxDecoration(
                                color: ColorConstants.mainColor,
                                borderRadius: BorderRadius.only(
                                    topRight: Controllers
                                                .directionalityController
                                                .languageBox
                                                .value
                                                .read('language') ==
                                            'ar'
                                        ? Radius.circular(12)
                                        : Radius.circular(0),
                                    bottomRight: Controllers
                                                .directionalityController
                                                .languageBox
                                                .value
                                                .read('language') ==
                                            'ar'
                                        ? Radius.circular(12)
                                        : Radius.circular(0),
                                    topLeft:
                                        Controllers.directionalityController.languageBox.value.read('language') == 'ar'
                                            ? Radius.circular(0)
                                            : Radius.circular(12),
                                    bottomLeft:
                                        Controllers.directionalityController.languageBox.value.read('language') == 'ar'
                                            ? Radius.circular(0)
                                            : Radius.circular(12))),
                            padding: const EdgeInsets.only(
                                left: 8, right: 8, top: 5, bottom: 5),
                            child: Text(
                              '${offer.enDiscount}% \n${translation.discountName.tr}',
                              style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontFamily: 'Noto Kufi Arabic',
                                  height: 1.3,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          _buildPriceContainer(
                              text:
                                  '${offer.priceAfterDiscount.toString()}${translation.currencyName.tr}'),
                          const SizedBox(
                            width: 9,
                          ),
                          CustomTextLineThrough(
                              text: offer.priceBeforDiscount.toString(),
                              textColor: Colors.white),
                        ],
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }

  Widget _buildPriceContainer({required String text}) {
    return Container(
      height: 24,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(left: 5, right: 5),
      decoration: const BoxDecoration(
        color: ColorConstants.mainColor,
        borderRadius: BorderRadius.all(
          Radius.circular(8),
        ),
      ),
      child: Center(
          child: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 13),
        textAlign: TextAlign.center,
      )),
    );
  }

  // build outings
  _buildSubCategoryOutings(ThemeData theme) {
    return SizedBox(
        height: 84,
        child: Obx(() => (controller.subCategoryOutings.isNotEmpty)
            ? ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemCount: controller.subCategoryOutings.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      controller.getOffersForSubCategories(
                        subCategoryId:
                            controller.subCategoryOutings[index].id.toString(),
                      );
                      Get.to(
                        () =>
                            // HomePage(recentPage:
                            OfferListForSubCategoryPage(
                          mainCategoryName: Utils.getTranslatedText(
                              arText:
                                  controller.subCategoryOutings[index].arName,
                              enText:
                                  controller.subCategoryOutings[index].enName),
                          categoryId: controller.subCategoryOutings[index].id,
                        ),
                        // selectedIndex: 0)
                      );
                    },
                    child: Container(
                        width: 235,
                        height: 84,
                        clipBehavior: Clip.hardEdge,
                        margin: const EdgeInsets.only(right: 4, left: 4),
                        decoration: BoxDecoration(
                          // boxShadow:const [
                          //   BoxShadow(
                          //     color: Colors.grey,
                          //     offset: Offset(0, 1.4), // controls the offset of the shadow
                          //     blurRadius: 3, // controls the blur radius of the shadow
                          //     spreadRadius: 0, // controls the spread radius of the shadow
                          //   ),
                          // ],
                          borderRadius: BorderRadius.circular(12),
                          color: Get.isDarkMode
                              ? ColorConstants.gray700
                              : Colors.grey.shade200,
                          border: Border.all(
                              color: Get.isDarkMode
                                  ? Colors.transparent
                                  : Colors.grey.shade200,
                              width: 1),
                        ),
                        child: Stack(
                          children: [
                            SizedBox(
                              height: 210,
                              width: double.infinity,
                              child: CachedNetworkImage(
                                imageUrl: ApiConstants.storageURL +
                                    controller
                                        .subCategoryOutings[index].imageUrl
                                        .toString(),
                                fit: BoxFit.cover,
                              ),
                            ),
                            Positioned(
                                top: 0,
                                left: 0,
                                right: 0,
                                bottom: 0,
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Colors.black.withAlpha(110),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      left: 17,
                                      bottom: 8,
                                      right: 17,
                                    ),
                                    child: Align(
                                      alignment: Controllers
                                                  .directionalityController
                                                  .languageBox
                                                  .value
                                                  .read('language') ==
                                              'ar'
                                          ? Alignment.bottomRight
                                          : Alignment.bottomLeft,
                                      child: SizedBox(
                                        height: 28,
                                        child: Text(
                                            Controllers.directionalityController
                                                        .languageBox.value
                                                        .read('language') ==
                                                    'ar'
                                                ? controller
                                                    .subCategoryOutings[index]
                                                    .arName
                                                    .toString()
                                                : controller
                                                    .subCategoryOutings[index]
                                                    .enName
                                                    .toString(),
                                            style: theme.textTheme.headline6!
                                                .copyWith(
                                                    fontSize: 13.0,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white)),
                                      ),
                                    ),
                                  ),
                                )),
                          ],
                        )),
                  );
                })
            : _shimmerForListViewForOffer(height: 160)));
  }

  // build section title, show all btn
  Widget _buildSection(
      {required String title,
      required dynamic onPressed,
      required ThemeData theme}) {
    return Padding(
      padding: EdgeInsets.only(
          left: Utils.leftPadding12Left, right: Utils.rightPadding12Right),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: theme.textTheme.subtitle1?.copyWith(
                fontWeight: FontWeight.bold, fontSize: 15, height: 1.1),
          ),
          SizedBox(
            height: 28,
            child: MaterialButton(
              onPressed: onPressed,
              minWidth: 50,
              splashColor: theme.primaryColor.withAlpha(10),
              highlightColor: theme.primaryColor.withAlpha(30),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(80)),
              child: Row(
                children: [
                  Text(
                    translation.moreOffersText.tr,
                    style: const TextStyle(
                        color: ColorConstants.mainColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 15,
                    color: ColorConstants.mainColor,
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // build list of categories
  Widget _buildCategories(ThemeData theme) {
    return SizedBox(
        height: 116,
        child: Obx(() => ListView.builder(
            padding: EdgeInsets.only(
                right: Utils.leftPadding12Left,
                left: Utils.rightPadding12Right),
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: controller.mainCategories.length,
            itemBuilder: (context, index) {
              return _buildCategory(
                  category: controller.mainCategories[index],
                  imageIcon: Utils.categoryImageIcon[index],
                  index: index,
                  theme: theme);
            })));
  }

  // build category
  Widget _buildCategory(
      {required CategoryModel category,
      required String imageIcon,
      required index,
      required theme}) {
    return GestureDetector(
      onTap: () {
        controller.getOffersForMainCategories(
          categoryId: category.id.toString(),
        );
        controller.getSubCategories(categoryId: category.id.toString());
        Controllers.homeController.isLoadingOffersMainCategory.value = true;
        Get.to(() =>
                // HomePage(recentPage:
                OfferListForMainCategoryPage(
                  typeOfCategory: TypeOfCategory.mainCategory,
                  mainCategoryName: translation.categoryName.trParams({
                    'categoryName': Utils.getTranslatedText(
                        arText: category.arName.toString(),
                        enText: category.enName.toString())
                  }),
                  categoryId: int.parse(category.id.toString()),
                  offers: controller.offersForMainCategory,
                )
            // selectedIndex: 0)
            );
        Get.put(OfferController(Get.find()))
            .getMerchant(catId: category.id.toString());
      },
      child: ZoomTapAnimation(
        beginDuration: const Duration(milliseconds: 300),
        endDuration: const Duration(milliseconds: 500),
        child: Container(
          width: 112,
          height: 118,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.only(
            right: Utils.rightPadding10Right,
            left: Utils.leftPadding10Left,
          ),
          child: Stack(
            children: [
              Container(
                width: 120,
                height: 118,
                child: CachedNetworkImage(
                  imageUrl: ApiConstants.storageURL + category.imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(110),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 10, right: 10, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          imageIcon,
                          width: 23,
                          height: 23,
                          color: Colors.white,
                        ),
                        Text(
                          translation.categoryName.trParams({
                            'categoryName': Controllers.directionalityController
                                        .languageBox.value
                                        .read('language') ==
                                    'ar'
                                ? category.arName.toString()
                                : category.enName.toString()
                          }),
                          style: theme.textTheme.subtitle1?.copyWith(
                              color: Colors.white,
                              fontSize: 13.0,
                              height: 1.2,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLocationCategory(
      {required theme, required BuildContext context}) {
    return GestureDetector(
      onTap: () {
        Utils.getCurrentPosition(context: context);
      },
      child: ZoomTapAnimation(
        beginDuration: const Duration(milliseconds: 300),
        endDuration: const Duration(milliseconds: 500),
        child: Container(
          width: 132,
          height: 116,
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          margin: EdgeInsets.only(
              right: Utils.rightPadding12Right, left: Utils.leftPadding12Left),
          child: Stack(
            children: [
              SizedBox(
                width: 132,
                height: 118,
                child: Image.asset(
                  'assets/images/location_category.png',
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withAlpha(110),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 15, left: 10, right: 10, bottom: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          'assets/images/location.png',
                          width: 23,
                          height: 23,
                          color: Colors.white,
                        ),
                        Text(
                          translation.nearOffersText.tr,
                          style: theme.textTheme.subtitle1?.copyWith(
                              color: Colors.white,
                              fontSize: 9.5,
                              height: 1.2,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          width: 112,
                          height: 30,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(
                                Radius.circular(12),
                              )),
                          child: Text(
                            translation.exploreLocationText.tr,
                            style: const TextStyle(
                                color: ColorConstants.mainColor,
                                fontSize: 12,
                                fontWeight: FontWeight.w600),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  // build list of offers
  Widget _buildTheHotOffers(
      {
      // required List<OfferModel> offerModels,
      required ThemeData theme}) {
    return SizedBox(
      height: 245,
      child: Obx(
        () => ListView.builder(
          padding: EdgeInsets.only(
              right: Controllers.directionalityController.languageBox.value
                          .read('language') ==
                      'ar'
                  ? 2
                  : 12,
              left: Controllers.directionalityController.languageBox.value
                          .read('language') ==
                      'ar'
                  ? 12
                  : 2,
              top: 0,
              bottom: 0),
          scrollDirection: Axis.horizontal,
          itemCount: Controllers.homeController.todayOffers
              .length, // TODO Controllers.homeController.todayOffers
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                right: Utils.rightPadding10Right,
                left: Utils.leftPadding10Left,
              ),
              child: OfferCard(
                isComingFromFavourite: false,
                typeOfComingOffer: TypeOfComingOffer.comingFromOffer,
                offerModel: Controllers.homeController.todayOffers[
                    index], // TODO Controllers.homeController.todayOffers
                onTapFavourite: () {
                  if (SharedPreferencesClass.getToken() == null ||
                      SharedPreferencesClass.getToken() == '') {
                    Utils.showAlertDialogForRegisterLogin(context: context);
                  } else {
                    if (Controllers
                        .homeController.todayOffers[index].isFavourite!) {
                      Controllers.favouriteController
                          .getUserFavourites()
                          .then((favouriteList) {
                        FavouriteModel favouriteModel =
                            favouriteList.firstWhere((offer) =>
                                Controllers
                                    .homeController.todayOffers[index].id ==
                                offer.offerId);
                        Controllers.homeController.todayOffers[index] =
                            Controllers.homeController.todayOffers[index]
                                .copyWith(isFavourite: false);
                        Controllers.favouriteController.deleteFromFavourites(
                            favouriteKey: favouriteModel.key, context: context);
                      });
                    } else {
                      Controllers.homeController.todayOffers[index] =
                          Controllers.homeController.todayOffers[index]
                              .copyWith(isFavourite: true);
                      Controllers.favouriteController.addToFavourites(
                          offerId:
                              Controllers.homeController.todayOffers[index].id!,
                          context: context);
                    }
                  }
                },
                width: 290,
                height: 240,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildNewOfferCard(
      {required List<OfferModel> offerModels,
      required ThemeData theme,
      required BuildContext context}) {
    return Container(
        height: 129,
        padding: const EdgeInsets.only(top: 3, bottom: 1),
        child: CarouselSlider.builder(
            carouselController: controller.carouselNewOfferController,
            options: CarouselOptions(
              autoPlay: true,
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 1,
              initialPage: 0,
              autoPlayAnimationDuration: const Duration(milliseconds: 800),
              onPageChanged: (index, reason) =>
                  controller.changeBannerNewOffer(index),
            ),
            itemCount: offerModels.length,
            itemBuilder: (BuildContext contextCarousel, int itemIndex,
                int pageViewIndex) {
              return Padding(
                padding: const EdgeInsets.only(
                  right: 12,
                  left: 12,
                ),
                child: NewOfferCard(
                  index: itemIndex,
                  offerModel: offerModels[itemIndex],
                  width: MediaQuery.of(context).size.width,
                  // 336,
                  height: 123,
                ),
              );
            }));
  }

  // build list of offers
  Widget _buildMostSellerOffers(
      {required List<OfferModel> offerModels, required ThemeData theme}) {
    return SizedBox(
      height: 231,
      child: ListView.builder(
        padding: EdgeInsets.only(
            right: Controllers.directionalityController.languageBox.value
                        .read('language') ==
                    'ar'
                ? 2
                : 12,
            left: Controllers.directionalityController.languageBox.value
                        .read('language') ==
                    'ar'
                ? 12
                : 2,
            top: 0,
            bottom: 0),
        scrollDirection: Axis.horizontal,
        itemCount: offerModels.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: EdgeInsets.only(
              right: Utils.rightPadding10Right,
              left: Utils.leftPadding10Left,
            ),
            child: MostSellerOfferCard(
              index: index,
              offerModel: offerModels[index],
              width: 290,
              height: 219,
            ),
          );
        },
      ),
    );
  }

  // shimmer for offer's list
  Widget _shimmerForListViewForOffer({required double height}) {
    return ShimmerListView(
      width: 290,
      height: height,
      topPadding: 0,
      bottomPadding: 0,
      leftPadding: Utils.leftPadding4FromLeft,
      rightPadding: Utils.rightPadding4FromRight,
    );
  }
}
