import 'package:mizaa/controllers/home/HomeController.dart';
import 'package:mizaa/providers/CategoryProvider.dart';
import 'package:mizaa/providers/OfferProvider.dart';
import 'package:mizaa/providers/ProductProvider.dart';
import 'package:mizaa/repositories/CategoryRepository.dart';
import 'package:mizaa/repositories/OfferRepository.dart';
import 'package:mizaa/repositories/ProductRepository.dart';
import 'package:get/get.dart';

class HomeBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OfferRepository>(() => OfferRepository());
    Get.lazyPut<OfferProvider>(() => OfferProvider(Get.find()));

    Get.lazyPut<CategoryRepository>(() => CategoryRepository());
    Get.lazyPut<CategoryProvider>(() => CategoryProvider(Get.find()));

    Get.lazyPut<ProductRepository>(() => ProductRepository(Get.find()));
    Get.lazyPut<ProductProvider>(() => ProductProvider(Get.find()));

    Get.lazyPut<HomeController>(() => HomeController(Get.find()));
  }
}
