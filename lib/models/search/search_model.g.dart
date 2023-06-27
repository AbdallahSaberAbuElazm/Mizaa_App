// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SearchModel _$$_SearchModelFromJson(Map<String, dynamic> json) =>
    _$_SearchModel(
      offerKey: json['offerKey'] as String?,
      offerMainImage: json['offerMainImage'] as String?,
      offerArTitle: json['offerArTitle'] as String?,
      offerEnTitle: json['offerEnTitle'] as String?,
      offerArDesc: json['offerArDesc'] as String?,
      offerEnDesc: json['offerEnDesc'] as String?,
      companyArName: json['companyArName'] as String?,
      companyEnName: json['companyEnName'] as String?,
      companyLogo: json['companyLogo'] as String?,
      offerDiscount: (json['offerDiscount'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_SearchModelToJson(_$_SearchModel instance) =>
    <String, dynamic>{
      'offerKey': instance.offerKey,
      'offerMainImage': instance.offerMainImage,
      'offerArTitle': instance.offerArTitle,
      'offerEnTitle': instance.offerEnTitle,
      'offerArDesc': instance.offerArDesc,
      'offerEnDesc': instance.offerEnDesc,
      'companyArName': instance.companyArName,
      'companyEnName': instance.companyEnName,
      'companyLogo': instance.companyLogo,
      'offerDiscount': instance.offerDiscount,
    };
