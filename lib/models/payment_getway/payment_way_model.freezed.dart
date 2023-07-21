// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_way_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentWayModel _$PaymentWayModelFromJson(Map<String, dynamic> json) {
  return _PaymentWayModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentWayModel {
  int get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get enName => throw _privateConstructorUsedError;
  int get displayOrder => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentWayModelCopyWith<PaymentWayModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentWayModelCopyWith<$Res> {
  factory $PaymentWayModelCopyWith(
          PaymentWayModel value, $Res Function(PaymentWayModel) then) =
      _$PaymentWayModelCopyWithImpl<$Res, PaymentWayModel>;
  @useResult
  $Res call({int id, String key, String name, String enName, int displayOrder});
}

/// @nodoc
class _$PaymentWayModelCopyWithImpl<$Res, $Val extends PaymentWayModel>
    implements $PaymentWayModelCopyWith<$Res> {
  _$PaymentWayModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? name = null,
    Object? enName = null,
    Object? displayOrder = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      enName: null == enName
          ? _value.enName
          : enName // ignore: cast_nullable_to_non_nullable
              as String,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentWayModelCopyWith<$Res>
    implements $PaymentWayModelCopyWith<$Res> {
  factory _$$_PaymentWayModelCopyWith(
          _$_PaymentWayModel value, $Res Function(_$_PaymentWayModel) then) =
      __$$_PaymentWayModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String key, String name, String enName, int displayOrder});
}

/// @nodoc
class __$$_PaymentWayModelCopyWithImpl<$Res>
    extends _$PaymentWayModelCopyWithImpl<$Res, _$_PaymentWayModel>
    implements _$$_PaymentWayModelCopyWith<$Res> {
  __$$_PaymentWayModelCopyWithImpl(
      _$_PaymentWayModel _value, $Res Function(_$_PaymentWayModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? name = null,
    Object? enName = null,
    Object? displayOrder = null,
  }) {
    return _then(_$_PaymentWayModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      enName: null == enName
          ? _value.enName
          : enName // ignore: cast_nullable_to_non_nullable
              as String,
      displayOrder: null == displayOrder
          ? _value.displayOrder
          : displayOrder // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentWayModel implements _PaymentWayModel {
  _$_PaymentWayModel(
      {required this.id,
      required this.key,
      required this.name,
      required this.enName,
      required this.displayOrder});

  factory _$_PaymentWayModel.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentWayModelFromJson(json);

  @override
  final int id;
  @override
  final String key;
  @override
  final String name;
  @override
  final String enName;
  @override
  final int displayOrder;

  @override
  String toString() {
    return 'PaymentWayModel(id: $id, key: $key, name: $name, enName: $enName, displayOrder: $displayOrder)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentWayModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.enName, enName) || other.enName == enName) &&
            (identical(other.displayOrder, displayOrder) ||
                other.displayOrder == displayOrder));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, key, name, enName, displayOrder);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentWayModelCopyWith<_$_PaymentWayModel> get copyWith =>
      __$$_PaymentWayModelCopyWithImpl<_$_PaymentWayModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentWayModelToJson(
      this,
    );
  }
}

abstract class _PaymentWayModel implements PaymentWayModel {
  factory _PaymentWayModel(
      {required final int id,
      required final String key,
      required final String name,
      required final String enName,
      required final int displayOrder}) = _$_PaymentWayModel;

  factory _PaymentWayModel.fromJson(Map<String, dynamic> json) =
      _$_PaymentWayModel.fromJson;

  @override
  int get id;
  @override
  String get key;
  @override
  String get name;
  @override
  String get enName;
  @override
  int get displayOrder;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentWayModelCopyWith<_$_PaymentWayModel> get copyWith =>
      throw _privateConstructorUsedError;
}
