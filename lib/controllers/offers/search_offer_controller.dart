import 'package:get/get.dart';
import 'package:mizaa/models/merchant/merchant_detail_model/merchant_detail_model.dart';
import 'package:mizaa/models/merchant/merchant_model.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/models/search/search_model.dart';
import 'package:mizaa/providers/search_provider.dart';
import 'package:mizaa/shared/shared_preferences.dart';

class SearchOfferController extends GetxController {
  SearchProvider searchProvider;
  SearchOfferController(this.searchProvider);

  final isLoadingSearchOfferList = true.obs;
  final searchOffersList = <SearchModel>[].obs;
  final isLoadingSearchMerchantList = true.obs;
  final merchantsInSearch = <MerchantModel>[].obs;

  final deleteIconShow = false.obs;

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

  var isLoadingMerchant = true.obs;
  final companyModel = MerchantDetailModel(
      id: 0,
      key: '',
      arName: '',
      enName: '',
      description: '',
      enDescription: '',
      headerPhoto: '',
      mobile: '',
      phone: '',
      logo: '',
      facebook: '',
      twitter: '',
      whatsapp: '',
      instegram: '',
      snapchat: '',
      tiktok: '',
      youtube: '',
      website: '',
      offers: []).obs;

  getOffersAndSellersInCity({required String searchKeyWord}) {
    isLoadingSearchOfferList.value = true;
    searchProvider
        .getOffersAndSellersInCity(
            cityId: int.parse(SharedPreferencesClass.getCityId().toString()),
            searchKeyWord: searchKeyWord,
            userMobile: SharedPreferencesClass.getPhoneNumber().toString(),
            deviceToken: SharedPreferencesClass.getToken().toString())
        .then((searchModel) {
      searchOffersList.value = searchModel;
      isLoadingSearchOfferList.value = false;
    });
  }

  getOffersInMainCategoryWithCity(
      {required String searchKeyWord, required int mainCatId}) {
    isLoadingSearchOfferList.value = true;
    searchProvider
        .getOffersInMainCategoryWithCity(
            cityId: int.parse(SharedPreferencesClass.getCityId().toString()),
            searchKeyWord: searchKeyWord,
            mainCatId: mainCatId,
            userMobile: SharedPreferencesClass.getPhoneNumber().toString(),
            deviceToken: SharedPreferencesClass.getToken().toString())
        .then((searchModel) {
      searchOffersList.value = searchModel;
      isLoadingSearchOfferList.value = false;
    });
  }

  getOffersInSubCategoryWithCity({
    required String searchKeyWord,
    required int subCatId,
  }) {
    searchProvider
        .getOffersInSubCategoryWithCity(
            cityId: int.parse(SharedPreferencesClass.getCityId().toString()),
            searchKeyWord: searchKeyWord,
            subCatId: subCatId,
            userMobile: SharedPreferencesClass.getPhoneNumber().toString(),
            deviceToken: SharedPreferencesClass.getToken().toString())
        .then((searchModel) {
      searchOffersList.value = searchModel;
      isLoadingSearchOfferList.value = false;
    });
  }

  getMerchantsInSearch({
    required String searchKeyWord,
  }) {
    isLoadingSearchMerchantList.value = true;
    searchProvider
        .getMerchantsInSearch(
      cityId: int.parse(SharedPreferencesClass.getCityId().toString()),
      searchKeyWord: searchKeyWord,
    )
        .then((searchMerchantModel) {
      merchantsInSearch.value = searchMerchantModel;
      isLoadingSearchMerchantList.value = false;
    });
  }

  Future<OfferModel> getOffer({
    required String offerKey,
  }) async {
    isLoadingOffer.value = true;
    await searchProvider.getOffer(offerKey: offerKey).then((offer) {
      offerModel.value = offer;
      isLoadingOffer.value = false;
    });
    return offerModel.value;
  }

  Future<MerchantDetailModel> getMerchant({
    required String merchantKey,
  }) async {
    isLoadingMerchant.value = true;
    await searchProvider.getMerchant(merchantKey: merchantKey).then((merchant) {
      companyModel.value = merchant;
      isLoadingMerchant.value = false;
    });
    return companyModel.value;
  }

  // void getMerchant({required String merchantId}){
  //   searchProvider.getMerchant(merchantId: merchantId, cityId: '').then((merchant) {
  //
  //   });
  // }
}
