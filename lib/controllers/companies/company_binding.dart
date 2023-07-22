import 'package:get/get.dart';
import 'package:mizaa/controllers/companies/company_controller.dart';
import 'package:mizaa/providers/company_provider.dart';
import 'package:mizaa/repositories/company_repository.dart';

class CompanyBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CompanyRepository>(() => CompanyRepository());
    Get.lazyPut<CompanyProvider>(() => CompanyProvider(Get.find()));
    Get.lazyPut<CompanyController>(() => CompanyController(Get.find()));
  }
}
