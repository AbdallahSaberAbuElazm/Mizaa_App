// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderOfferModel _$$_OrderOfferModelFromJson(Map<String, dynamic> json) =>
    _$_OrderOfferModel(
      id: json['id'] as int,
      key: json['key'] as String,
      offer: json['offer'],
      offerId: json['offerId'] as int,
      offerKey: json['offerKey'] as String,
      arTitle: json['arTitle'] as String,
      enTitle: json['enTitle'] as String,
      mainImage: json['mainImage'] as String,
      companyName: json['companyName'] as String,
      enCompanyName: json['enCompanyName'] as String,
      companyLogoImage: json['companyLogoImage'] as String,
      mainOrderId: json['mainOrderId'] as int,
      orderDetails: (json['orderDetails'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_OrderOfferModelToJson(_$_OrderOfferModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'offer': instance.offer,
      'offerId': instance.offerId,
      'offerKey': instance.offerKey,
      'arTitle': instance.arTitle,
      'enTitle': instance.enTitle,
      'mainImage': instance.mainImage,
      'companyName': instance.companyName,
      'enCompanyName': instance.enCompanyName,
      'companyLogoImage': instance.companyLogoImage,
      'mainOrderId': instance.mainOrderId,
      'orderDetails': instance.orderDetails,
    };
