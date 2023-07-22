import 'package:get/get.dart';
import 'package:mizaa/controllers/favourite/favourite_controller.dart';
import 'package:mizaa/providers/favourite_provider.dart';
import 'package:mizaa/repositories/favourite_repository.dart';

class FavouriteBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<FavouriteRepository>(FavouriteRepository());
    Get.put<FavouriteProvider>(FavouriteProvider(Get.find()));
    Get.put<FavouriteController>(FavouriteController(Get.find()));
  }
}
