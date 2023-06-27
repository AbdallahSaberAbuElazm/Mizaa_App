import 'package:carousel_slider/carousel_controller.dart';
import 'package:test_ecommerce_app/models/categories/CategoryModel.dart';
import 'package:test_ecommerce_app/models/categories/sub_categories/SubCategoriesModel.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/providers/CategoryProvider.dart';
import 'package:test_ecommerce_app/providers/OfferProvider.dart';
import 'package:test_ecommerce_app/shared/constants/ColorConstants.dart';
import 'package:test_ecommerce_app/shared/shared_preferences.dart';
import 'package:test_ecommerce_app/shared/utils.dart';
import 'package:test_ecommerce_app/views/home/tabs/order_tab.dart';
import 'package:test_ecommerce_app/views/home/tabs/offer_tab.dart';
import 'package:test_ecommerce_app/views/home/tabs/favorite_tab.dart';
import 'package:test_ecommerce_app/views/home/tabs/user_tab.dart';
import 'package:test_ecommerce_app/views/home/tabs/categories_tab.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final OfferProvider _offerProvider;
  HomeController(this._offerProvider);

  late PageController pageController;
  late CarouselController carouselController;
  late CarouselController carouselNewOfferController;
  final CategoryProvider _categoryProvider = Get.find();
  // late ProductProvider _productProvider = Get.find();

  // for home page carousel
  var currentPage = 0.obs;
  var currentBanner = 0.obs;
  // new offer
  var currentBannerNewOffer = 0.obs;

  // home page offers
  var activeCarouselOffers = <OfferModel>[].obs;
  var todayOffers = <OfferModel>[].obs;
  var specialOffers = <OfferModel>[].obs;
  var mostSellerOffers = <OfferModel>[].obs;

  // home page categories
  var mainCategories = <CategoryModel>[].obs;
  var subCategoryOutings = <SubCategoriesModel>[].obs;
  var subCategories = <SubCategoriesModel>[].obs;
  final selectedSubCategories = ''.obs;

  // category's offers
  var isLoadingOffersMainCategory = true.obs;
  var offersForMainCategory = <OfferModel>[].obs;
  var isLoadingOffersSubCategory = true.obs;
  var offersForSubCategory = <OfferModel>[].obs;

  // app bar for offer page
  late ScrollController scrollController;
  final isScrolled = false.obs;
  final appBarColor = Colors.transparent.obs;
  final appBarItemContainerColor = Colors.white.obs;
  final appBarItemColor = ColorConstants.mainColor.obs;

  // set language - country - city
  final dropLanguageData = '${SharedPreferencesClass.getLanguageName()}'.obs;
  final dropCountryData = ''.obs;
  final dropCityData = ''.obs;

  List<Widget> pages = [
    ExploreTab(),
    const OrderTab(),
     CategoriesTab(),
    const FavoriteTab(),
    UserTab(),
  ];

  @override
  void onInit() {
    pageController = PageController(initialPage: 0);
    carouselController = CarouselController();
    carouselNewOfferController = CarouselController();
    scrollController = ScrollController();
    scrollController = ScrollController()..addListener(_onScroll);

    getCarouselOffers();
    getTodayOffers();
    getSpecialOffers();
    getMostSalesOffers();
    getMostSalesOffers();
    getMainCategories();
    getSubCategoryOutings(categoryId: '1');
    super.onInit();
  }

  void getCarouselOffers() {
    _offerProvider
        .getCarouselOffers(
            cityId: SharedPreferencesClass.getCityId().toString())
        .then((offers) {
      activeCarouselOffers.value = offers;
    });
  }

  void _onScroll() {
    if (scrollController.offset > 80 && !isScrolled.value) {
      isScrolled.value = true;
      appBarColor.value = Get.isDarkMode? ColorConstants.bottomAppBarDarkColor: Colors.white;
      appBarItemContainerColor.value = ColorConstants.mainColor;
      appBarItemColor.value = Colors.white;
    } else if (scrollController.offset <= 80 && isScrolled.value) {
      isScrolled.value = false;
      appBarColor.value = Colors.transparent;
      appBarItemContainerColor.value = Colors.white;
      appBarItemColor.value = ColorConstants.mainColor;
    }
  }

  void getTodayOffers() {
    _offerProvider
        .getTodayOffers(cityId: SharedPreferencesClass.getCityId().toString())
        .then((offers) {
      todayOffers.value = offers;
    });
  }

  void getSpecialOffers() {
    _offerProvider
        .getSpecialOffers(cityId: SharedPreferencesClass.getCityId().toString())
        .then((offers) {
      specialOffers.value = offers;
    });
  }

  void getMostSalesOffers() {
    _offerProvider
        .getMostSalesOffers(
            cityId: SharedPreferencesClass.getCityId().toString())
        .then((offers) {
      mostSellerOffers.value = offers;
    });
  }

  void getMainCategories() {
    _categoryProvider.getMainCategories().then((categories) {
      mainCategories.value = categories;
    });
  }

  void getSubCategoryOutings({required String categoryId}) {
    _categoryProvider
        .getSubCategoriesByMainCategoryId(
            mainCategoryId: SharedPreferencesClass.getCityId().toString())
        .then((subCategoriesList) {
      subCategoryOutings.value = subCategoriesList;
    });
  }

  void getSubCategories({required String categoryId}) {
    _categoryProvider
        .getSubCategoriesByMainCategoryId(mainCategoryId: categoryId)
        .then((subCategoriesList) {
      subCategories.value = subCategoriesList;
      // selectedSubCategories.value =  Utils.getTranslatedText(arText:  subCategoriesList[0].arName.toString(), enText:  subCategoriesList[0].enName.toString()) ;
    });
  }

  void getOffersForMainCategories({
    required String categoryId,
  }) {
    isLoadingOffersMainCategory.value = true;
    _offerProvider
        .getOffersForMainCategories(
            categoryId: categoryId,
            city: SharedPreferencesClass.getCityId().toString())
        .then((offers) {
      offersForMainCategory.value = offers;
      isLoadingOffersMainCategory.value = false;
    });
  }

  void getOffersForSubCategories({required String subCategoryId}) {
    isLoadingOffersMainCategory.value = true;
    _offerProvider
        .getOffersForSubCategories(
            subCategoryId: subCategoryId,
            city: SharedPreferencesClass.getCityId().toString())
        .then((offers) {
      // offersForSubCategory.value = offers;
      offersForMainCategory.value = offers;
      isLoadingOffersMainCategory.value = false;
    });
  }

  void getOffersForFiltrationSubCategories(
      {
        // required String categoryId,
        required List<String> subCategoryIds}) {
    isLoadingOffersMainCategory.value = true;

      // _offerProvider
      //     .getOffersForMainCategories(
      //     categoryId: categoryId,
      //     city: SharedPreferencesClass.getCityId().toString())
      //     .then((offers) {
      //   // offersForSubCategory.value = offers;
      //   offersForMainCategory.value = offers.where((offer) => subCategoryIds.contains(offer.id.toString()))
      //       .toList();
      //   isLoadingOffersSubCategory.value = false;
      // });

  }

  // void getDiscountedProducts() {
  //   _offerProvider.getHotDealOffers().then((offers) {
  //     discountedProducts(offers);
  //     print(offers);
  //   });
  // }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void changeBanner(int index) {
    currentBanner.value = index;
  }

  void changeBannerNewOffer(int index) {
    currentBannerNewOffer.value = index;
  }

  @override
  void dispose() {
    pageController.dispose();
    scrollController.dispose();
    super.dispose();
  }
}
