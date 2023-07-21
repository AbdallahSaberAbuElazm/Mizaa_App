import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_detail_dto.freezed.dart';
part 'order_detail_dto.g.dart';

@freezed
class OrderDetailsDto with _$OrderDetailsDto {
  const factory OrderDetailsDto({
    required int offerOptionsId,
    required int coboneCount,
    required int cobonesCost,
  }) = _OrderDetailsDto;

  factory OrderDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsDtoFromJson(json);
}