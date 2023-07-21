import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_offer_model.freezed.dart';
part 'order_offer_model.g.dart';

@freezed
class OrderOfferModel with _$OrderOfferModel{
  factory OrderOfferModel({
    required int id,
    required String key,
    required dynamic offer,
    required int offerId,
    required String offerKey,
    required String arTitle,
    required String enTitle,
    required String mainImage,
    required String companyName,
    required String enCompanyName,
    required String companyLogoImage,
    required int mainOrderId,
    required List<Map<String,dynamic>> orderDetails,
  }) = _OrderOfferModel;

  factory OrderOfferModel.fromJson(Map<String, dynamic> json) =>
      _$OrderOfferModelFromJson(json);
}