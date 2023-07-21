// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) {
  return _OrderModel.fromJson(json);
}

/// @nodoc
mixin _$OrderModel {
  int get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  String get applicationUserId => throw _privateConstructorUsedError;
  Map<String, dynamic> get paymentWay => throw _privateConstructorUsedError;
  int get paymentWayId => throw _privateConstructorUsedError;
  Map<String, dynamic> get orderStatus => throw _privateConstructorUsedError;
  int get orderStatusId => throw _privateConstructorUsedError;
  DateTime get creationDate => throw _privateConstructorUsedError;
  double get totalToPay => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get order => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderModelCopyWith<OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderModelCopyWith<$Res> {
  factory $OrderModelCopyWith(
          OrderModel value, $Res Function(OrderModel) then) =
      _$OrderModelCopyWithImpl<$Res, OrderModel>;
  @useResult
  $Res call(
      {int id,
      String key,
      String applicationUserId,
      Map<String, dynamic> paymentWay,
      int paymentWayId,
      Map<String, dynamic> orderStatus,
      int orderStatusId,
      DateTime creationDate,
      double totalToPay,
      List<Map<String, dynamic>> order});
}

/// @nodoc
class _$OrderModelCopyWithImpl<$Res, $Val extends OrderModel>
    implements $OrderModelCopyWith<$Res> {
  _$OrderModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? applicationUserId = null,
    Object? paymentWay = null,
    Object? paymentWayId = null,
    Object? orderStatus = null,
    Object? orderStatusId = null,
    Object? creationDate = null,
    Object? totalToPay = null,
    Object? order = null,
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
      applicationUserId: null == applicationUserId
          ? _value.applicationUserId
          : applicationUserId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentWay: null == paymentWay
          ? _value.paymentWay
          : paymentWay // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      paymentWayId: null == paymentWayId
          ? _value.paymentWayId
          : paymentWayId // ignore: cast_nullable_to_non_nullable
              as int,
      orderStatus: null == orderStatus
          ? _value.orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      orderStatusId: null == orderStatusId
          ? _value.orderStatusId
          : orderStatusId // ignore: cast_nullable_to_non_nullable
              as int,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalToPay: null == totalToPay
          ? _value.totalToPay
          : totalToPay // ignore: cast_nullable_to_non_nullable
              as double,
      order: null == order
          ? _value.order
          : order // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderModelCopyWith<$Res>
    implements $OrderModelCopyWith<$Res> {
  factory _$$_OrderModelCopyWith(
          _$_OrderModel value, $Res Function(_$_OrderModel) then) =
      __$$_OrderModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String key,
      String applicationUserId,
      Map<String, dynamic> paymentWay,
      int paymentWayId,
      Map<String, dynamic> orderStatus,
      int orderStatusId,
      DateTime creationDate,
      double totalToPay,
      List<Map<String, dynamic>> order});
}

