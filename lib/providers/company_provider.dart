import 'package:mizaa/models/companies/CompanyModel.dart';
import 'package:mizaa/models/companies/company_branches/CompanyBranchesModel.dart';
import 'package:mizaa/models/offers/OfferModel.dart';
import 'package:mizaa/repositories/company_repository.dart';

class CompanyProvider {
  CompanyRepository _companyRepository;
  CompanyProvider(this._companyRepository);

  Future<List<CompanyBranchesModel>> getCompanyBranches(
      {required String cityId, required String companyKey}) async {
    return await _companyRepository.getCompanyBranches(
        cityId: cityId, companyKey: companyKey);
  }

  Future<List<OfferModel>> getOffersForCompany(
      {required String companyId}) async {
    return await _companyRepository.getOffersForCompany(companyId: companyId);
  }
}
