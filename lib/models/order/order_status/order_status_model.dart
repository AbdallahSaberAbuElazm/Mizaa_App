import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_status_model.freezed.dart';
part 'order_status_model.g.dart';

@freezed
class OrderStatusModel with _$OrderStatusModel{
  factory OrderStatusModel({
    required int id,
    required String key,
    required String arStatusName,
    required String enStatusName,
})= _OrderStatusModel;

  factory OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      _$OrderStatusModelFromJson(json);

  }