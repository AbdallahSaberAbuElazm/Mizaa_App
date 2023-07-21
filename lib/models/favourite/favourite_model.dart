import 'package:freezed_annotation/freezed_annotation.dart';

part 'favourite_model.freezed.dart';
part 'favourite_model.g.dart';

@freezed
class FavouriteModel with _$FavouriteModel {
  factory FavouriteModel({
    required int id,
    required String key,
    required DateTime creationDate,
    required String userMobile,
    required String token,
    required int offerId,
    required Map<String,dynamic> offer,
  }) = _FavouriteModel;

  factory FavouriteModel.fromJson(Map<String, dynamic> json) =>
      _$FavouriteModelFromJson(json);
}
