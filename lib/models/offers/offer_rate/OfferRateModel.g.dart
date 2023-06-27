// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'OfferRateModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OfferRateModel _$$_OfferRateModelFromJson(Map<String, dynamic> json) =>
    _$_OfferRateModel(
      username: json['username'] as String?,
      rate: (json['rate'] as num?)?.toDouble(),
      creation: json['creation'] == null
          ? null
          : DateTime.parse(json['creation'] as String),
    );

Map<String, dynamic> _$$_OfferRateModelToJson(_$_OfferRateModel instance) =>
    <String, dynamic>{
      'username': instance.username,
      'rate': instance.rate,
      'creation': instance.creation?.toIso8601String(),
    };
