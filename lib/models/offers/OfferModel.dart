import 'package:test_ecommerce_app/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'OfferModel.freezed.dart';
part 'OfferModel.g.dart';

@freezed
class OfferModel with _$OfferModel {
  factory OfferModel({
    int? id,
    String? key,
    String? arTitle,
    String? enTitle,
    String? arSubtitle,
    String? enSubtitle,
    String? arDiscrict,
    String? enDiscrict,
    String? arAddress,
    String? enAddress,
    double? arDiscount,
    double? enDiscount,
    double? priceBeforDiscount,
    double? priceAfterDiscount,
    String? arFeatures,
    String? enFeatures,
    String? arConditions,
    String? enConditions,
    String? arOfferDuration,
    String? enOfferDuration,
    int? companyId,
    String? arCommunications,
    String? enCommunications,
    bool? isSpecialOffer,
    String? arAttentionMessgae,
    String? enAttentionMessgae,
    DateTime? creationDate,
    DateTime? expireDate,
    int? cityId,
    dynamic city,
    String? mainImage,
    dynamic image,
    dynamic companyLogoImage,
    dynamic latitude,
    dynamic longitude,
    int? subCategoryId,
    int? salesCount,
    // CompanyModel? company,
    Map<dynamic,dynamic>? company,
    List<Map<dynamic,dynamic>>? offerImages,
    List<Map<dynamic,dynamic>>? offerOptions,
    Map<String,dynamic>? subCategory,
    dynamic userOfferActionHistories,
    bool? isShowInHomePage,
    bool? isTodayOffer,
    bool? isNewest,
    bool? isMostSales,
    bool? isSpecial,
    double? offerRate,
    dynamic offerRates,
  }) = _OfferModel;

  factory OfferModel.fromJson(JSON json) => _$OfferModelFromJson(json);


}
