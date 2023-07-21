// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_offer_data_detail_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderOfferDataDetailModel _$OrderOfferDataDetailModelFromJson(
    Map<String, dynamic> json) {
  return _OrderOfferDataDetailModel.fromJson(json);
}

/// @nodoc
mixin _$OrderOfferDataDetailModel {
  int get offerId => throw _privateConstructorUsedError;
  List<Map<String, dynamic>> get orderDetailsDto =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderOfferDataDetailModelCopyWith<OrderOfferDataDetailModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderOfferDataDetailModelCopyWith<$Res> {
  factory $OrderOfferDataDetailModelCopyWith(OrderOfferDataDetailModel value,
          $Res Function(OrderOfferDataDetailModel) then) =
      _$OrderOfferDataDetailModelCopyWithImpl<$Res, OrderOfferDataDetailModel>;
  @useResult
  $Res call({int offerId, List<Map<String, dynamic>> orderDetailsDto});
}

/// @nodoc
class _$OrderOfferDataDetailModelCopyWithImpl<$Res,
        $Val extends OrderOfferDataDetailModel>
    implements $OrderOfferDataDetailModelCopyWith<$Res> {
  _$OrderOfferDataDetailModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerId = null,
    Object? orderDetailsDto = null,
  }) {
    return _then(_value.copyWith(
      offerId: null == offerId
          ? _value.offerId
          : offerId // ignore: cast_nullable_to_non_nullable
              as int,
      orderDetailsDto: null == orderDetailsDto
          ? _value.orderDetailsDto
          : orderDetailsDto // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderOfferDataDetailModelCopyWith<$Res>
    implements $OrderOfferDataDetailModelCopyWith<$Res> {
  factory _$$_OrderOfferDataDetailModelCopyWith(
          _$_OrderOfferDataDetailModel value,
          $Res Function(_$_OrderOfferDataDetailModel) then) =
      __$$_OrderOfferDataDetailModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int offerId, List<Map<String, dynamic>> orderDetailsDto});
}

/// @nodoc
class __$$_OrderOfferDataDetailModelCopyWithImpl<$Res>
    extends _$OrderOfferDataDetailModelCopyWithImpl<$Res,
        _$_OrderOfferDataDetailModel>
    implements _$$_OrderOfferDataDetailModelCopyWith<$Res> {
  __$$_OrderOfferDataDetailModelCopyWithImpl(
      _$_OrderOfferDataDetailModel _value,
      $Res Function(_$_OrderOfferDataDetailModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerId = null,
    Object? orderDetailsDto = null,
  }) {
    return _then(_$_OrderOfferDataDetailModel(
      offerId: null == offerId
          ? _value.offerId
          : offerId // ignore: cast_nullable_to_non_nullable
              as int,
      orderDetailsDto: null == orderDetailsDto
          ? _value._orderDetailsDto
          : orderDetailsDto // ignore: cast_nullable_to_non_nullable
              as List<Map<String, dynamic>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderOfferDataDetailModel implements _OrderOfferDataDetailModel {
  _$_OrderOfferDataDetailModel(
      {required this.offerId,
      required final List<Map<String, dynamic>> orderDetailsDto})
      : _orderDetailsDto = orderDetailsDto;

  factory _$_OrderOfferDataDetailModel.fromJson(Map<String, dynamic> json) =>
      _$$_OrderOfferDataDetailModelFromJson(json);

  @override
  final int offerId;
  final List<Map<String, dynamic>> _orderDetailsDto;
  @override
  List<Map<String, dynamic>> get orderDetailsDto {
    if (_orderDetailsDto is EqualUnmodifiableListView) return _orderDetailsDto;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_orderDetailsDto);
  }

  @override
  String toString() {
    return 'OrderOfferDataDetailModel(offerId: $offerId, orderDetailsDto: $orderDetailsDto)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderOfferDataDetailModel &&
            (identical(other.offerId, offerId) || other.offerId == offerId) &&
            const DeepCollectionEquality()
                .equals(other._orderDetailsDto, _orderDetailsDto));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, offerId,
      const DeepCollectionEquality().hash(_orderDetailsDto));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderOfferDataDetailModelCopyWith<_$_OrderOfferDataDetailModel>
      get copyWith => __$$_OrderOfferDataDetailModelCopyWithImpl<
          _$_OrderOfferDataDetailModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderOfferDataDetailModelToJson(
      this,
    );
  }
}

abstract class _OrderOfferDataDetailModel implements OrderOfferDataDetailModel {
  factory _OrderOfferDataDetailModel(
          {required final int offerId,
          required final List<Map<String, dynamic>> orderDetailsDto}) =
      _$_OrderOfferDataDetailModel;

  factory _OrderOfferDataDetailModel.fromJson(Map<String, dynamic> json) =
      _$_OrderOfferDataDetailModel.fromJson;

  @override
  int get offerId;
  @override
  List<Map<String, dynamic>> get orderDetailsDto;
  @override
  @JsonKey(ignore: true)
  _$$_OrderOfferDataDetailModelCopyWith<_$_OrderOfferDataDetailModel>
      get copyWith => throw _privateConstructorUsedError;
}
