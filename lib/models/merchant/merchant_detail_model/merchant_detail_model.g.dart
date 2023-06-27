// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'merchant_detail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MerchantModel _$$_MerchantModelFromJson(Map<String, dynamic> json) =>
    _$_MerchantModel(
      id: json['id'] as int?,
      key: json['key'] as String?,
      arName: json['arName'] as String?,
      enName: json['enName'] as String?,
      description: json['description'] as String?,
      enDescription: json['enDescription'] as String?,
      headerPhoto: json['headerPhoto'] as String?,
      mobile: json['mobile'],
      phone: json['phone'],
      logo: json['logo'] as String?,
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      whatsapp: json['whatsapp'] as String?,
      instegram: json['instegram'] as String?,
      snapchat: json['snapchat'] as String?,
      tiktok: json['tiktok'] as String?,
      youtube: json['youtube'] as String?,
      website: json['website'] as String?,
      offers: (json['offers'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_MerchantModelToJson(_$_MerchantModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'arName': instance.arName,
      'enName': instance.enName,
      'description': instance.description,
      'enDescription': instance.enDescription,
      'headerPhoto': instance.headerPhoto,
      'mobile': instance.mobile,
      'phone': instance.phone,
      'logo': instance.logo,
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'whatsapp': instance.whatsapp,
      'instegram': instance.instegram,
      'snapchat': instance.snapchat,
      'tiktok': instance.tiktok,
      'youtube': instance.youtube,
      'website': instance.website,
      'offers': instance.offers,
    };
