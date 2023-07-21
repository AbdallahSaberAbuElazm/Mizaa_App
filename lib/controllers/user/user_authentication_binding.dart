import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/providers/user_authentication_provider.dart';
import 'package:test_ecommerce_app/repositories/user_authentication_repository.dart';

class UserAuthenticationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UserAuthenticationRepository>(
        () => UserAuthenticationRepository());
    Get.lazyPut<UserAuthenticationProvider>(
        () => UserAuthenticationProvider(Get.find()));
    Get.lazyPut<UserAuthenticationController>(
        () => UserAuthenticationController(Get.find()));
  }
}
