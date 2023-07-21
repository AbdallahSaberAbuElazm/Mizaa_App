import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/cart/cart_controller.dart';
import 'package:test_ecommerce_app/controllers/companies/company_controller.dart';
import 'package:test_ecommerce_app/controllers/favourite/favourite_controller.dart';
import 'package:test_ecommerce_app/controllers/home/HomeController.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferController.dart';
import 'package:test_ecommerce_app/controllers/offers/search_offer_controller.dart';
import 'package:test_ecommerce_app/controllers/order/order_controller.dart';
import 'package:test_ecommerce_app/controllers/theme/directionality_controller.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';

class Controllers {
  static UserAuthenticationController userAuthenticationController =
      UserAuthenticationController(Get.find());
  static DirectionalityController directionalityController =
      DirectionalityController();
  static OfferController offerController = OfferController(Get.find());
  static CompanyController companyController = CompanyController(Get.find());
  static CartController cartController = CartController(Get.find());
  static HomeController homeController = HomeController(Get.find());
  static SearchOfferController searchOfferController =
      SearchOfferController(Get.find());
  static OrderController orderController = OrderController(Get.find());
  static FavouriteController favouriteController =
      FavouriteController(Get.find());
}
