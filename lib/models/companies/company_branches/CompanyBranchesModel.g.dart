// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'CompanyBranchesModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_CompanyBranchesModel _$$_CompanyBranchesModelFromJson(
        Map<String, dynamic> json) =>
    _$_CompanyBranchesModel(
      id: json['id'] as int?,
      key: json['key'] as String?,
      companyId: json['companyId'] as int?,
      title: json['title'] as String?,
      enTitle: json['enTitle'] as String?,
      address: json['address'] as String?,
      enAddress: json['enAddress'] as String?,
      location: json['location'],
      lat: json['lat'] as String?,
      long: json['long'] as String?,
      mobile: json['mobile'],
      phone: json['phone'],
      whatsapp: json['whatsapp'],
      cityId: json['cityId'] as int?,
    );

Map<String, dynamic> _$$_CompanyBranchesModelToJson(
        _$_CompanyBranchesModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'companyId': instance.companyId,
      'title': instance.title,
      'enTitle': instance.enTitle,
      'address': instance.address,
      'enAddress': instance.enAddress,
      'location': instance.location,
      'lat': instance.lat,
      'long': instance.long,
      'mobile': instance.mobile,
      'phone': instance.phone,
      'whatsapp': instance.whatsapp,
      'cityId': instance.cityId,
    };
