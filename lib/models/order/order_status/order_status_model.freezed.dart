// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_status_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderStatusModel _$OrderStatusModelFromJson(Map<String, dynamic> json) {
  return _OrderStatusModel.fromJson(json);
}

/// @nodoc
mixin _$OrderStatusModel {
  int get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get arStatusName => throw _privateConstructorUsedError;
  String get enStatusName => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderStatusModelCopyWith<OrderStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderStatusModelCopyWith<$Res> {
  factory $OrderStatusModelCopyWith(
          OrderStatusModel value, $Res Function(OrderStatusModel) then) =
      _$OrderStatusModelCopyWithImpl<$Res, OrderStatusModel>;
  @useResult
  $Res call({int id, String key, String arStatusName, String enStatusName});
}

/// @nodoc
class _$OrderStatusModelCopyWithImpl<$Res, $Val extends OrderStatusModel>
    implements $OrderStatusModelCopyWith<$Res> {
  _$OrderStatusModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? arStatusName = null,
    Object? enStatusName = null,
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
      arStatusName: null == arStatusName
          ? _value.arStatusName
          : arStatusName // ignore: cast_nullable_to_non_nullable
              as String,
      enStatusName: null == enStatusName
          ? _value.enStatusName
          : enStatusName // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderStatusModelCopyWith<$Res>
    implements $OrderStatusModelCopyWith<$Res> {
  factory _$$_OrderStatusModelCopyWith(
          _$_OrderStatusModel value, $Res Function(_$_OrderStatusModel) then) =
      __$$_OrderStatusModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int id, String key, String arStatusName, String enStatusName});
}

/// @nodoc
class __$$_OrderStatusModelCopyWithImpl<$Res>
    extends _$OrderStatusModelCopyWithImpl<$Res, _$_OrderStatusModel>
    implements _$$_OrderStatusModelCopyWith<$Res> {
  __$$_OrderStatusModelCopyWithImpl(
      _$_OrderStatusModel _value, $Res Function(_$_OrderStatusModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? arStatusName = null,
    Object? enStatusName = null,
  }) {
    return _then(_$_OrderStatusModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      arStatusName: null == arStatusName
          ? _value.arStatusName
          : arStatusName // ignore: cast_nullable_to_non_nullable
              as String,
      enStatusName: null == enStatusName
          ? _value.enStatusName
          : enStatusName // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderStatusModel implements _OrderStatusModel {
  _$_OrderStatusModel(
      {required this.id,
      required this.key,
      required this.arStatusName,
      required this.enStatusName});

  factory _$_OrderStatusModel.fromJson(Map<String, dynamic> json) =>
      _$$_OrderStatusModelFromJson(json);

  @override
  final int id;
  @override
  final String key;
  @override
  final String arStatusName;
  @override
  final String enStatusName;

  @override
  String toString() {
    return 'OrderStatusModel(id: $id, key: $key, arStatusName: $arStatusName, enStatusName: $enStatusName)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderStatusModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.arStatusName, arStatusName) ||
                other.arStatusName == arStatusName) &&
            (identical(other.enStatusName, enStatusName) ||
                other.enStatusName == enStatusName));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, key, arStatusName, enStatusName);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderStatusModelCopyWith<_$_OrderStatusModel> get copyWith =>
      __$$_OrderStatusModelCopyWithImpl<_$_OrderStatusModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderStatusModelToJson(
      this,
    );
  }
}

abstract class _OrderStatusModel implements OrderStatusModel {
  factory _OrderStatusModel(
      {required final int id,
      required final String key,
      required final String arStatusName,
      required final String enStatusName}) = _$_OrderStatusModel;

  factory _OrderStatusModel.fromJson(Map<String, dynamic> json) =
      _$_OrderStatusModel.fromJson;

  @override
  int get id;
  @override
  String get key;
  @override
  String get arStatusName;
  @override
  String get enStatusName;
  @override
  @JsonKey(ignore: true)
  _$$_OrderStatusModelCopyWith<_$_OrderStatusModel> get copyWith =>
      throw _privateConstructorUsedError;
}
