import 'package:mizaa/controllers/offers/OfferController.dart';
import 'package:get/get.dart';
import 'package:mizaa/providers/OfferProvider.dart';
import 'package:mizaa/repositories/OfferRepository.dart';

class OfferBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(() => OfferRepository());
    Get.put(() => OfferProvider(Get.find()));
    Get.put(() => OfferController(Get.find()));
  }
}
