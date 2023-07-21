import 'package:test_ecommerce_app/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'ProductContent.freezed.dart';
part 'ProductContent.g.dart';

@freezed
class ProductContent with _$ProductContent {
  factory ProductContent(
      {required String title,
      required List<String> contains,
      required String price,
      required String discount,
      required String discountPrice}) = _ProductContent;

  factory ProductContent.fromJson(JSON json) => _$ProductContentFromJson(json);
}
