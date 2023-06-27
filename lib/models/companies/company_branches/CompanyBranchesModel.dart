import 'package:freezed_annotation/freezed_annotation.dart';

part 'CompanyBranchesModel.freezed.dart';
part 'CompanyBranchesModel.g.dart';

@freezed
class CompanyBranchesModel with _$CompanyBranchesModel {
  factory CompanyBranchesModel({
    int? id,
    String? key,
    int? companyId,
    String? title,
    String? enTitle,
    String? address,
    String? enAddress,
    dynamic location,
    String? lat,
    String? long,
    dynamic mobile,
    dynamic phone,
    dynamic whatsapp,
    int? cityId,
  }) = _CompanyBranchesModel;

  factory CompanyBranchesModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyBranchesModelFromJson(json);
}
