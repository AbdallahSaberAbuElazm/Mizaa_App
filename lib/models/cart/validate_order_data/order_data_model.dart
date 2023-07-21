import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_data_model.freezed.dart';
part 'order_data_model.g.dart';

@freezed
class OrderDataModel with _$OrderDataModel{
  factory OrderDataModel({
    required String applicationUserId,
    required int paymentWayId,
    required double totalToPay,
    required List<Map<String,dynamic>> orderDto,
})= _OrderDataModel;

factory OrderDataModel.fromJson(Map<String, dynamic> json) =>_$OrderDataModelFromJson(json);
}