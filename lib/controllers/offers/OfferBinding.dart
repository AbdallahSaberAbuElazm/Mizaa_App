import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:get/get.dart';
import 'package:test_ecommerce_app/providers/OfferProvider.dart';
import 'package:test_ecommerce_app/repositories/OfferRepository.dart';

class OfferBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => OfferRepository());
    Get.put(() => OfferProvider(Get.find()));
    Get.put(() => OfferController(Get.find()));
  }
}
