import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/cart/cart_controller.dart';
import 'package:test_ecommerce_app/providers/cart_provider.dart';
import 'package:test_ecommerce_app/repositories/cart_repository.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CartRepository>(CartRepository());
    Get.put<CartProvider>(CartProvider(Get.find()));
    Get.put<CartController>(CartController(Get.find()));
  }
}
