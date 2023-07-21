import 'package:get/get.dart';
import 'package:test_ecommerce_app/controllers/companies/company_controller.dart';
import 'package:test_ecommerce_app/providers/company_provider.dart';
import 'package:test_ecommerce_app/repositories/company_repository.dart';

class CompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyRepository>(() => CompanyRepository());
    Get.lazyPut<CompanyProvider>(() => CompanyProvider(Get.find()));
    Get.lazyPut<CompanyController>(() => CompanyController(Get.find()));
  }
}
