import 'package:freezed_annotation/freezed_annotation.dart';

part 'merchant_model.freezed.dart';
part 'merchant_model.g.dart';

@freezed
class MerchantModel with _$MerchantModel {
  factory MerchantModel({
    int? count,
    String? arname,
    String? enname,
    String? logo,
    String? key,
  }) = _MerchantModel;

  factory MerchantModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantModelFromJson(json);
}