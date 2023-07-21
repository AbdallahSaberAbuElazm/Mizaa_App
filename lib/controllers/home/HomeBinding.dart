import 'package:test_ecommerce_app/controllers/home/HomeController.dart';
import 'package:test_ecommerce_app/providers/CategoryProvider.dart';
import 'package:test_ecommerce_app/providers/OfferProvider.dart';
import 'package:test_ecommerce_app/providers/ProductProvider.dart';
import 'package:test_ecommerce_app/repositories/CategoryRepository.dart';
import 'package:test_ecommerce_app/repositories/OfferRepository.dart';
import 'package:test_ecommerce_app/repositories/ProductRepository.dart';
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
