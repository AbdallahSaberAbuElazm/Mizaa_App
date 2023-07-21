// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderDataModel _$OrderDataModelFromJson(Map<String, dynamic> json) {
  return _OrderDataModel.fromJson(json);
}

/// @nodoc
mixin _$OrderDataModel {
  String get applicationUserId => throw _privateConstructorUsedError;
  int get paymentWayId => throw _privateConstructorUsedError;
  double get totalToPay => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get orderDto => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderDataModelCopyWith<OrderDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDataModelCopyWith<$Res> {
  factory $OrderDataModelCopyWith(
          OrderDataModel value, $Res Function(OrderDataModel) then) =
      _$OrderDataModelCopyWithImpl<$Res, OrderDataModel>;
  @useResult
  $Res call(
      {String applicationUserId,
      int paymentWayId,
      double totalToPay,
      List<Map<String, dynamic>> orderDto});
}

/// @nodoc
class _$OrderDataModelCopyWithImpl<$Res, $Val extends OrderDataModel>
    implements $OrderDataModelCopyWith<$Res> {
  _$OrderDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationUserId = null,
    Object? paymentWayId = null,
    Object? totalToPay = null,
    Object? orderDto = null,
  }) {
    return _then(_value.copyWith(
      applicationUserId: null == applicationUserId
          ? _value.applicationUserId
          : applicationUserId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentWayId: null == paymentWayId
          ? _value.paymentWayId
          : paymentWayId // ignore: cast_nullable_to_non_nullable
              as int,
      totalToPay: null == totalToPay
          ? _value.totalToPay
          : totalToPay // ignore: cast_nullable_to_non_nullable
              as double,
      orderDto: null == orderDto
          ? _value.orderDto
          : orderDto // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderDataModelCopyWith<$Res>
    implements $OrderDataModelCopyWith<$Res> {
  factory _$$_OrderDataModelCopyWith(
          _$_OrderDataModel value, $Res Function(_$_OrderDataModel) then) =
      __$$_OrderDataModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String applicationUserId,
      int paymentWayId,
      double totalToPay,
      List<Map<String, dynamic>> orderDto});
}

/// @nodoc
class __$$_OrderDataModelCopyWithImpl<$Res>
    extends _$OrderDataModelCopyWithImpl<$Res, _$_OrderDataModel>
    implements _$$_OrderDataModelCopyWith<$Res> {
  __$$_OrderDataModelCopyWithImpl(
      _$_OrderDataModel _value, $Res Function(_$_OrderDataModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? applicationUserId = null,
    Object? paymentWayId = null,
    Object? totalToPay = null,
    Object? orderDto = null,
  }) {
    return _then(_$_OrderDataModel(
      applicationUserId: null == applicationUserId
          ? _value.applicationUserId
          : applicationUserId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentWayId: null == paymentWayId
          ? _value.paymentWayId
          : paymentWayId // ignore: cast_nullable_to_non_nullable
              as int,
      totalToPay: null == totalToPay
          ? _value.totalToPay
          : totalToPay // ignore: cast_nullable_to_non_nullable
              as double,
      orderDto: null == orderDto
          ? _value._orderDto
          : orderDto // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderDataModel implements _OrderDataModel {
  _$_OrderDataModel(
      {required this.applicationUserId,
      required this.paymentWayId,
      required this.totalToPay,
      required final List<Map<String, dynamic>> orderDto})
      : _orderDto = orderDto;

  factory _$_OrderDataModel.fromJson(Map<String, dynamic> json) =>
      _$$_OrderDataModelFromJson(json);

  @override
  final String applicationUserId;
  @override
  final int paymentWayId;
  @override
  final double totalToPay;
  final List<Map<String, dynamic>> _orderDto;
  @override
  List<Map<String, dynamic>> get orderDto {
    if (_orderDto is EqualUnmodifiableListView) return _orderDto;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderDto);
  }

  @override
  String toString() {
    return 'OrderDataModel(applicationUserId: $applicationUserId, paymentWayId: $paymentWayId, totalToPay: $totalToPay, orderDto: $orderDto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderDataModel &&
            (identical(other.applicationUserId, applicationUserId) ||
                other.applicationUserId == applicationUserId) &&
            (identical(other.paymentWayId, paymentWayId) ||
                other.paymentWayId == paymentWayId) &&
            (identical(other.totalToPay, totalToPay) ||
                other.totalToPay == totalToPay) &&
            const DeepCollectionEquality().equals(other._orderDto, _orderDto));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, applicationUserId, paymentWayId,
      totalToPay, const DeepCollectionEquality().hash(_orderDto));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderDataModelCopyWith<_$_OrderDataModel> get copyWith =>
      __$$_OrderDataModelCopyWithImpl<_$_OrderDataModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderDataModelToJson(
      this,
    );
  }
}

abstract class _OrderDataModel implements OrderDataModel {
  factory _OrderDataModel(
      {required final String applicationUserId,
      required final int paymentWayId,
      required final double totalToPay,
      required final List<Map<String, dynamic>> orderDto}) = _$_OrderDataModel;

  factory _OrderDataModel.fromJson(Map<String, dynamic> json) =
      _$_OrderDataModel.fromJson;

  @override
  String get applicationUserId;
  @override
  int get paymentWayId;
  @override
  double get totalToPay;
  @override
  List<Map<String, dynamic>> get orderDto;
  @override
  @JsonKey(ignore: true)
  _$$_OrderDataModelCopyWith<_$_OrderDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}
