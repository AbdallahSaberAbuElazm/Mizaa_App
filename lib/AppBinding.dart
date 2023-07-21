import 'package:test_ecommerce_app/controllers/theme/directionality_controller.dart';
import 'package:test_ecommerce_app/controllers/user/user_authentication_controller.dart';
import 'package:test_ecommerce_app/providers/user_authentication_provider.dart';
import 'package:test_ecommerce_app/repositories/user_authentication_repository.dart';
import 'package:test_ecommerce_app/services/networking/ApiService.dart';
import 'package:test_ecommerce_app/services/networking/BaseProvider.dart';
import 'package:get/instance_manager.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(BaseProvider(), permanent: true);
    Get.put(ApiService(Get.find()), permanent: true);
    Get.put(DirectionalityController(), permanent: true);
    Get.put<UserAuthenticationRepository>(UserAuthenticationRepository());
    Get.put<UserAuthenticationProvider>(UserAuthenticationProvider(Get.find()));
    Get.put<UserAuthenticationController>(
        UserAuthenticationController(Get.find()));
  }
}
