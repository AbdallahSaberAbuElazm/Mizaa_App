// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'OfferRateModel.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OfferRateModel _$OfferRateModelFromJson(Map<String, dynamic> json) {
  return _OfferRateModel.fromJson(json);
}

/// @nodoc
mixin _$OfferRateModel {
  String? get username => throw _privateConstructorUsedError;
  double? get rate => throw _privateConstructorUsedError;
  DateTime? get creation => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OfferRateModelCopyWith<OfferRateModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferRateModelCopyWith<$Res> {
  factory $OfferRateModelCopyWith(
          OfferRateModel value, $Res Function(OfferRateModel) then) =
      _$OfferRateModelCopyWithImpl<$Res, OfferRateModel>;
  @useResult
  $Res call({String? username, double? rate, DateTime? creation});
}

/// @nodoc
class _$OfferRateModelCopyWithImpl<$Res, $Val extends OfferRateModel>
    implements $OfferRateModelCopyWith<$Res> {
  _$OfferRateModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? rate = freezed,
    Object? creation = freezed,
  }) {
    return _then(_value.copyWith(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      rate: freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      creation: freezed == creation
          ? _value.creation
          : creation // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OfferRateModelCopyWith<$Res>
    implements $OfferRateModelCopyWith<$Res> {
  factory _$$_OfferRateModelCopyWith(
          _$_OfferRateModel value, $Res Function(_$_OfferRateModel) then) =
      __$$_OfferRateModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? username, double? rate, DateTime? creation});
}

/// @nodoc
class __$$_OfferRateModelCopyWithImpl<$Res>
    extends _$OfferRateModelCopyWithImpl<$Res, _$_OfferRateModel>
    implements _$$_OfferRateModelCopyWith<$Res> {
  __$$_OfferRateModelCopyWithImpl(
      _$_OfferRateModel _value, $Res Function(_$_OfferRateModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? username = freezed,
    Object? rate = freezed,
    Object? creation = freezed,
  }) {
    return _then(_$_OfferRateModel(
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      rate: freezed == rate
          ? _value.rate
          : rate // ignore: cast_nullable_to_non_nullable
              as double?,
      creation: freezed == creation
          ? _value.creation
          : creation // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OfferRateModel implements _OfferRateModel {
  _$_OfferRateModel({this.username, this.rate, this.creation});

  factory _$_OfferRateModel.fromJson(Map<String, dynamic> json) =>
      _$$_OfferRateModelFromJson(json);

  @override
  final String? username;
  @override
  final double? rate;
  @override
  final DateTime? creation;

  @override
  String toString() {
    return 'OfferRateModel(username: $username, rate: $rate, creation: $creation)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OfferRateModel &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.rate, rate) || other.rate == rate) &&
            (identical(other.creation, creation) ||
                other.creation == creation));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, username, rate, creation);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OfferRateModelCopyWith<_$_OfferRateModel> get copyWith =>
      __$$_OfferRateModelCopyWithImpl<_$_OfferRateModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OfferRateModelToJson(
      this,
    );
  }
}

abstract class _OfferRateModel implements OfferRateModel {
  factory _OfferRateModel(
      {final String? username,
      final double? rate,
      final DateTime? creation}) = _$_OfferRateModel;

  factory _OfferRateModel.fromJson(Map<String, dynamic> json) =
      _$_OfferRateModel.fromJson;

  @override
  String? get username;
  @override
  double? get rate;
  @override
  DateTime? get creation;
  @override
  @JsonKey(ignore: true)
  _$$_OfferRateModelCopyWith<_$_OfferRateModel> get copyWith =>
      throw _privateConstructorUsedError;
}
