import 'package:freezed_annotation/freezed_annotation.dart';

part 'merchant_detail_model.freezed.dart';
part 'merchant_detail_model.g.dart';

@freezed
class MerchantDetailModel with _$MerchantDetailModel {
  factory MerchantDetailModel({
    int? id,
    String? key,
    String? arName,
    String? enName,
    String? description,
    String? enDescription,
    String? headerPhoto,
    dynamic mobile,
    dynamic phone,
    String? logo,
    String? facebook,
    String? twitter,
    String? whatsapp,
    String? instegram,
    String? snapchat,
    String? tiktok,
    String? youtube,
    String? website,
    List<Map<String,dynamic>>? offers,
  }) = _MerchantModel;

  factory MerchantDetailModel.fromJson(Map<String, dynamic> json) =>
      _$MerchantDetailModelFromJson(json);
}