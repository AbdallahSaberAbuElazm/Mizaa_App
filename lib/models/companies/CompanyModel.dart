import 'package:test_ecommerce_app/models/companies/company_branches/CompanyBranchesModel.dart';
import 'package:test_ecommerce_app/shared/typedef.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'CompanyModel.freezed.dart';
part 'CompanyModel.g.dart';

@freezed
class CompanyModel with _$CompanyModel {
  factory CompanyModel({
    int? id,
    String? key,
    String? arName,
    String? enName,
    String? description,
    String? enDescription,
    String? headerPhoto,
    String? logo,
    String? facebook,
    String? twitter,
    String? whatsapp,
    String? instegram,
    String? snapchat,
    String? tiktok,
    String? youtube,
    String? website,
    String? creationDate,
    List<Map<String,dynamic>>? companyBrunches,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) => _$CompanyModelFromJson(json);


}
