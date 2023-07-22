import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mizaa/models/cart/cart_item_model/cart_item_model.dart';
import 'package:mizaa/models/merchant/merchant_model.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/models/offers/offer_rate/OfferRateModel.dart';
import 'package:mizaa/providers/OfferProvider.dart';
import 'package:mizaa/shared/constants/ColorConstants.dart';
import 'package:mizaa/shared/shared_preferences.dart';
import 'package:mizaa/shared/utils.dart';
import 'package:mizaa/shared/language_translation/translation_keys.dart'
    as translation;

class OfferController extends GetxController with StateMixin {
  final OfferProvider _offerProvider;

  OfferController(this._offerProvider) {
    carouselController = CarouselController();
    scrollOfferDescriptionController = ScrollController()
      ..addListener(_onScrollOfferDescription);
    scrollMerchantOfferDetailController = ScrollController()
      ..addListener(_onScrollMerchantOfferDetail);
    scrollTermsConditionsController = ScrollController()
      ..addListener(_onScrollTermsConditions);
    scrollOfferRatingsController = ScrollController()
      ..addListener(_onScrollOfferRatings);
  }

  final TextEditingController quantityController = TextEditingController();

  var count = 0.obs;

  late PageController pageController;
  late CarouselController carouselController;

  // for offer images carousel
  var currentPage = 0.obs;
  var currentBanner = 0.obs;

  var userRating = 0.0.obs;

  var isLoadingMerchants = true.obs;
  final merchants = <MerchantModel>[].obs;

  ////////////// filtered list variables in offer main & sub category
  final filteredListOfferMainCategory = <OfferModel>[].obs;
  final filterCityId = ''.obs;
  final filterCityName = ''.obs;
  final filterCountryName = ''.obs;
  final filterCountryId = ''.obs;
  /////////////////

  var isLoadingOffer = true.obs;
  final offerModel = OfferModel(
    id: -1, key: '',
    arTitle: '',
    enTitle: '',
    arSubtitle: '',
    enSubtitle: '',
    arDiscrict: '',
    enDiscrict: '',
    arAddress: '',
    enAddress: '',
    arDiscount: 0.0,
    enDiscount: 0.0,
    priceBeforDiscount: 0.0,
    priceAfterDiscount: 0.0,
    arFeatures: '',
    enFeatures: '',
    arConditions: '',
    enConditions: '',
    arOfferDuration: '',
    enOfferDuration: '',
    companyId: -1,
    arCommunications: '',
    enCommunications: '',
    isSpecialOffer: false,
    arAttentionMessgae: '',
    enAttentionMessgae: '',
    creationDate: DateTime.now(),
    expireDate: DateTime.now(),
    cityId: -1,
    city: '',
    mainImage: '',
    image: '',
    companyLogoImage: '',
    latitude: '',
    longitude: '',
    subCategoryId: 0,
    salesCount: 0,
    // CompanyModel? company,
    company: {},
    offerImages: [],
    offerOptions: [],
    subCategory: {},
    userOfferActionHistories: '',
    isShowInHomePage: false,
    isTodayOffer: false,
    isNewest: false,
    isMostSales: false,
    isSpecial: false,
    offerRate: 0.0,
    offerRates: '',
  ).obs;

  final offerRatings = <OfferRateModel>[].obs;
  var isLoadingOfferRatings = true.obs;

  // list of selected offer options for  cart items
  final cartItemsOfferDetail = <CartItemModel>[].obs;

  // app bar for offer detail screen
  late ScrollController scrollOfferDescriptionController;
  final isScrolledOfferDescription = false.obs;
  final appBarOfferDescriptionColor = Colors.transparent.obs;
  final appBarItemContainerOfferDescriptionColor = Colors.white.obs;
  final statusIconBarOfferDescriptionColor = Brightness.light.obs;
  final appBarItemOfferDescriptionColor = ColorConstants.mainColor.obs;

  // scrolling for merchant offer detail screen
  late ScrollController scrollMerchantOfferDetailController;
  final isScrolledMerchantOfferDetail = false.obs;
  final appBarMerchantOfferDetailColor = Colors.transparent.obs;
  final appBarItemContainerMerchantOfferDetailColor = Colors.white.obs;
  final statusIconBarMerchantOfferDetailColor = Brightness.light.obs;
  final appBarItemMerchantOfferDetailColor = ColorConstants.mainColor.obs;

  // app bar for terms and conditions screen
  late ScrollController scrollTermsConditionsController;
  final isScrolledTermsConditions = false.obs;
  final appBarTermsConditionsColor = Colors.transparent.obs;
  final statusIconBarTermsConditionsColor = Brightness.light.obs;
  final appBarItemContainerTermsConditionsColor = Colors.white.obs;
  final appBarItemTermsConditionsColor = ColorConstants.mainColor.obs;

  // app bar for merchant ratings screen
  late ScrollController scrollOfferRatingsController;
  final isScrolledOfferRatings = false.obs;
  final appBarOfferRatingsColor = Colors.transparent.obs;
  final statusIconBarOfferRatingsColor = Brightness.light.obs;
  final appBarItemContainerOfferRatingsColor = Colors.white.obs;
  final appBarItemOfferRatingsColor = ColorConstants.mainColor.obs;

