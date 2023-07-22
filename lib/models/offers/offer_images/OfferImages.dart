import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:mizaa/shared/typedef.dart';

part 'OfferImages.freezed.dart';
part 'OfferImages.g.dart';

@freezed
class OfferImages with _$OfferImages {
  factory OfferImages({
    int? id,
    String? key,
    int? offerId,
    String? imagePath,
    dynamic image,
    String? arImageDescription,
    String? enImageDescription,
    bool? isPrimary,
  }) = _OfferImages;

  factory OfferImages.fromJson(Map<String, dynamic> json) =>
      _$OfferImagesFromJson(json);
}
