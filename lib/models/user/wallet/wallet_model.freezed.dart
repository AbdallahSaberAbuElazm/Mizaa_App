// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'wallet_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

WalletModel _$WalletModelFromJson(Map<String, dynamic> json) {
  return _WalletModel.fromJson(json);
}

/// @nodoc
mixin _$WalletModel {
  String get name => throw _privateConstructorUsedError;
  String get mobile => throw _privateConstructorUsedError;
  String get applicationUserId => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  int get points => throw _privateConstructorUsedError;
  int get city => throw _privateConstructorUsedError;
  int get country => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get walletHistory =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $WalletModelCopyWith<WalletModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WalletModelCopyWith<$Res> {
  factory $WalletModelCopyWith(
          WalletModel value, $Res Function(WalletModel) then) =
      _$WalletModelCopyWithImpl<$Res, WalletModel>;
  @useResult
  $Res call(
      {String name,
      String mobile,
      String applicationUserId,
      double balance,
      int points,
      int city,
      int country,
      List<Map<String, dynamic>> walletHistory});
}

/// @nodoc
class _$WalletModelCopyWithImpl<$Res, $Val extends WalletModel>
    implements $WalletModelCopyWith<$Res> {
  _$WalletModelCopyWithImpl(this._value, this._then);

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
    Object? walletHistory = null,
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
      walletHistory: null == walletHistory
          ? _value.walletHistory
          : walletHistory // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_WalletModelCopyWith<$Res>
    implements $WalletModelCopyWith<$Res> {
  factory _$$_WalletModelCopyWith(
          _$_WalletModel value, $Res Function(_$_WalletModel) then) =
      __$$_WalletModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String name,
      String mobile,
      String applicationUserId,
      double balance,
      int points,
      int city,
      int country,
      List<Map<String, dynamic>> walletHistory});
}

/// @nodoc
class __$$_WalletModelCopyWithImpl<$Res>
    extends _$WalletModelCopyWithImpl<$Res, _$_WalletModel>
    implements _$$_WalletModelCopyWith<$Res> {
  __$$_WalletModelCopyWithImpl(
      _$_WalletModel _value, $Res Function(_$_WalletModel) _then)
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
    Object? walletHistory = null,
  }) {
    return _then(_$_WalletModel(
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
      walletHistory: null == walletHistory
          ? _value._walletHistory
          : walletHistory // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_WalletModel implements _WalletModel {
  _$_WalletModel(
      {required this.name,
      required this.mobile,
      required this.applicationUserId,
      required this.balance,
      required this.points,
      required this.city,
      required this.country,
      required final List<Map<String, dynamic>> walletHistory})
      : _walletHistory = walletHistory;

  factory _$_WalletModel.fromJson(Map<String, dynamic> json) =>
      _$$_WalletModelFromJson(json);

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
  final List<Map<String, dynamic>> _walletHistory;
  @override
  List<Map<String, dynamic>> get walletHistory {
    if (_walletHistory is EqualUnmodifiableListView) return _walletHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_walletHistory);
  }

  @override
  String toString() {
    return 'WalletModel(name: $name, mobile: $mobile, applicationUserId: $applicationUserId, balance: $balance, points: $points, city: $city, country: $country, walletHistory: $walletHistory)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_WalletModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.mobile, mobile) || other.mobile == mobile) &&
            (identical(other.applicationUserId, applicationUserId) ||
                other.applicationUserId == applicationUserId) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.points, points) || other.points == points) &&
            (identical(other.city, city) || other.city == city) &&
            (identical(other.country, country) || other.country == country) &&
            const DeepCollectionEquality()
                .equals(other._walletHistory, _walletHistory));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      name,
      mobile,
      applicationUserId,
      balance,
      points,
      city,
      country,
      const DeepCollectionEquality().hash(_walletHistory));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_WalletModelCopyWith<_$_WalletModel> get copyWith =>
      __$$_WalletModelCopyWithImpl<_$_WalletModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_WalletModelToJson(
      this,
    );
  }
}

abstract class _WalletModel implements WalletModel {
  factory _WalletModel(
          {required final String name,
          required final String mobile,
          required final String applicationUserId,
          required final double balance,
          required final int points,
          required final int city,
          required final int country,
          required final List<Map<String, dynamic>> walletHistory}) =
      _$_WalletModel;

  factory _WalletModel.fromJson(Map<String, dynamic> json) =
      _$_WalletModel.fromJson;

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
  List<Map<String, dynamic>> get walletHistory;
  @override
  @JsonKey(ignore: true)
  _$$_WalletModelCopyWith<_$_WalletModel> get copyWith =>
      throw _privateConstructorUsedError;
}
