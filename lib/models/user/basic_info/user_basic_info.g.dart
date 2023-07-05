// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_basic_info.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserBasicInfo _$$_UserBasicInfoFromJson(Map<String, dynamic> json) =>
    _$_UserBasicInfo(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      applicationUserId: json['applicationUserId'] as String,
      balance: (json['balance'] as num).toDouble(),
      points: json['points'] as int,
      city: json['city'] as int,
      country: json['country'] as int,
    );

Map<String, dynamic> _$$_UserBasicInfoToJson(_$_UserBasicInfo instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'applicationUserId': instance.applicationUserId,
      'balance': instance.balance,
      'points': instance.points,
      'city': instance.city,
      'country': instance.country,
    };
