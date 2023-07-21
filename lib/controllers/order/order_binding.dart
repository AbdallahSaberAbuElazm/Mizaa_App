import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/order/order_controller.dart';
import 'package:test_ecommerce_app/providers/order_provider.dart';
import 'package:test_ecommerce_app/repositories/order_repository.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderRepository>(OrderRepository());
    Get.put<OrderProvider>(OrderProvider(Get.find()));
    Get.put<OrderController>(OrderController(Get.find()));
  }
}
