import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_offer_detail_model.freezed.dart';
part 'order_offer_detail_model.g.dart';

@freezed
class OrderOfferDetailModel with _$OrderOfferDetailModel {
  factory OrderOfferDetailModel({
    required int id,
    required String key,
    required int orderId,
    required dynamic offerOptions,
    required int offerOptionsId,
    required int coboneCount,
    required int cobonesCost,
    required int cobonePrice,
    required String arOfferOptionDesc,
    required String enOfferOptionDesc,
    required DateTime validTill,
  }) = _OrderOfferDetailModel;

  factory OrderOfferDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderOfferDetailModelFromJson(json);
}