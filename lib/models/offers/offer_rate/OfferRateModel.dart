
import 'package:freezed_annotation/freezed_annotation.dart';

part 'OfferRateModel.freezed.dart';
part 'OfferRateModel.g.dart';

@freezed
class OfferRateModel with _$OfferRateModel{

  factory OfferRateModel({
    String? username,
    double? rate,
    DateTime? creation,

  }) = _OfferRateModel;

  factory OfferRateModel.fromJson(Map<String, dynamic> json) => _$OfferRateModelFromJson(json);


}