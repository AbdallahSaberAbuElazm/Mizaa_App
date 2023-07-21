import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:test_ecommerce_app/shared/typedef.dart';

part 'CityModel.freezed.dart';
part 'CityModel.g.dart';

@freezed
class CityModel with _$CityModel {
  factory CityModel({
    required int id,
    required String key,
    required String arName,
    required String enName,
    dynamic country,
    dynamic offers,
  }) = _CityModel;

  factory CityModel.fromJson(JSON json) => _$CityModelFromJson(json);
}
