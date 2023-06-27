// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'merchant_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MerchantModel _$MerchantModelFromJson(Map<String, dynamic> json) {
  return _MerchantModel.fromJson(json);
}

/// @nodoc
mixin _$MerchantModel {
  int? get count => throw _privateConstructorUsedError;
  String? get arname => throw _privateConstructorUsedError;
  String? get enname => throw _privateConstructorUsedError;
  String? get logo => throw _privateConstructorUsedError;
  String? get key => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MerchantModelCopyWith<MerchantModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MerchantModelCopyWith<$Res> {
  factory $MerchantModelCopyWith(
          MerchantModel value, $Res Function(MerchantModel) then) =
      _$MerchantModelCopyWithImpl<$Res, MerchantModel>;
  @useResult
  $Res call(
      {int? count, String? arname, String? enname, String? logo, String? key});
}

/// @nodoc
class _$MerchantModelCopyWithImpl<$Res, $Val extends MerchantModel>
    implements $MerchantModelCopyWith<$Res> {
  _$MerchantModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
    Object? arname = freezed,
    Object? enname = freezed,
    Object? logo = freezed,
    Object? key = freezed,
  }) {
    return _then(_value.copyWith(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      arname: freezed == arname
          ? _value.arname
          : arname // ignore: cast_nullable_to_non_nullable
              as String?,
      enname: freezed == enname
          ? _value.enname
          : enname // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_MerchantModelCopyWith<$Res>
    implements $MerchantModelCopyWith<$Res> {
  factory _$$_MerchantModelCopyWith(
          _$_MerchantModel value, $Res Function(_$_MerchantModel) then) =
      __$$_MerchantModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? count, String? arname, String? enname, String? logo, String? key});
}

/// @nodoc
class __$$_MerchantModelCopyWithImpl<$Res>
    extends _$MerchantModelCopyWithImpl<$Res, _$_MerchantModel>
    implements _$$_MerchantModelCopyWith<$Res> {
  __$$_MerchantModelCopyWithImpl(
      _$_MerchantModel _value, $Res Function(_$_MerchantModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? count = freezed,
    Object? arname = freezed,
    Object? enname = freezed,
    Object? logo = freezed,
    Object? key = freezed,
  }) {
    return _then(_$_MerchantModel(
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      arname: freezed == arname
          ? _value.arname
          : arname // ignore: cast_nullable_to_non_nullable
              as String?,
      enname: freezed == enname
          ? _value.enname
          : enname // ignore: cast_nullable_to_non_nullable
              as String?,
      logo: freezed == logo
          ? _value.logo
          : logo // ignore: cast_nullable_to_non_nullable
              as String?,
      key: freezed == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MerchantModel implements _MerchantModel {
  _$_MerchantModel({this.count, this.arname, this.enname, this.logo, this.key});

  factory _$_MerchantModel.fromJson(Map<String, dynamic> json) =>
      _$$_MerchantModelFromJson(json);

  @override
  final int? count;
  @override
  final String? arname;
  @override
  final String? enname;
  @override
  final String? logo;
  @override
  final String? key;

  @override
  String toString() {
    return 'MerchantModel(count: $count, arname: $arname, enname: $enname, logo: $logo, key: $key)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MerchantModel &&
            (identical(other.count, count) || other.count == count) &&
            (identical(other.arname, arname) || other.arname == arname) &&
            (identical(other.enname, enname) || other.enname == enname) &&
            (identical(other.logo, logo) || other.logo == logo) &&
            (identical(other.key, key) || other.key == key));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, count, arname, enname, logo, key);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MerchantModelCopyWith<_$_MerchantModel> get copyWith =>
      __$$_MerchantModelCopyWithImpl<_$_MerchantModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MerchantModelToJson(
      this,
    );
  }
}

abstract class _MerchantModel implements MerchantModel {
  factory _MerchantModel(
      {final int? count,
      final String? arname,
      final String? enname,
      final String? logo,
      final String? key}) = _$_MerchantModel;

  factory _MerchantModel.fromJson(Map<String, dynamic> json) =
      _$_MerchantModel.fromJson;

  @override
  int? get count;
  @override
  String? get arname;
  @override
  String? get enname;
  @override
  String? get logo;
  @override
  String? get key;
  @override
  @JsonKey(ignore: true)
  _$$_MerchantModelCopyWith<_$_MerchantModel> get copyWith =>
      throw _privateConstructorUsedError;
}
