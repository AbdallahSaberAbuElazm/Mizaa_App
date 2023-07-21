import 'package:test_ecommerce_app/models/merchant/merchant_model.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/models/offers/offer_rate/OfferRateModel.dart';
import 'package:test_ecommerce_app/repositories/OfferRepository.dart';

class OfferProvider {
  final OfferRepository _offerRepository;

  OfferProvider(this._offerRepository);

  Future<List<OfferModel>> getCarouselOffers({required String cityId}) async {
    return await _offerRepository.getCarouselOffers(cityId: cityId);
  }

  Future<List<OfferModel>> getTodayOffers({required String cityId}) async {
    return await _offerRepository.getTodayOffers(cityId: cityId);
  }

  Future<List<OfferModel>> getSpecialOffers({required String cityId}) async {
    return await _offerRepository.getSpecialOffers(cityId: cityId);
  }

  Future<List<OfferModel>> getMostSalesOffers({required String cityId}) async {
    return await _offerRepository.getMostSalesOffers(cityId: cityId);
  }

  Future<List<OfferModel>> getNearestOffers(
      {required double longitude, required double latitude}) async {
    return await _offerRepository.getNearestOffers(
        longitude: longitude, latitude: latitude);
  }

  Future<List<OfferModel>> getOffersForMainCategories(
      {required String categoryId, required String city}) async {
    return await _offerRepository.getOffersForMainCategories(
        categoryId: categoryId, city: city);
  }

  Future<List<OfferModel>> getOffersForSubCategories(
      {required String subCategoryId, required String city}) async {
    return await _offerRepository.getOffersForSubCategories(
        subCategoryId: subCategoryId, city: city);
  }

  Future<List<OfferRateModel>> getOfferRate({
    required String offerId,
  }) async {
    return await _offerRepository.getOfferRate(id: offerId);
  }

  Future<bool> addRateToOffer(
      {required int offerId,
      required String offerKey,
      required double rate}) async {
    return await _offerRepository.addRateToOffer(
        offerId: offerId, offerKey: offerKey, rate: rate);
  }

  Future<bool> checkIfUserRatedBefore({
    required int offerId,
    required String offerKey,
  }) async {
    return await _offerRepository.checkIfUserRatedBefore(
      offerId: offerId,
      offerKey: offerKey,
    );
  }

  Future<List<MerchantModel>> getMerchants(
      {required String categoryId, required String cityId}) async {
    return await _offerRepository.getMerchants(
        categoryId: categoryId, cityId: cityId);
  }

  Future<OfferModel> getOffer({required String offerKey}) async {
    return await _offerRepository.getOffer(offerKey: offerKey);
  }
}
