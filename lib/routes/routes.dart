import 'package:get/get.dart';
import 'package:mizaa/controllers/cart/cart_binding.dart';
import 'package:mizaa/controllers/home/HomeBinding.dart';
import 'package:mizaa/controllers/offers/OfferBinding.dart';
import 'package:mizaa/controllers/order/order_binding.dart';
import 'package:mizaa/views/authentication/otp_login_screen.dart';
import 'package:mizaa/views/authentication/recover_password.dart';
import 'package:mizaa/views/authentication/register.dart';
import 'package:mizaa/views/authentication/splash_screen.dart';
import 'package:mizaa/views/authentication/user_location_screen.dart';
import 'package:mizaa/views/home/HomePage.dart';
import 'package:mizaa/controllers/user/user_authentication_binding.dart';
import 'package:mizaa/controllers/favourite/favourite_binding.dart';
import 'package:mizaa/views/home/tabs/offer_tab.dart';
import 'package:mizaa/views/merchant/merchant_branches.dart';
import 'package:mizaa/views/offer/offer_detail.dart';
import 'package:mizaa/controllers/companies/company_binding.dart';
import 'package:mizaa/controllers/offers/search_binding.dart';

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
