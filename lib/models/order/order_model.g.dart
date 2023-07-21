// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderModel _$$_OrderModelFromJson(Map<String, dynamic> json) =>
    _$_OrderModel(
      id: json['id'] as int,
      key: json['key'] as String,
      applicationUserId: json['applicationUserId'] as String,
      paymentWay: json['paymentWay'] as Map<String, dynamic>,
      paymentWayId: json['paymentWayId'] as int,
      orderStatus: json['orderStatus'] as Map<String, dynamic>,
      orderStatusId: json['orderStatusId'] as int,
      creationDate: DateTime.parse(json['creationDate'] as String),
      totalToPay: (json['totalToPay'] as num).toDouble(),
      order: (json['order'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_OrderModelToJson(_$_OrderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'applicationUserId': instance.applicationUserId,
      'paymentWay': instance.paymentWay,
      'paymentWayId': instance.paymentWayId,
      'orderStatus': instance.orderStatus,
      'orderStatusId': instance.orderStatusId,
      'creationDate': instance.creationDate.toIso8601String(),
      'totalToPay': instance.totalToPay,
      'order': instance.order,
    };
