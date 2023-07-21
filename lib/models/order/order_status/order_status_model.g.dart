// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_status_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderStatusModel _$$_OrderStatusModelFromJson(Map<String, dynamic> json) =>
    _$_OrderStatusModel(
      id: json['id'] as int,
      key: json['key'] as String,
      arStatusName: json['arStatusName'] as String,
      enStatusName: json['enStatusName'] as String,
    );

Map<String, dynamic> _$$_OrderStatusModelToJson(_$_OrderStatusModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'arStatusName': instance.arStatusName,
      'enStatusName': instance.enStatusName,
    };