  resetOfferDetailScrolling() {
    isScrolledOfferDescription.value = false;
    appBarOfferDescriptionColor.value = Colors.transparent;
    statusIconBarOfferDescriptionColor.value = Brightness.light;
    appBarItemContainerOfferDescriptionColor.value = Colors.white;
    appBarItemOfferDescriptionColor.value = ColorConstants.mainColor;
  }

  resetMerchantOfferDetailScrolling() {
    isScrolledOfferDescription.value = false;
    appBarOfferDescriptionColor.value = Colors.transparent;
    statusIconBarOfferDescriptionColor.value = Brightness.light;
    appBarItemContainerOfferDescriptionColor.value = Colors.white;
    appBarItemOfferDescriptionColor.value = ColorConstants.mainColor;
  }

  resetTermsAndConditionsScrolling() {
    isScrolledTermsConditions.value = false;
    appBarTermsConditionsColor.value = Colors.transparent;
    statusIconBarTermsConditionsColor.value = Brightness.light;
    appBarItemContainerTermsConditionsColor.value = Colors.white;
    appBarItemTermsConditionsColor.value = ColorConstants.mainColor;
  }

  resetMerchantRatingsScrolling() {
    isScrolledOfferRatings.value = false;
    appBarOfferRatingsColor.value = Colors.transparent;
    statusIconBarOfferRatingsColor.value = Brightness.light;
    appBarItemContainerOfferRatingsColor.value = Colors.white;
    appBarItemOfferRatingsColor.value = ColorConstants.mainColor;
  }

  @override
  void onInit() {
    quantityController.text = count.value.toString();
    // carouselController = CarouselController();
    // scrollOfferDescriptionController = ScrollController()
    //   ..addListener(_onScrollOfferDescription);
    // scrollMerchantOfferDetailController = ScrollController()
    //   ..addListener(_onScrollMerchantOfferDetail);
    // scrollTermsConditionsController = ScrollController()
    //   ..addListener(_onScrollTermsConditions);
    // scrollOfferRatingsController = ScrollController()
    //   ..addListener(_onScrollOfferRatings);

    super.onInit();
  }

  // void fetchOffer(int id) {
  //   change(null, status: RxStatus.loading());
  //
  //
  //   _offerProvider.getOfferById(id).then((offer) {
  //     change(offer, status: RxStatus.success());
  //   }).catchError((error) {
  //     change(null, status: RxStatus.error(error));
  //   });
  // }

  void _onScrollOfferDescription() {
    if (scrollOfferDescriptionController.offset > 80 &&
        !isScrolledOfferDescription.value) {
      isScrolledOfferDescription.value = true;
      appBarOfferDescriptionColor.value =
          Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white;
      statusIconBarOfferDescriptionColor.value = Brightness.light;
      appBarItemContainerOfferDescriptionColor.value = ColorConstants.mainColor;
      appBarItemOfferDescriptionColor.value = Colors.white;
    } else if (scrollOfferDescriptionController.offset <= 80 &&
        isScrolledOfferDescription.value) {
      isScrolledOfferDescription.value = false;
      appBarOfferDescriptionColor.value = Colors.transparent;
      statusIconBarOfferDescriptionColor.value = Brightness.dark;
      appBarItemContainerOfferDescriptionColor.value = Colors.white;
      appBarItemOfferDescriptionColor.value = ColorConstants.mainColor;
    }
  }

  void _onScrollMerchantOfferDetail() {
    if (scrollMerchantOfferDetailController.offset > 80 &&
        !isScrolledMerchantOfferDetail.value) {
      isScrolledMerchantOfferDetail.value = true;
      appBarMerchantOfferDetailColor.value =
          Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white;
      statusIconBarMerchantOfferDetailColor.value = Brightness.light;
      appBarItemContainerMerchantOfferDetailColor.value =
          ColorConstants.mainColor;
      appBarItemMerchantOfferDetailColor.value = Colors.white;
    } else if (scrollMerchantOfferDetailController.offset <= 80 &&
        isScrolledMerchantOfferDetail.value) {
      isScrolledMerchantOfferDetail.value = false;
      appBarMerchantOfferDetailColor.value = Colors.transparent;
      statusIconBarMerchantOfferDetailColor.value = Brightness.dark;
      appBarItemContainerMerchantOfferDetailColor.value = Colors.white;
      appBarItemMerchantOfferDetailColor.value = ColorConstants.mainColor;
    }
  }

