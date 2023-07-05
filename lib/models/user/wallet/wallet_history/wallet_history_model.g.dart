// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'wallet_history_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_WalletHistoryModel _$$_WalletHistoryModelFromJson(
        Map<String, dynamic> json) =>
    _$_WalletHistoryModel(
      id: json['id'] as int,
      key: json['key'] as String,
      operationTypeId: json['operationTypeId'] as int,
      operationArTypeName: json['operationArTypeName'] as String,
      operationEnTypeName: json['operationEnTypeName'] as String,
      money: (json['money'] as num).toDouble(),
      applicationUserId: json['applicationUserId'] as String,
      opeationArDescription: json['opeationArDescription'] as String,
      opeationEnDescription: json['opeationEnDescription'] as String,
      creationDate: DateTime.parse(json['creationDate'] as String),
    );

Map<String, dynamic> _$$_WalletHistoryModelToJson(
        _$_WalletHistoryModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'key': instance.key,
      'operationTypeId': instance.operationTypeId,
      'operationArTypeName': instance.operationArTypeName,
      'operationEnTypeName': instance.operationEnTypeName,
      'money': instance.money,
      'applicationUserId': instance.applicationUserId,
      'opeationArDescription': instance.opeationArDescription,
      'opeationEnDescription': instance.opeationEnDescription,
      'creationDate': instance.creationDate.toIso8601String(),
    };
