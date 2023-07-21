import 'package:test_ecommerce_app/models/cart/validate_order_data/order_data_model.dart';
import 'package:test_ecommerce_app/models/order/order_model.dart';
import 'package:test_ecommerce_app/repositories/order_repository.dart';

class OrderProvider {
  final OrderRepository _orderRepository;

  OrderProvider(this._orderRepository);

  Future<String> validateOrderData(
      {required OrderDataModel orderDataModel}) async {
    return await _orderRepository.validateOrderData(
        orderDataModel: orderDataModel);
  }

  Future<String> makeOrder({required String orderKey}) async {
    return await _orderRepository.makeOrder(orderKey: orderKey);
  }

  Future<List<OrderModel>> getUserOrders() async {
    return await _orderRepository.getUserOrders();
  }
}
