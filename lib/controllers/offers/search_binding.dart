import 'package:get/get.dart';

import 'package:test_ecommerce_app/controllers/offers/search_offer_controller.dart';

import 'package:test_ecommerce_app/providers/search_provider.dart';

import 'package:test_ecommerce_app/repositories/search_repositories.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchRepository>(SearchRepository());
    Get.put<SearchProvider>(SearchProvider(Get.find()));
    Get.put<SearchOfferController>(SearchOfferController(Get.find()));
  }
}
