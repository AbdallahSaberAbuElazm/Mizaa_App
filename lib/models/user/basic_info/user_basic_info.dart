import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_basic_info.freezed.dart';
part 'user_basic_info.g.dart';

@freezed
class UserBasicInfo with _$UserBasicInfo{
  factory UserBasicInfo({
  required String name,
  required String mobile,
  required String applicationUserId,
  required double balance,
  required int points,
  required int city,
  required int country,}) = _UserBasicInfo;

  factory UserBasicInfo.fromJson(Map<String, dynamic> json) =>
      _$UserBasicInfoFromJson(json);

}