import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_way_model.freezed.dart';
part 'payment_way_model.g.dart';

@freezed
class PaymentWayModel with _$PaymentWayModel{
  factory PaymentWayModel({
    required int id,
    required String key,
    required String name,
    required String enName,
    required int displayOrder,
})= _PaymentWayModel;

  factory PaymentWayModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentWayModelFromJson(json);
}
