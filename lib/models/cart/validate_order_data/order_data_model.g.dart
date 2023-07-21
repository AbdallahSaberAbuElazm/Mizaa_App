// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_OrderDataModel _$$_OrderDataModelFromJson(Map<String, dynamic> json) =>
    _$_OrderDataModel(
      applicationUserId: json['applicationUserId'] as String,
      paymentWayId: json['paymentWayId'] as int,
      totalToPay: (json['totalToPay'] as num).toDouble(),
      orderDto: (json['orderDto'] as List<dynamic>)
          .map((e) => e as Map<String, dynamic>)
          .toList(),
    );

Map<String, dynamic> _$$_OrderDataModelToJson(_$_OrderDataModel instance) =>
    <String, dynamic>{
      'applicationUserId': instance.applicationUserId,
      'paymentWayId': instance.paymentWayId,
      'totalToPay': instance.totalToPay,
      'orderDto': instance.orderDto,
    };
