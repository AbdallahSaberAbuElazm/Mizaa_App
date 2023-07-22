import 'package:get/get.dart';
import 'package:mizaa/controllers/order/order_controller.dart';
import 'package:mizaa/providers/order_provider.dart';
import 'package:mizaa/repositories/order_repository.dart';

class OrderBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<OrderRepository>(OrderRepository());
    Get.put<OrderProvider>(OrderProvider(Get.find()));
    Get.put<OrderController>(OrderController(Get.find()));
  }
}
