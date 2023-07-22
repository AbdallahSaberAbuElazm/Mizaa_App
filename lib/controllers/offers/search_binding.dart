import 'package:get/get.dart';

import 'package:mizaa/controllers/offers/search_offer_controller.dart';

import 'package:mizaa/providers/search_provider.dart';

import 'package:mizaa/repositories/search_repositories.dart';

class SearchBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<SearchRepository>(SearchRepository());
    Get.put<SearchProvider>(SearchProvider(Get.find()));
    Get.put<SearchOfferController>(SearchOfferController(Get.find()));
  }
}
