// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_offer_data_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderOfferDataDetailModel _$$_OrderOfferDataDetailModelFromJson(
        Map<String, dynamic> json) =>
    _$_OrderOfferDataDetailModel(
      offerId: json['offerId'] as int,
      orderDetailsDto: (json['orderDetailsDto'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_OrderOfferDataDetailModelToJson(
        _$_OrderOfferDataDetailModel instance) =>
    <String, dynamic>{
      'offerId': instance.offerId,
      'orderDetailsDto': instance.orderDetailsDto,
    };
