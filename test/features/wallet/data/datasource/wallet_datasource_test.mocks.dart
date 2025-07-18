// Mocks generated by Mockito 5.4.5 from annotations
// in nemorixpay/test/features/wallet/data/datasource/wallet_datasource_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i6;

import 'package:mockito/mockito.dart' as _i1;
import 'package:mockito/src/dummies.dart' as _i7;
import 'package:nemorixpay/shared/common/data/models/asset_model.dart' as _i8;
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource.dart'
    as _i5;
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart'
    as _i2;
import 'package:nemorixpay/shared/stellar/data/models/stellar_transaction_model.dart'
    as _i3;
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart' as _i4;

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

class _FakeStellarAccountModel_0 extends _i1.SmartFake
    implements _i2.StellarAccountModel {
  _FakeStellarAccountModel_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeStellarTransactionModel_1 extends _i1.SmartFake
    implements _i3.StellarTransactionModel {
  _FakeStellarTransactionModel_1(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

class _FakeKeyPair_2 extends _i1.SmartFake implements _i4.KeyPair {
  _FakeKeyPair_2(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [StellarDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockStellarDataSource extends _i1.Mock implements _i5.StellarDataSource {
  MockStellarDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i6.Future<List<String>> generateMnemonic({int? strength = 256}) =>
      (super.noSuchMethod(
            Invocation.method(#generateMnemonic, [], {#strength: strength}),
            returnValue: _i6.Future<List<String>>.value(<String>[]),
          )
          as _i6.Future<List<String>>);

  @override
  _i6.Future<_i2.StellarAccountModel> createAccount({
    required String? mnemonic,
    String? passphrase = '',
  }) =>
      (super.noSuchMethod(
            Invocation.method(#createAccount, [], {
              #mnemonic: mnemonic,
              #passphrase: passphrase,
            }),
            returnValue: _i6.Future<_i2.StellarAccountModel>.value(
              _FakeStellarAccountModel_0(
                this,
                Invocation.method(#createAccount, [], {
                  #mnemonic: mnemonic,
                  #passphrase: passphrase,
                }),
              ),
            ),
          )
          as _i6.Future<_i2.StellarAccountModel>);

  @override
  _i6.Future<double> getAccountBalance(String? publicKey) =>
      (super.noSuchMethod(
            Invocation.method(#getAccountBalance, [publicKey]),
            returnValue: _i6.Future<double>.value(0.0),
          )
          as _i6.Future<double>);

  @override
  _i6.Future<_i3.StellarTransactionModel> sendPayment({
    required String? sourceSecretKey,
    required String? destinationPublicKey,
    required double? amount,
    String? memo,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#sendPayment, [], {
              #sourceSecretKey: sourceSecretKey,
              #destinationPublicKey: destinationPublicKey,
              #amount: amount,
              #memo: memo,
            }),
            returnValue: _i6.Future<_i3.StellarTransactionModel>.value(
              _FakeStellarTransactionModel_1(
                this,
                Invocation.method(#sendPayment, [], {
                  #sourceSecretKey: sourceSecretKey,
                  #destinationPublicKey: destinationPublicKey,
                  #amount: amount,
                  #memo: memo,
                }),
              ),
            ),
          )
          as _i6.Future<_i3.StellarTransactionModel>);

  @override
  _i6.Future<_i3.StellarTransactionModel> validateTransaction(
    String? transactionHash,
  ) =>
      (super.noSuchMethod(
            Invocation.method(#validateTransaction, [transactionHash]),
            returnValue: _i6.Future<_i3.StellarTransactionModel>.value(
              _FakeStellarTransactionModel_1(
                this,
                Invocation.method(#validateTransaction, [transactionHash]),
              ),
            ),
          )
          as _i6.Future<_i3.StellarTransactionModel>);

  @override
  _i6.Future<_i2.StellarAccountModel> importAccount({
    required String? mnemonic,
    String? passphrase = '',
  }) =>
      (super.noSuchMethod(
            Invocation.method(#importAccount, [], {
              #mnemonic: mnemonic,
              #passphrase: passphrase,
            }),
            returnValue: _i6.Future<_i2.StellarAccountModel>.value(
              _FakeStellarAccountModel_0(
                this,
                Invocation.method(#importAccount, [], {
                  #mnemonic: mnemonic,
                  #passphrase: passphrase,
                }),
              ),
            ),
          )
          as _i6.Future<_i2.StellarAccountModel>);

  @override
  _i6.Future<_i4.KeyPair> getKeyPairFromMnemonic(
    String? mnemonic, {
    String? passphrase = '',
  }) =>
      (super.noSuchMethod(
            Invocation.method(
              #getKeyPairFromMnemonic,
              [mnemonic],
              {#passphrase: passphrase},
            ),
            returnValue: _i6.Future<_i4.KeyPair>.value(
              _FakeKeyPair_2(
                this,
                Invocation.method(
                  #getKeyPairFromMnemonic,
                  [mnemonic],
                  {#passphrase: passphrase},
                ),
              ),
            ),
          )
          as _i6.Future<_i4.KeyPair>);

  @override
  _i6.Future<double> getBalance(String? publicKey) =>
      (super.noSuchMethod(
            Invocation.method(#getBalance, [publicKey]),
            returnValue: _i6.Future<double>.value(0.0),
          )
          as _i6.Future<double>);

  @override
  _i6.Future<String> sendTransaction({
    required String? sourceSecretSeed,
    required String? destinationPublicKey,
    required double? amount,
    String? memo,
  }) =>
      (super.noSuchMethod(
            Invocation.method(#sendTransaction, [], {
              #sourceSecretSeed: sourceSecretSeed,
              #destinationPublicKey: destinationPublicKey,
              #amount: amount,
              #memo: memo,
            }),
            returnValue: _i6.Future<String>.value(
              _i7.dummyValue<String>(
                this,
                Invocation.method(#sendTransaction, [], {
                  #sourceSecretSeed: sourceSecretSeed,
                  #destinationPublicKey: destinationPublicKey,
                  #amount: amount,
                  #memo: memo,
                }),
              ),
            ),
          )
          as _i6.Future<String>);

  @override
  _i6.Future<List<_i8.AssetModel>> getAccountAssets(String? publicKey) =>
      (super.noSuchMethod(
            Invocation.method(#getAccountAssets, [publicKey]),
            returnValue: _i6.Future<List<_i8.AssetModel>>.value(
              <_i8.AssetModel>[],
            ),
          )
          as _i6.Future<List<_i8.AssetModel>>);

  @override
  _i6.Future<List<_i8.AssetModel>> getAvailableAssets() =>
      (super.noSuchMethod(
            Invocation.method(#getAvailableAssets, []),
            returnValue: _i6.Future<List<_i8.AssetModel>>.value(
              <_i8.AssetModel>[],
            ),
          )
          as _i6.Future<List<_i8.AssetModel>>);

  @override
  _i6.Future<String?> getSecurePrivateKey({required String? publicKey}) =>
      (super.noSuchMethod(
            Invocation.method(#getSecurePrivateKey, [], {
              #publicKey: publicKey,
            }),
            returnValue: _i6.Future<String?>.value(),
          )
          as _i6.Future<String?>);

  @override
  _i6.Future<bool> hasSecurePrivateKey({required String? publicKey}) =>
      (super.noSuchMethod(
            Invocation.method(#hasSecurePrivateKey, [], {
              #publicKey: publicKey,
            }),
            returnValue: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<bool> deleteSecurePrivateKey({required String? publicKey}) =>
      (super.noSuchMethod(
            Invocation.method(#deleteSecurePrivateKey, [], {
              #publicKey: publicKey,
            }),
            returnValue: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<bool> deleteAllSecurePrivateKeys() =>
      (super.noSuchMethod(
            Invocation.method(#deleteAllSecurePrivateKeys, []),
            returnValue: _i6.Future<bool>.value(false),
          )
          as _i6.Future<bool>);

  @override
  _i6.Future<List<String>> getAllStoredPublicKeys() =>
      (super.noSuchMethod(
            Invocation.method(#getAllStoredPublicKeys, []),
            returnValue: _i6.Future<List<String>>.value(<String>[]),
          )
          as _i6.Future<List<String>>);
}