/// @nodoc
class __$$_OrderModelCopyWithImpl<$Res>
    extends _$OrderModelCopyWithImpl<$Res, _$_OrderModel>
    implements _$$_OrderModelCopyWith<$Res> {
  __$$_OrderModelCopyWithImpl(
      _$_OrderModel _value, $Res Function(_$_OrderModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? applicationUserId = null,
    Object? paymentWay = null,
    Object? paymentWayId = null,
    Object? orderStatus = null,
    Object? orderStatusId = null,
    Object? creationDate = null,
    Object? totalToPay = null,
    Object? order = null,
  }) {
    return _then(_$_OrderModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      applicationUserId: null == applicationUserId
          ? _value.applicationUserId
          : applicationUserId // ignore: cast_nullable_to_non_nullable
              as String,
      paymentWay: null == paymentWay
          ? _value._paymentWay
          : paymentWay // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      paymentWayId: null == paymentWayId
          ? _value.paymentWayId
          : paymentWayId // ignore: cast_nullable_to_non_nullable
              as int,
      orderStatus: null == orderStatus
          ? _value._orderStatus
          : orderStatus // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
      orderStatusId: null == orderStatusId
          ? _value.orderStatusId
          : orderStatusId // ignore: cast_nullable_to_non_nullable
              as int,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      totalToPay: null == totalToPay
          ? _value.totalToPay
          : totalToPay // ignore: cast_nullable_to_non_nullable
              as double,
      order: null == order
          ? _value._order
          : order // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderModel implements _OrderModel {
  _$_OrderModel(
      {required this.id,
      required this.key,
      required this.applicationUserId,
      required final Map<String, dynamic> paymentWay,
      required this.paymentWayId,
      required final Map<String, dynamic> orderStatus,
      required this.orderStatusId,
      required this.creationDate,
      required this.totalToPay,
      required final List<Map<String, dynamic>> order})
      : _paymentWay = paymentWay,
        _orderStatus = orderStatus,
        _order = order;

  factory _$_OrderModel.fromJson(Map<String, dynamic> json) =>
      _$$_OrderModelFromJson(json);

  @override
  final int id;
  @override
  final String key;
  @override
  final String applicationUserId;
  final Map<String, dynamic> _paymentWay;
  @override
  Map<String, dynamic> get paymentWay {
    if (_paymentWay is EqualUnmodifiableMapView) return _paymentWay;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_paymentWay);
  }

  @override
  final int paymentWayId;
  final Map<String, dynamic> _orderStatus;
  @override
  Map<String, dynamic> get orderStatus {
    if (_orderStatus is EqualUnmodifiableMapView) return _orderStatus;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_orderStatus);
  }

  @override
  final int orderStatusId;
  @override
  final DateTime creationDate;
  @override
  final double totalToPay;
  final List<Map<String, dynamic>> _order;
  @override
  List<Map<String, dynamic>> get order {
    if (_order is EqualUnmodifiableListView) return _order;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_order);
  }

  @override
  String toString() {
    return 'OrderModel(id: $id, key: $key, applicationUserId: $applicationUserId, paymentWay: $paymentWay, paymentWayId: $paymentWayId, orderStatus: $orderStatus, orderStatusId: $orderStatusId, creationDate: $creationDate, totalToPay: $totalToPay, order: $order)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.applicationUserId, applicationUserId) ||
                other.applicationUserId == applicationUserId) &&
            const DeepCollectionEquality()
                .equals(other._paymentWay, _paymentWay) &&
            (identical(other.paymentWayId, paymentWayId) ||
                other.paymentWayId == paymentWayId) &&
            const DeepCollectionEquality()
                .equals(other._orderStatus, _orderStatus) &&
            (identical(other.orderStatusId, orderStatusId) ||
                other.orderStatusId == orderStatusId) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.totalToPay, totalToPay) ||
                other.totalToPay == totalToPay) &&
            const DeepCollectionEquality().equals(other._order, _order));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      key,
      applicationUserId,
      const DeepCollectionEquality().hash(_paymentWay),
      paymentWayId,
      const DeepCollectionEquality().hash(_orderStatus),
      orderStatusId,
      creationDate,
      totalToPay,
      const DeepCollectionEquality().hash(_order));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderModelCopyWith<_$_OrderModel> get copyWith =>
      __$$_OrderModelCopyWithImpl<_$_OrderModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderModelToJson(
      this,
    );
  }
}

abstract class _OrderModel implements OrderModel {
  factory _OrderModel(
      {required final int id,
      required final String key,
      required final String applicationUserId,
      required final Map<String, dynamic> paymentWay,
      required final int paymentWayId,
      required final Map<String, dynamic> orderStatus,
      required final int orderStatusId,
      required final DateTime creationDate,
      required final double totalToPay,
      required final List<Map<String, dynamic>> order}) = _$_OrderModel;

  factory _OrderModel.fromJson(Map<String, dynamic> json) =
      _$_OrderModel.fromJson;

  @override
  int get id;
  @override
  String get key;
  @override
  String get applicationUserId;
  @override
  Map<String, dynamic> get paymentWay;
  @override
  int get paymentWayId;
  @override
  Map<String, dynamic> get orderStatus;
  @override
  int get orderStatusId;
  @override
  DateTime get creationDate;
  @override
  double get totalToPay;
  @override
  List<Map<String, dynamic>> get order;
  @override
  @JsonKey(ignore: true)
  _$$_OrderModelCopyWith<_$_OrderModel> get copyWith =>
      throw _privateConstructorUsedError;
}
