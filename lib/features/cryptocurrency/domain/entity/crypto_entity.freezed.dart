// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'crypto_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

Crypto _$CryptoFromJson(Map<String, dynamic> json) {
  return _Crypto.fromJson(json);
}

/// @nodoc
mixin _$Crypto {
  String get name => throw _privateConstructorUsedError;
  String get abbreviation => throw _privateConstructorUsedError;
  String get project => throw _privateConstructorUsedError;
  String get logoPath => throw _privateConstructorUsedError;
  double get currentPrice => throw _privateConstructorUsedError;
  Map<String, List<CryptoPricePoint>> get priceHistory =>
      throw _privateConstructorUsedError;
  double get marketCap => throw _privateConstructorUsedError;
  double get volume => throw _privateConstructorUsedError;
  double get circulatingSupply => throw _privateConstructorUsedError;
  double get totalSupply => throw _privateConstructorUsedError;
  double get allTimeHigh => throw _privateConstructorUsedError;
  double get performance => throw _privateConstructorUsedError;
  bool get isFavorite => throw _privateConstructorUsedError;

  /// Serializes this Crypto to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Crypto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CryptoCopyWith<Crypto> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CryptoCopyWith<$Res> {
  factory $CryptoCopyWith(Crypto value, $Res Function(Crypto) then) =
      _$CryptoCopyWithImpl<$Res, Crypto>;
  @useResult
  $Res call({
    String name,
    String abbreviation,
    String project,
    String logoPath,
    double currentPrice,
    Map<String, List<CryptoPricePoint>> priceHistory,
    double marketCap,
    double volume,
    double circulatingSupply,
    double totalSupply,
    double allTimeHigh,
    double performance,
    bool isFavorite,
  });
}

