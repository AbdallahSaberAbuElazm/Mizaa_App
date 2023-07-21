import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_model.freezed.dart';
part 'order_model.g.dart';

@freezed
class OrderModel with _$OrderModel{
  factory OrderModel({
    required int id,
    required String key,
    required String applicationUserId,
    required Map<String,dynamic> paymentWay,
    required int paymentWayId,
    required Map<String,dynamic> orderStatus,
    required int orderStatusId,
    required DateTime creationDate,
    required double totalToPay,
    required List<Map<String,dynamic>> order,
})= _OrderModel;

factory OrderModel.fromJson(Map<String, dynamic> json) =>_$OrderModelFromJson(json);
}