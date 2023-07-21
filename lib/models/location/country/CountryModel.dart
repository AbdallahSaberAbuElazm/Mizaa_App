import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_ecommerce_app/shared/typedef.dart';

part 'CountryModel.freezed.dart';
part 'CountryModel.g.dart';

@freezed
class CountryModel with _$CountryModel {
  factory CountryModel({
    required int id,
    required String key,
    required String arName,
    required String enName,
    required String shortName,
    required int mobileMaxLength,
    required String phoneCode,
    required int coinId,
    dynamic cities,
    dynamic coin,
  }) = _CountryModel;

  factory CountryModel.fromJson(JSON json) => _$CountryModelFromJson(json);
}