/// @nodoc
class _$CryptoCopyWithImpl<$Res, $Val extends Crypto>
    implements $CryptoCopyWith<$Res> {
  _$CryptoCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Crypto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? abbreviation = null,
    Object? project = null,
    Object? logoPath = null,
    Object? currentPrice = null,
    Object? priceHistory = null,
    Object? marketCap = null,
    Object? volume = null,
    Object? circulatingSupply = null,
    Object? totalSupply = null,
    Object? allTimeHigh = null,
    Object? performance = null,
    Object? isFavorite = null,
  }) {
    return _then(
      _value.copyWith(
            name:
                null == name
                    ? _value.name
                    : name // ignore: cast_nullable_to_non_nullable
                        as String,
            abbreviation:
                null == abbreviation
                    ? _value.abbreviation
                    : abbreviation // ignore: cast_nullable_to_non_nullable
                        as String,
            project:
                null == project
                    ? _value.project
                    : project // ignore: cast_nullable_to_non_nullable
                        as String,
            logoPath:
                null == logoPath
                    ? _value.logoPath
                    : logoPath // ignore: cast_nullable_to_non_nullable
                        as String,
            currentPrice:
                null == currentPrice
                    ? _value.currentPrice
                    : currentPrice // ignore: cast_nullable_to_non_nullable
                        as double,
            priceHistory:
                null == priceHistory
                    ? _value.priceHistory
                    : priceHistory // ignore: cast_nullable_to_non_nullable
                        as Map<String, List<CryptoPricePoint>>,
            marketCap:
                null == marketCap
                    ? _value.marketCap
                    : marketCap // ignore: cast_nullable_to_non_nullable
                        as double,
            volume:
                null == volume
                    ? _value.volume
                    : volume // ignore: cast_nullable_to_non_nullable
                        as double,
            circulatingSupply:
                null == circulatingSupply
                    ? _value.circulatingSupply
                    : circulatingSupply // ignore: cast_nullable_to_non_nullable
                        as double,
            totalSupply:
                null == totalSupply
                    ? _value.totalSupply
                    : totalSupply // ignore: cast_nullable_to_non_nullable
                        as double,
            allTimeHigh:
                null == allTimeHigh
                    ? _value.allTimeHigh
                    : allTimeHigh // ignore: cast_nullable_to_non_nullable
                        as double,
            performance:
                null == performance
                    ? _value.performance
                    : performance // ignore: cast_nullable_to_non_nullable
                        as double,
            isFavorite:
                null == isFavorite
                    ? _value.isFavorite
                    : isFavorite // ignore: cast_nullable_to_non_nullable
                        as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$CryptoImplCopyWith<$Res> implements $CryptoCopyWith<$Res> {
  factory _$$CryptoImplCopyWith(
    _$CryptoImpl value,
    $Res Function(_$CryptoImpl) then,
  ) = __$$CryptoImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String name,
    String abbreviation,
    String project,
    String logoPath,
    double currentPrice,
    Map<String, List<CryptoPricePoint>> priceHistory,
    double marketCap,
    double volume,
    double circulatingSupply,
    double totalSupply,
    double allTimeHigh,
    double performance,
    bool isFavorite,
  });
}

/// @nodoc
class __$$CryptoImplCopyWithImpl<$Res>
    extends _$CryptoCopyWithImpl<$Res, _$CryptoImpl>
    implements _$$CryptoImplCopyWith<$Res> {
  __$$CryptoImplCopyWithImpl(
    _$CryptoImpl _value,
    $Res Function(_$CryptoImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Crypto
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = null,
    Object? abbreviation = null,
    Object? project = null,
    Object? logoPath = null,
    Object? currentPrice = null,
    Object? priceHistory = null,
    Object? marketCap = null,
    Object? volume = null,
    Object? circulatingSupply = null,
    Object? totalSupply = null,
    Object? allTimeHigh = null,
    Object? performance = null,
    Object? isFavorite = null,
  }) {
    return _then(
      _$CryptoImpl(
        name:
            null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                    as String,
        abbreviation:
            null == abbreviation
                ? _value.abbreviation
                : abbreviation // ignore: cast_nullable_to_non_nullable
                    as String,
        project:
            null == project
                ? _value.project
                : project // ignore: cast_nullable_to_non_nullable
                    as String,
        logoPath:
            null == logoPath
                ? _value.logoPath
                : logoPath // ignore: cast_nullable_to_non_nullable
                    as String,
        currentPrice:
            null == currentPrice
                ? _value.currentPrice
                : currentPrice // ignore: cast_nullable_to_non_nullable
                    as double,
        priceHistory:
            null == priceHistory
                ? _value._priceHistory
                : priceHistory // ignore: cast_nullable_to_non_nullable
                    as Map<String, List<CryptoPricePoint>>,
        marketCap:
            null == marketCap
                ? _value.marketCap
                : marketCap // ignore: cast_nullable_to_non_nullable
                    as double,
        volume:
            null == volume
                ? _value.volume
                : volume // ignore: cast_nullable_to_non_nullable
                    as double,
        circulatingSupply:
            null == circulatingSupply
                ? _value.circulatingSupply
                : circulatingSupply // ignore: cast_nullable_to_non_nullable
                    as double,
        totalSupply:
            null == totalSupply
                ? _value.totalSupply
                : totalSupply // ignore: cast_nullable_to_non_nullable
                    as double,
        allTimeHigh:
            null == allTimeHigh
                ? _value.allTimeHigh
                : allTimeHigh // ignore: cast_nullable_to_non_nullable
                    as double,
        performance:
            null == performance
                ? _value.performance
                : performance // ignore: cast_nullable_to_non_nullable
                    as double,
        isFavorite:
            null == isFavorite
                ? _value.isFavorite
                : isFavorite // ignore: cast_nullable_to_non_nullable
                    as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$CryptoImpl implements _Crypto {
  const _$CryptoImpl({
    required this.name,
    required this.abbreviation,
    required this.project,
    required this.logoPath,
    required this.currentPrice,
    required final Map<String, List<CryptoPricePoint>> priceHistory,
    required this.marketCap,
    required this.volume,
    required this.circulatingSupply,
    required this.totalSupply,
    required this.allTimeHigh,
    required this.performance,
    this.isFavorite = false,
  }) : _priceHistory = priceHistory;

  factory _$CryptoImpl.fromJson(Map<String, dynamic> json) =>
      _$$CryptoImplFromJson(json);

  @override
  final String name;
  @override
  final String abbreviation;
  @override
  final String project;
  @override
  final String logoPath;
  @override
  final double currentPrice;
  final Map<String, List<CryptoPricePoint>> _priceHistory;
  @override
  Map<String, List<CryptoPricePoint>> get priceHistory {
    if (_priceHistory is EqualUnmodifiableMapView) return _priceHistory;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_priceHistory);
  }

  @override
  final double marketCap;
  @override
  final double volume;
  @override
  final double circulatingSupply;
  @override
  final double totalSupply;
  @override
  final double allTimeHigh;
  @override
  final double performance;
  @override
  @JsonKey()
  final bool isFavorite;

  @override
  String toString() {
    return 'Crypto(name: $name, abbreviation: $abbreviation, project: $project, logoPath: $logoPath, currentPrice: $currentPrice, priceHistory: $priceHistory, marketCap: $marketCap, volume: $volume, circulatingSupply: $circulatingSupply, totalSupply: $totalSupply, allTimeHigh: $allTimeHigh, performance: $performance, isFavorite: $isFavorite)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CryptoImpl &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.abbreviation, abbreviation) ||
                other.abbreviation == abbreviation) &&
            (identical(other.project, project) || other.project == project) &&
            (identical(other.logoPath, logoPath) ||
                other.logoPath == logoPath) &&
            (identical(other.currentPrice, currentPrice) ||
                other.currentPrice == currentPrice) &&
            const DeepCollectionEquality().equals(
              other._priceHistory,
              _priceHistory,
            ) &&
            (identical(other.marketCap, marketCap) ||
                other.marketCap == marketCap) &&
            (identical(other.volume, volume) || other.volume == volume) &&
            (identical(other.circulatingSupply, circulatingSupply) ||
                other.circulatingSupply == circulatingSupply) &&
            (identical(other.totalSupply, totalSupply) ||
                other.totalSupply == totalSupply) &&
            (identical(other.allTimeHigh, allTimeHigh) ||
                other.allTimeHigh == allTimeHigh) &&
            (identical(other.performance, performance) ||
                other.performance == performance) &&
            (identical(other.isFavorite, isFavorite) ||
                other.isFavorite == isFavorite));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    name,
    abbreviation,
    project,
    logoPath,
    currentPrice,
    const DeepCollectionEquality().hash(_priceHistory),
    marketCap,
    volume,
    circulatingSupply,
    totalSupply,
    allTimeHigh,
    performance,
    isFavorite,
  );

  /// Create a copy of Crypto
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CryptoImplCopyWith<_$CryptoImpl> get copyWith =>
      __$$CryptoImplCopyWithImpl<_$CryptoImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CryptoImplToJson(this);
  }
}

abstract class _Crypto implements Crypto {
  const factory _Crypto({
    required final String name,
    required final String abbreviation,
    required final String project,
    required final String logoPath,
    required final double currentPrice,
    required final Map<String, List<CryptoPricePoint>> priceHistory,
    required final double marketCap,
    required final double volume,
    required final double circulatingSupply,
    required final double totalSupply,
    required final double allTimeHigh,
    required final double performance,
    final bool isFavorite,
  }) = _$CryptoImpl;

  factory _Crypto.fromJson(Map<String, dynamic> json) = _$CryptoImpl.fromJson;

  @override
  String get name;
  @override
  String get abbreviation;
  @override
  String get project;
  @override
  String get logoPath;
  @override
  double get currentPrice;
  @override
  Map<String, List<CryptoPricePoint>> get priceHistory;
  @override
  double get marketCap;
  @override
  double get volume;
  @override
  double get circulatingSupply;
  @override
  double get totalSupply;
  @override
  double get allTimeHigh;
  @override
  double get performance;
  @override
  bool get isFavorite;

  /// Create a copy of Crypto
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CryptoImplCopyWith<_$CryptoImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
