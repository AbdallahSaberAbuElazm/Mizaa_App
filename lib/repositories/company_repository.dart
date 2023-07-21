import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:test_ecommerce_app/models/companies/CompanyModel.dart';
import 'package:test_ecommerce_app/models/companies/company_branches/CompanyBranchesModel.dart';
import 'package:test_ecommerce_app/models/offers/OfferModel.dart';
import 'package:test_ecommerce_app/services/networking/ApiConstants.dart';
import 'package:test_ecommerce_app/shared/error/exception.dart';

class CompanyRepository {
  Future<List<CompanyBranchesModel>> getCompanyBranches(
      {required String cityId, required String companyKey}) async {
    var response = await http.get(
        Uri.parse('${ApiConstants.getCompanyBranches}$companyKey/$cityId'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => CompanyBranchesModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  Future<List<OfferModel>> getOffersForCompany(
      {required String companyId}) async {
    var response = await http
        .get(Uri.parse('${ApiConstants.companiesByCityIdAndCatId}$companyId'));
    if (response.statusCode == 200) {
      final List<dynamic> body = json.decode(response.body);
      return body.map((json) => OfferModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }
}
