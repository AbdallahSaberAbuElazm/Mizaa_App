// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletModel _$$_WalletModelFromJson(Map<String, dynamic> json) =>
    _$_WalletModel(
      name: json['name'] as String,
      mobile: json['mobile'] as String,
      applicationUserId: json['applicationUserId'] as String,
      balance: (json['balance'] as num).toDouble(),
      points: json['points'] as int,
      city: json['city'] as int,
      country: json['country'] as int,
      walletHistory: (json['walletHistory'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_WalletModelToJson(_$_WalletModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'mobile': instance.mobile,
      'applicationUserId': instance.applicationUserId,
      'balance': instance.balance,
      'points': instance.points,
      'city': instance.city,
      'country': instance.country,
      'walletHistory': instance.walletHistory,
    };
