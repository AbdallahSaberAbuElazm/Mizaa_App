import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/favourite/favourite_controller.dart';
import 'package:test_ecommerce_app/providers/favourite_provider.dart';
import 'package:test_ecommerce_app/repositories/favourite_repository.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FavouriteRepository>(FavouriteRepository());
    Get.put<FavouriteProvider>(FavouriteProvider(Get.find()));
    Get.put<FavouriteController>(FavouriteController(Get.find()));
  }
}
