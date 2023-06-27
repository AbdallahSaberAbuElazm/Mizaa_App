import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:get/get.dart';

class OfferBinding implements Bindings {
  @override
  void dependencies() {  
    // Get.lazyPut<OfferRepository>(() => OfferRepository());
    // Get.lazyPut<OfferProvider>(() => OfferProvider(Get.find()));
    //
    Get.lazyPut<OfferController>(() => OfferController(Get.find()));
  }
}
