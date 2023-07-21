import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/cart/cart_binding.dart';
import 'package:test_ecommerce_app/controllers/home/HomeBinding.dart';
import 'package:test_ecommerce_app/controllers/offers/OfferBinding.dart';
import 'package:test_ecommerce_app/controllers/order/order_binding.dart';
import 'package:test_ecommerce_app/views/authentication/otp_login_screen.dart';
import 'package:test_ecommerce_app/views/authentication/recover_password.dart';
import 'package:test_ecommerce_app/views/authentication/register.dart';
import 'package:test_ecommerce_app/views/authentication/splash_screen.dart';
import 'package:test_ecommerce_app/views/authentication/user_location_screen.dart';
import 'package:test_ecommerce_app/views/home/HomePage.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_binding.dart';
import 'package:test_ecommerce_app/controllers/favourite/favourite_binding.dart';
import 'package:test_ecommerce_app/views/home/tabs/offer_tab.dart';
import 'package:test_ecommerce_app/views/merchant/merchant_branches.dart';
import 'package:test_ecommerce_app/views/offer/offer_detail.dart';
import 'package:test_ecommerce_app/controllers/companies/company_binding.dart';
import 'package:test_ecommerce_app/controllers/offers/search_binding.dart';

class Routes {
  static const INITIAL = '/splash';

  static final routes = [
    GetPage(
      name: '/splash',
      page: () => const SplashScreen(),
      binding: UserAuthenticationBinding(),
      transitionDuration: const Duration(seconds: 1),
      transition: Transition.upToDown,
    ),
    GetPage(
        name: '/userLocationScreen',
        page: () => UserLocationScreen(),
        binding: UserAuthenticationBinding()),
    GetPage(
      name: '/login',
      page: () => OTPLoginScreen(),
      binding: UserAuthenticationBinding(),
    ),
    GetPage(
      name: '/register',
      page: () => Register(),
      binding: UserAuthenticationBinding(),
    ),
    GetPage(
      name: '/recovery',
      page: () => RecoverPassword(),
      binding: UserAuthenticationBinding(),
    ),
    GetPage(
      name: '/home',
      page: () => HomePage(recentPage: ExploreTab(), selectedIndex: 0),
      bindings: [
        HomeBinding(),
        OfferBinding(),
        CompanyBinding(),
        SearchBinding(),
        CartBinding(),
        OrderBinding(),
        FavouriteBinding()
      ],
    ),
    GetPage(
      name: '/offerDetail',
      page: () => OfferDetail(
        offerModel: Get.find(),
      ),
      bindings: [OfferBinding(), CompanyBinding()],
    ),
    GetPage(
        name: '/companyBranches',
        page: () => MerchantBranches(companyKey: Get.find()),
        binding: CompanyBinding())
    // GetPage(name: '/offerListForMainCategory', page: ()=>const OfferListForMainCategoryPage(), )
  ];
}
