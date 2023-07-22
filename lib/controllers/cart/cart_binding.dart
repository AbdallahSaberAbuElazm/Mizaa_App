import 'package:get/get.dart';
import 'package:mizaa/controllers/cart/cart_controller.dart';
import 'package:mizaa/providers/cart_provider.dart';
import 'package:mizaa/repositories/cart_repository.dart';

class CartBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<CartRepository>(CartRepository());
    Get.put<CartProvider>(CartProvider(Get.find()));
    Get.put<CartController>(CartController(Get.find()));
  }
}
