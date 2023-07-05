import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_history_model.freezed.dart';
part 'wallet_history_model.g.dart';

@freezed
abstract class WalletHistoryModel with _$WalletHistoryModel {
  factory WalletHistoryModel({
    required int id,
    required String key,
    required int operationTypeId,
    required String operationArTypeName,
    required String operationEnTypeName,
    required double money,
    required String applicationUserId,
    required String opeationArDescription,
    required String opeationEnDescription,
    required DateTime creationDate,
  }) = _WalletHistoryModel;

  factory WalletHistoryModel.fromJson(Map<String, dynamic> json) =>
      _$WalletHistoryModelFromJson(json);
}
