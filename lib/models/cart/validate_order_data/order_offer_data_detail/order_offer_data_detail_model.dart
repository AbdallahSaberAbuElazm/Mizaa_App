import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_offer_data_detail_model.freezed.dart';
part 'order_offer_data_detail_model.g.dart';

@freezed
class OrderOfferDataDetailModel with _$OrderOfferDataDetailModel{
  factory OrderOfferDataDetailModel({
    required int offerId,
    required List<Map<String,dynamic>> orderDetailsDto,
}) = _OrderOfferDataDetailModel;

  factory OrderOfferDataDetailModel.fromJson(Map<String, dynamic> json) =>
      _$OrderOfferDataDetailModelFromJson(json);
}