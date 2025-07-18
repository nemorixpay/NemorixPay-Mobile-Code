// Mocks generated by Mockito 5.4.5 from annotations
// in nemorixpay/test/features/auth/domain/usecases/check_wallet_exists_usecase_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart'
    as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [StellarSecureStorageDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStellarSecureStorageDataSource extends _i1.Mock
    implements _i2.StellarSecureStorageDataSource {
  MockStellarSecureStorageDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<bool> savePrivateKey({
    required String? publicKey,
    required String? privateKey,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#savePrivateKey, [], {
              #publicKey: publicKey,
              #privateKey: privateKey,
            }),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<bool> savePublicKey({
    required String? publicKey,
    required String? userId,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#savePublicKey, [], {
              #publicKey: publicKey,
              #userId: userId,
            }),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<String?> getPrivateKey({required String? publicKey}) =>
      (super.noSuchMethod(
            Invocation.method(#getPrivateKey, [], {#publicKey: publicKey}),
            returnValue: _i3.Future<String?>.value(),
          )
          as _i3.Future<String?>);

  @override
  _i3.Future<String?> getPublicKey({required String? userId}) =>
      (super.noSuchMethod(
            Invocation.method(#getPublicKey, [], {#userId: userId}),
            returnValue: _i3.Future<String?>.value(),
          )
          as _i3.Future<String?>);

  @override
  _i3.Future<bool> hasPrivateKey({required String? publicKey}) =>
      (super.noSuchMethod(
            Invocation.method(#hasPrivateKey, [], {#publicKey: publicKey}),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<bool> hasPublicKey({required String? userId}) =>
      (super.noSuchMethod(
            Invocation.method(#hasPublicKey, [], {#userId: userId}),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<bool> deleteAllKeys() =>
      (super.noSuchMethod(
            Invocation.method(#deleteAllKeys, []),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<bool> deletePrivateKey({required String? publicKey}) =>
      (super.noSuchMethod(
            Invocation.method(#deletePrivateKey, [], {#publicKey: publicKey}),
            returnValue: _i3.Future<bool>.value(false),
          )
          as _i3.Future<bool>);

  @override
  _i3.Future<List<String>> getAllPublicKeys() =>
      (super.noSuchMethod(
            Invocation.method(#getAllPublicKeys, []),
            returnValue: _i3.Future<List<String>>.value(<String>[]),
          )
          as _i3.Future<List<String>>);
}
