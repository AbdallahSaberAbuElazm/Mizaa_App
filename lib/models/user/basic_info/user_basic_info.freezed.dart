// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_basic_info.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserBasicInfo _$UserBasicInfoFromJson(Map<String, dynamic> json) {
  return _UserBasicInfo.fromJson(json);
}

/// @nodoc
mixin _$UserBasicInfo {
  String get name => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  String get applicationUserId => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get city => throw _privateConstructorUsedError;
  int get country => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserBasicInfoCopyWith<UserBasicInfo> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserBasicInfoCopyWith<$Res> {
  factory $UserBasicInfoCopyWith(
          UserBasicInfo value, $Res Function(UserBasicInfo) then) =
      _$UserBasicInfoCopyWithImpl<$Res, UserBasicInfo>;
  @useResult
  $Res call(
      {String name,
      String mobile,
      String applicationUserId,
      double balance,
      int points,
      int city,
      int country});
}

/// @nodoc
class _$UserBasicInfoCopyWithImpl<$Res, $Val extends UserBasicInfo>
    implements $UserBasicInfoCopyWith<$Res> {
  _$UserBasicInfoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? mobile = null,
    Object? applicationUserId = null,
    Object? balance = null,
    Object? points = null,
    Object? city = null,
    Object? country = null,
  }) {
    return _then(_value.copyWith(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mobile: null == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String,
      applicationUserId: null == applicationUserId
          ? _value.applicationUserId
          : applicationUserId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as int,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserBasicInfoCopyWith<$Res>
    implements $UserBasicInfoCopyWith<$Res> {
  factory _$$_UserBasicInfoCopyWith(
          _$_UserBasicInfo value, $Res Function(_$_UserBasicInfo) then) =
      __$$_UserBasicInfoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String mobile,
      String applicationUserId,
      double balance,
      int points,
      int city,
      int country});
}

/// @nodoc
class __$$_UserBasicInfoCopyWithImpl<$Res>
    extends _$UserBasicInfoCopyWithImpl<$Res, _$_UserBasicInfo>
    implements _$$_UserBasicInfoCopyWith<$Res> {
  __$$_UserBasicInfoCopyWithImpl(
      _$_UserBasicInfo _value, $Res Function(_$_UserBasicInfo) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? mobile = null,
    Object? applicationUserId = null,
    Object? balance = null,
    Object? points = null,
    Object? city = null,
    Object? country = null,
  }) {
    return _then(_$_UserBasicInfo(
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      mobile: null == mobile
          ? _value.mobile
          : mobile // ignore: cast_nullable_to_non_nullable
              as String,
      applicationUserId: null == applicationUserId
          ? _value.applicationUserId
          : applicationUserId // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      points: null == points
          ? _value.points
          : points // ignore: cast_nullable_to_non_nullable
              as int,
      city: null == city
          ? _value.city
          : city // ignore: cast_nullable_to_non_nullable
              as int,
      country: null == country
          ? _value.country
          : country // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserBasicInfo implements _UserBasicInfo {
  _$_UserBasicInfo(
      {required this.name,
      required this.mobile,
      required this.applicationUserId,
      required this.balance,
      required this.points,
      required this.city,
      required this.country});

  factory _$_UserBasicInfo.fromJson(Map<String, dynamic> json) =>
      _$$_UserBasicInfoFromJson(json);

  @override
  final String name;
  @override
  final String mobile;
  @override
  final String applicationUserId;
  @override
  final double balance;
  @override
  final int points;
  @override
  final int city;
  @override
  final int country;

  @override
  String toString() {
    return 'UserBasicInfo(name: $name, mobile: $mobile, applicationUserId: $applicationUserId, balance: $balance, points: $points, city: $city, country: $country)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserBasicInfo &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.applicationUserId, applicationUserId) ||
                other.applicationUserId == applicationUserId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, mobile, applicationUserId,
      balance, points, city, country);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserBasicInfoCopyWith<_$_UserBasicInfo> get copyWith =>
      __$$_UserBasicInfoCopyWithImpl<_$_UserBasicInfo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserBasicInfoToJson(
      this,
    );
  }
}

abstract class _UserBasicInfo implements UserBasicInfo {
  factory _UserBasicInfo(
      {required final String name,
      required final String mobile,
      required final String applicationUserId,
      required final double balance,
      required final int points,
      required final int city,
      required final int country}) = _$_UserBasicInfo;

  factory _UserBasicInfo.fromJson(Map<String, dynamic> json) =
      _$_UserBasicInfo.fromJson;

  @override
  String get name;
  @override
  String get mobile;
  @override
  String get applicationUserId;
  @override
  double get balance;
  @override
  int get points;
  @override
  int get city;
  @override
  int get country;
  @override
  @JsonKey(ignore: true)
  _$$_UserBasicInfoCopyWith<_$_UserBasicInfo> get copyWith =>
      throw _privateConstructorUsedError;
}
