// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'favourite_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

FavouriteModel _$FavouriteModelFromJson(Map<String, dynamic> json) {
  return _FavouriteModel.fromJson(json);
}

/// @nodoc
mixin _$FavouriteModel {
  int get id => throw _privateConstructorUsedError;
  String get key => throw _privateConstructorUsedError;
  DateTime get creationDate => throw _privateConstructorUsedError;
  String get userMobile => throw _privateConstructorUsedError;
  String get token => throw _privateConstructorUsedError;
  int get offerId => throw _privateConstructorUsedError;
  Map<String, dynamic> get offer => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FavouriteModelCopyWith<FavouriteModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FavouriteModelCopyWith<$Res> {
  factory $FavouriteModelCopyWith(
          FavouriteModel value, $Res Function(FavouriteModel) then) =
      _$FavouriteModelCopyWithImpl<$Res, FavouriteModel>;
  @useResult
  $Res call(
      {int id,
      String key,
      DateTime creationDate,
      String userMobile,
      String token,
      int offerId,
      Map<String, dynamic> offer});
}

/// @nodoc
class _$FavouriteModelCopyWithImpl<$Res, $Val extends FavouriteModel>
    implements $FavouriteModelCopyWith<$Res> {
  _$FavouriteModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? creationDate = null,
    Object? userMobile = null,
    Object? token = null,
    Object? offerId = null,
    Object? offer = null,
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
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userMobile: null == userMobile
          ? _value.userMobile
          : userMobile // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      offerId: null == offerId
          ? _value.offerId
          : offerId // ignore: cast_nullable_to_non_nullable
              as int,
      offer: null == offer
          ? _value.offer
          : offer // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_FavouriteModelCopyWith<$Res>
    implements $FavouriteModelCopyWith<$Res> {
  factory _$$_FavouriteModelCopyWith(
          _$_FavouriteModel value, $Res Function(_$_FavouriteModel) then) =
      __$$_FavouriteModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int id,
      String key,
      DateTime creationDate,
      String userMobile,
      String token,
      int offerId,
      Map<String, dynamic> offer});
}

/// @nodoc
class __$$_FavouriteModelCopyWithImpl<$Res>
    extends _$FavouriteModelCopyWithImpl<$Res, _$_FavouriteModel>
    implements _$$_FavouriteModelCopyWith<$Res> {
  __$$_FavouriteModelCopyWithImpl(
      _$_FavouriteModel _value, $Res Function(_$_FavouriteModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? key = null,
    Object? creationDate = null,
    Object? userMobile = null,
    Object? token = null,
    Object? offerId = null,
    Object? offer = null,
  }) {
    return _then(_$_FavouriteModel(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      key: null == key
          ? _value.key
          : key // ignore: cast_nullable_to_non_nullable
              as String,
      creationDate: null == creationDate
          ? _value.creationDate
          : creationDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userMobile: null == userMobile
          ? _value.userMobile
          : userMobile // ignore: cast_nullable_to_non_nullable
              as String,
      token: null == token
          ? _value.token
          : token // ignore: cast_nullable_to_non_nullable
              as String,
      offerId: null == offerId
          ? _value.offerId
          : offerId // ignore: cast_nullable_to_non_nullable
              as int,
      offer: null == offer
          ? _value._offer
          : offer // ignore: cast_nullable_to_non_nullable
              as Map<String, dynamic>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_FavouriteModel implements _FavouriteModel {
  _$_FavouriteModel(
      {required this.id,
      required this.key,
      required this.creationDate,
      required this.userMobile,
      required this.token,
      required this.offerId,
      required final Map<String, dynamic> offer})
      : _offer = offer;

  factory _$_FavouriteModel.fromJson(Map<String, dynamic> json) =>
      _$$_FavouriteModelFromJson(json);

  @override
  final int id;
  @override
  final String key;
  @override
  final DateTime creationDate;
  @override
  final String userMobile;
  @override
  final String token;
  @override
  final int offerId;
  final Map<String, dynamic> _offer;
  @override
  Map<String, dynamic> get offer {
    if (_offer is EqualUnmodifiableMapView) return _offer;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_offer);
  }

  @override
  String toString() {
    return 'FavouriteModel(id: $id, key: $key, creationDate: $creationDate, userMobile: $userMobile, token: $token, offerId: $offerId, offer: $offer)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_FavouriteModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.key, key) || other.key == key) &&
            (identical(other.creationDate, creationDate) ||
                other.creationDate == creationDate) &&
            (identical(other.userMobile, userMobile) ||
                other.userMobile == userMobile) &&
            (identical(other.token, token) || other.token == token) &&
            (identical(other.offerId, offerId) || other.offerId == offerId) &&
            const DeepCollectionEquality().equals(other._offer, _offer));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, key, creationDate,
      userMobile, token, offerId, const DeepCollectionEquality().hash(_offer));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_FavouriteModelCopyWith<_$_FavouriteModel> get copyWith =>
      __$$_FavouriteModelCopyWithImpl<_$_FavouriteModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FavouriteModelToJson(
      this,
    );
  }
}

abstract class _FavouriteModel implements FavouriteModel {
  factory _FavouriteModel(
      {required final int id,
      required final String key,
      required final DateTime creationDate,
      required final String userMobile,
      required final String token,
      required final int offerId,
      required final Map<String, dynamic> offer}) = _$_FavouriteModel;

  factory _FavouriteModel.fromJson(Map<String, dynamic> json) =
      _$_FavouriteModel.fromJson;

  @override
  int get id;
  @override
  String get key;
  @override
  DateTime get creationDate;
  @override
  String get userMobile;
  @override
  String get token;
  @override
  int get offerId;
  @override
  Map<String, dynamic> get offer;
  @override
  @JsonKey(ignore: true)
  _$$_FavouriteModelCopyWith<_$_FavouriteModel> get copyWith =>
      throw _privateConstructorUsedError;
}
