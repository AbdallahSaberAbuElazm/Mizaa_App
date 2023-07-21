// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_detail_dto.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OrderDetailsDto _$OrderDetailsDtoFromJson(Map<String, dynamic> json) {
  return _OrderDetailsDto.fromJson(json);
}

/// @nodoc
mixin _$OrderDetailsDto {
  int get offerOptionsId => throw _privateConstructorUsedError;
  int get coboneCount => throw _privateConstructorUsedError;
  int get cobonesCost => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OrderDetailsDtoCopyWith<OrderDetailsDto> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderDetailsDtoCopyWith<$Res> {
  factory $OrderDetailsDtoCopyWith(
          OrderDetailsDto value, $Res Function(OrderDetailsDto) then) =
      _$OrderDetailsDtoCopyWithImpl<$Res, OrderDetailsDto>;
  @useResult
  $Res call({int offerOptionsId, int coboneCount, int cobonesCost});
}

/// @nodoc
class _$OrderDetailsDtoCopyWithImpl<$Res, $Val extends OrderDetailsDto>
    implements $OrderDetailsDtoCopyWith<$Res> {
  _$OrderDetailsDtoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerOptionsId = null,
    Object? coboneCount = null,
    Object? cobonesCost = null,
  }) {
    return _then(_value.copyWith(
      offerOptionsId: null == offerOptionsId
          ? _value.offerOptionsId
          : offerOptionsId // ignore: cast_nullable_to_non_nullable
              as int,
      coboneCount: null == coboneCount
          ? _value.coboneCount
          : coboneCount // ignore: cast_nullable_to_non_nullable
              as int,
      cobonesCost: null == cobonesCost
          ? _value.cobonesCost
          : cobonesCost // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_OrderDetailsDtoCopyWith<$Res>
    implements $OrderDetailsDtoCopyWith<$Res> {
  factory _$$_OrderDetailsDtoCopyWith(
          _$_OrderDetailsDto value, $Res Function(_$_OrderDetailsDto) then) =
      __$$_OrderDetailsDtoCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int offerOptionsId, int coboneCount, int cobonesCost});
}

/// @nodoc
class __$$_OrderDetailsDtoCopyWithImpl<$Res>
    extends _$OrderDetailsDtoCopyWithImpl<$Res, _$_OrderDetailsDto>
    implements _$$_OrderDetailsDtoCopyWith<$Res> {
  __$$_OrderDetailsDtoCopyWithImpl(
      _$_OrderDetailsDto _value, $Res Function(_$_OrderDetailsDto) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerOptionsId = null,
    Object? coboneCount = null,
    Object? cobonesCost = null,
  }) {
    return _then(_$_OrderDetailsDto(
      offerOptionsId: null == offerOptionsId
          ? _value.offerOptionsId
          : offerOptionsId // ignore: cast_nullable_to_non_nullable
              as int,
      coboneCount: null == coboneCount
          ? _value.coboneCount
          : coboneCount // ignore: cast_nullable_to_non_nullable
              as int,
      cobonesCost: null == cobonesCost
          ? _value.cobonesCost
          : cobonesCost // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_OrderDetailsDto implements _OrderDetailsDto {
  const _$_OrderDetailsDto(
      {required this.offerOptionsId,
      required this.coboneCount,
      required this.cobonesCost});

  factory _$_OrderDetailsDto.fromJson(Map<String, dynamic> json) =>
      _$$_OrderDetailsDtoFromJson(json);

  @override
  final int offerOptionsId;
  @override
  final int coboneCount;
  @override
  final int cobonesCost;

  @override
  String toString() {
    return 'OrderDetailsDto(offerOptionsId: $offerOptionsId, coboneCount: $coboneCount, cobonesCost: $cobonesCost)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_OrderDetailsDto &&
            (identical(other.offerOptionsId, offerOptionsId) ||
                other.offerOptionsId == offerOptionsId) &&
            (identical(other.coboneCount, coboneCount) ||
                other.coboneCount == coboneCount) &&
            (identical(other.cobonesCost, cobonesCost) ||
                other.cobonesCost == cobonesCost));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, offerOptionsId, coboneCount, cobonesCost);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_OrderDetailsDtoCopyWith<_$_OrderDetailsDto> get copyWith =>
      __$$_OrderDetailsDtoCopyWithImpl<_$_OrderDetailsDto>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OrderDetailsDtoToJson(
      this,
    );
  }
}

abstract class _OrderDetailsDto implements OrderDetailsDto {
  const factory _OrderDetailsDto(
      {required final int offerOptionsId,
      required final int coboneCount,
      required final int cobonesCost}) = _$_OrderDetailsDto;

  factory _OrderDetailsDto.fromJson(Map<String, dynamic> json) =
      _$_OrderDetailsDto.fromJson;

  @override
  int get offerOptionsId;
  @override
  int get coboneCount;
  @override
  int get cobonesCost;
  @override
  @JsonKey(ignore: true)
  _$$_OrderDetailsDtoCopyWith<_$_OrderDetailsDto> get copyWith =>
      throw _privateConstructorUsedError;
}
