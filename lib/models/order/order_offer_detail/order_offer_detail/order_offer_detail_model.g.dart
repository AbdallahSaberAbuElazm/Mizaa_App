// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_offer_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderOfferDetailModel _$$_OrderOfferDetailModelFromJson(
        Map<String, dynamic> json) =>
    _$_OrderOfferDetailModel(
      id: json['id'] as int,
      key: json['key'] as String,
      orderId: json['orderId'] as int,
      offerOptions: json['offerOptions'],
      offerOptionsId: json['offerOptionsId'] as int,
      coboneCount: json['coboneCount'] as int,
      cobonesCost: json['cobonesCost'] as int,
      cobonePrice: json['cobonePrice'] as int,
      arOfferOptionDesc: json['arOfferOptionDesc'] as String,
      enOfferOptionDesc: json['enOfferOptionDesc'] as String,
      validTill: DateTime.parse(json['validTill'] as String),
    );

Map<String, dynamic> _$$_OrderOfferDetailModelToJson(
        _$_OrderOfferDetailModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'orderId': instance.orderId,
      'offerOptions': instance.offerOptions,
      'offerOptionsId': instance.offerOptionsId,
      'coboneCount': instance.coboneCount,
      'cobonesCost': instance.cobonesCost,
      'cobonePrice': instance.cobonePrice,
      'arOfferOptionDesc': instance.arOfferOptionDesc,
      'enOfferOptionDesc': instance.enOfferOptionDesc,
      'validTill': instance.validTill.toIso8601String(),
    };
