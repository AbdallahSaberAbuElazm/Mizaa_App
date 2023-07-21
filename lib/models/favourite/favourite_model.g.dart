// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favourite_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_FavouriteModel _$$_FavouriteModelFromJson(Map<String, dynamic> json) =>
    _$_FavouriteModel(
      id: json['id'] as int,
      key: json['key'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
      userMobile: json['userMobile'] as String,
      token: json['token'] as String,
      offerId: json['offerId'] as int,
      offer: json['offer'] as Map<String, dynamic>,
    );

Map<String, dynamic> _$$_FavouriteModelToJson(_$_FavouriteModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'creationDate': instance.creationDate.toIso8601String(),
      'userMobile': instance.userMobile,
      'token': instance.token,
      'offerId': instance.offerId,
      'offer': instance.offer,
    };
