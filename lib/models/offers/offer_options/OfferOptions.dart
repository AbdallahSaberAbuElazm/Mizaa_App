import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mizaa/shared/typedef.dart';

part 'OfferOptions.freezed.dart';
part 'OfferOptions.g.dart';

@freezed
class OfferOptions with _$OfferOptions {
  factory OfferOptions({
    required int id,
    required String key,
    required int offerId,
    required String arOfferOptionDesc,
    required String enOfferOptionDesc,
    required double priceBeforDesc,
    required double discount,
    required double priceAfterDesc,
    required DateTime expireDate,
    required DateTime creationDate,
    int? availablaAmount,
    int? numberOfPruchaces,
  }) = _OfferOptions;

  factory OfferOptions.fromJson(Map<String, dynamic> json) =>
      _$OfferOptionsFromJson(json);
}
