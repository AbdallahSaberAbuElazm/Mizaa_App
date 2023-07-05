import 'package:freezed_annotation/freezed_annotation.dart';

part 'wallet_model.freezed.dart';
part 'wallet_model.g.dart';

@freezed
abstract class WalletModel with _$WalletModel {
  factory WalletModel({
    required String name,
    required String mobile,
    required String applicationUserId,
    required double balance,
    required int points,
    required int city,
    required int country,
    required List<Map<String,dynamic>> walletHistory,
  }) = _WalletModel;

  factory WalletModel.fromJson(Map<String, dynamic> json) =>
      _$WalletModelFromJson(json);
}