  void _onScrollTermsConditions() {
    if (scrollTermsConditionsController.offset > 80 &&
        !isScrolledTermsConditions.value) {
      isScrolledTermsConditions.value = true;
      appBarTermsConditionsColor.value =
          Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white;
      statusIconBarTermsConditionsColor.value = Brightness.light;
      appBarItemContainerTermsConditionsColor.value = ColorConstants.mainColor;
      appBarItemTermsConditionsColor.value = Colors.white;
    } else if (scrollTermsConditionsController.offset <= 80 &&
        isScrolledTermsConditions.value) {
      isScrolledTermsConditions.value = false;
      statusIconBarTermsConditionsColor.value = Brightness.dark;
      appBarTermsConditionsColor.value = Colors.transparent;
      appBarItemContainerTermsConditionsColor.value = Colors.white;
      appBarItemTermsConditionsColor.value = ColorConstants.mainColor;
    }
  }

  void _onScrollOfferRatings() {
    if (scrollOfferRatingsController.offset > 20 &&
        !isScrolledOfferRatings.value) {
      isScrolledOfferRatings.value = true;
      appBarOfferRatingsColor.value =
          Get.isDarkMode ? ColorConstants.bottomAppBarDarkColor : Colors.white;
      statusIconBarOfferRatingsColor.value = Brightness.light;
      appBarItemContainerOfferRatingsColor.value = ColorConstants.mainColor;
      appBarItemOfferRatingsColor.value = Colors.white;
    } else if (scrollOfferRatingsController.offset <= 20 &&
        isScrolledOfferRatings.value) {
      isScrolledOfferRatings.value = false;
      statusIconBarOfferRatingsColor.value = Brightness.dark;
      appBarOfferRatingsColor.value = Colors.transparent;
      appBarItemContainerOfferRatingsColor.value = Colors.white;
      appBarItemOfferRatingsColor.value = ColorConstants.mainColor;
    }
  }

/////////////
  void decrementQuantityOfCartItemOfferDetail({required int index}) {
    if (cartItemsOfferDetail[index].count > 1 ||
        cartItemsOfferDetail[index].count == 1) {
      cartItemsOfferDetail[index].count -= 1;
      update();
    }
  }

  void incrementQuantityOfCartItemOfferDetail({required int index}) {
    cartItemsOfferDetail[index].count += 1;
    update();
  }

////////////

  void increment() {
    count.value++;
    quantityController.text = count.value.toString();
  }

  void decrement() {
    if (count.value == 1) return;
    count.value--;
    quantityController.text = count.value.toString();
  }

  Future<void> addOfferOptionToCartItem(CartItemModel newItem) async {
    // if (cartItemsOfferDetail
    //     .firstWhere((item) => item.offerOptions.id == newItem.offerOptions.id,
    //         orElse: () => CartItemModel(
    //           arOfferTitle: '',
    //             enOfferTitle: '',
    //             offerId: 0,
    //             offerOptionsId: 0,
    //             cartId: 0,
    //             totalPrice: 0.0,count: 0,pricePerItem: 0.0,
    //             )
    //     .offerOptions
    //     .arOfferOptionDesc
    //     .isNotEmpty) {
    //   final existingItem = cartItemsOfferDetail.firstWhere(
    //     (item) => item.offerOptions.id == newItem.offerOptions.id,
    //   );

    // existingItem.quantity += newItem.quantity;
    // existingItem.price = (newItem.price * newItem.quantity);
    // }
  }

  void goToTab(int page) {
    currentPage.value = page;
    pageController.jumpToPage(page);
  }

  void changeBanner(int index) {
    currentBanner.value = index;
  }

  void getOfferRate({required String offerId}) {
    isLoadingOfferRatings.value = true;
    _offerProvider.getOfferRate(offerId: offerId).then((ratings) {
      offerRatings.value = ratings;
      isLoadingOfferRatings.value = false;
    });
  }

  void addRateToOffer(
      {required int offerId,
      required String offerKey,
      required double rate,
      required BuildContext context}) {
    _offerProvider
        .addRateToOffer(offerId: offerId, offerKey: offerKey, rate: rate)
        .then((value) {
      if (value) {
        Utils.snackBar(
            context: context,
            msg: translation.rateAddedSuccessfully.tr,
            background: ColorConstants.greenColor,
            textColor: Colors.white);
        Get.back();
        getOfferRate(offerId: offerId.toString());
      }
    });
  }

  var isUserRateOffer = false.obs;
  void checkIfUserRatedBefore({
    required int offerId,
    required String offerKey,
  }) {
    _offerProvider
        .checkIfUserRatedBefore(
      offerId: offerId,
      offerKey: offerKey,
    )
        .then((value) {
      if (value) {
        isUserRateOffer.value = false;
      }
    });
  }

  void getMerchant({
    required String catId,
  }) {
    isLoadingMerchants.value = true;
    _offerProvider
        .getMerchants(
            categoryId: catId,
            cityId: SharedPreferencesClass.getCityId().toString())
        .then((merchantsList) {
      merchants.value = merchantsList;
      isLoadingMerchants.value = false;
    });
  }

  Future<OfferModel> getOffer({
    required String offerKey,
  }) {
    isLoadingOffer.value = true;
    return _offerProvider.getOffer(offerKey: offerKey).then((offer) {
      isLoadingOffer.value = false;
      return offerModel.value = offer;
    });
  }

  @override
  void dispose() {
    scrollOfferDescriptionController.dispose();
    super.dispose();
  }
}
