import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_model.freezed.dart';
part 'search_model.g.dart';

@freezed
class SearchModel with _$SearchModel {
  factory SearchModel({
     String? offerKey,
     String? offerMainImage,
     String? offerArTitle,
     String? offerEnTitle,
     String? offerArDesc,
     String? offerEnDesc,
     String? companyArName,
     String? companyEnName,
     String? companyLogo,
     double? offerDiscount,
  }) = _SearchModel;

  factory SearchModel.fromJson(Map<String, dynamic> json) =>
      _$SearchModelFromJson(json);
}