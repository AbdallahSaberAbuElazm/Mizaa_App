import 'package:mizaa/models/merchant/merchant_detail_model/merchant_detail_model.dart';
import 'package:mizaa/models/merchant/merchant_model.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/models/search/search_model.dart';
import 'package:mizaa/repositories/search_repositories.dart';

class SearchProvider {
  final SearchRepository _searchRepository;

  SearchProvider(this._searchRepository);

  Future<List<SearchModel>> getOffersAndSellersInCity(
      {required int cityId,
      required String searchKeyWord,
      required String userMobile,
      required String deviceToken}) async {
    return await _searchRepository.getOffersAndSellersInCity(
        cityId: cityId,
        searchKeyWord: searchKeyWord,
        userMobile: userMobile,
        deviceToken: deviceToken);
  }

  Future<List<SearchModel>> getOffersInMainCategoryWithCity(
      {required int cityId,
      required String searchKeyWord,
      required int mainCatId,
      required String userMobile,
      required String deviceToken}) async {
    return await _searchRepository.getOffersInMainCategoryWithCity(
        cityId: cityId,
        searchKeyWord: searchKeyWord,
        mainCatId: mainCatId,
        userMobile: userMobile,
        deviceToken: deviceToken);
  }

  Future<List<SearchModel>> getOffersInSubCategoryWithCity(
      {required int cityId,
      required String searchKeyWord,
      required int subCatId,
      required String userMobile,
      required String deviceToken}) async {
    return await _searchRepository.getOffersInSubCategoryWithCity(
        cityId: cityId,
        searchKeyWord: searchKeyWord,
        subCatId: subCatId,
        userMobile: userMobile,
        deviceToken: deviceToken);
  }

  Future<List<MerchantModel>> getMerchantsInSearch({
    required int cityId,
    required String searchKeyWord,
  }) async {
    return await _searchRepository.getMerchantsInSearch(
        cityId: cityId, searchKeyWord: searchKeyWord);
  }

  Future<OfferModel> getOffer({required String offerKey}) async {
    return await _searchRepository.getOffer(offerKey: offerKey);
  }

  Future<MerchantDetailModel> getMerchant({required String merchantKey}) async {
    return await _searchRepository.getMerchant(merchantKey: merchantKey);
  }

  // Future<CompanyModel> getMerchant({required String merchantId, required String cityId} )async {
  //   return await _searchRepository.getMerchant(categoryId: merchantId,cityId: cityId);
  // }
}
