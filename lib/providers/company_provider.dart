
import 'package:test_ecommerce_app/models/companies/CompanyModel.dart';
import 'package:test_ecommerce_app/models/companies/company_branches/CompanyBranchesModel.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/repositories/company_repository.dart';

class CompanyProvider {
  CompanyRepository _companyRepository;
  CompanyProvider(this._companyRepository);

  Future<List<CompanyBranchesModel>> getCompanyBranches({required String cityId, required String companyKey}) async {
    return await _companyRepository.getCompanyBranches(cityId: cityId, companyKey: companyKey);
  }

  Future<List<OfferModel>> getOffersForCompany({ required String companyId}) async {
    return await _companyRepository.getOffersForCompany(companyId: companyId);
  }
}