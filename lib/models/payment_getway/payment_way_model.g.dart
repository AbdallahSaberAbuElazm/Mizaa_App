// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_way_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaymentWayModel _$$_PaymentWayModelFromJson(Map<String, dynamic> json) =>
    _$_PaymentWayModel(
      id: json['id'] as int,
      key: json['key'] as String,
      name: json['name'] as String,
      enName: json['enName'] as String,
      displayOrder: json['displayOrder'] as int,
    );

Map<String, dynamic> _$$_PaymentWayModelToJson(_$_PaymentWayModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'name': instance.name,
      'enName': instance.enName,
      'displayOrder': instance.displayOrder,
    };
