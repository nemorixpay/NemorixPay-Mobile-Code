import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_account.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_asset.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/create_account_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/generate_mnemonic_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/get_account_balance_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/get_account_assets_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/import_account_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/send_payment_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/validate_transaction_usecase.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_bloc.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_event.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_state.dart';
import 'package:dartz/dartz.dart';
import 'stellar_bloc_test.mocks.dart';

@GenerateMocks([
  GenerateMnemonicUseCase,
  CreateAccountUseCase,
  GetAccountBalanceUseCase,
  SendPaymentUseCase,
  ValidateTransactionUseCase,
  ImportAccountUseCase,
  GetAccountAssetsUseCase,
])
void main() {
  late StellarBloc bloc;
  late MockGenerateMnemonicUseCase mockGenerateMnemonicUseCase;
  late MockCreateAccountUseCase mockCreateAccountUseCase;
  late MockGetAccountBalanceUseCase mockGetAccountBalanceUseCase;
  late MockSendPaymentUseCase mockSendPaymentUseCase;
  late MockValidateTransactionUseCase mockValidateTransactionUseCase;
  late MockImportAccountUseCase mockImportAccountUseCase;
  late MockGetAccountAssetsUseCase mockGetAccountAssetsUseCase;

  setUp(() {
    mockGenerateMnemonicUseCase = MockGenerateMnemonicUseCase();
    mockCreateAccountUseCase = MockCreateAccountUseCase();
    mockGetAccountBalanceUseCase = MockGetAccountBalanceUseCase();
    mockSendPaymentUseCase = MockSendPaymentUseCase();
    mockValidateTransactionUseCase = MockValidateTransactionUseCase();
    mockImportAccountUseCase = MockImportAccountUseCase();
    mockGetAccountAssetsUseCase = MockGetAccountAssetsUseCase();

    bloc = StellarBloc(
      generateMnemonicUseCase: mockGenerateMnemonicUseCase,
      createAccountUseCase: mockCreateAccountUseCase,
      getAccountBalanceUseCase: mockGetAccountBalanceUseCase,
      sendPaymentUseCase: mockSendPaymentUseCase,
      validateTransactionUseCase: mockValidateTransactionUseCase,
      importAccountUseCase: mockImportAccountUseCase,
      getAccountAssetsUseCase: mockGetAccountAssetsUseCase,
    );
  });

  tearDown(() {
    bloc.close();
  });

  test('initial state should be StellarInitial', () {
    expect(bloc.state, equals(StellarInitial()));
  });

  group('ImportAccount', () {
    final tMnemonic = 'test mnemonic phrase';
    final tPassphrase = 'test passphrase';
    final tAccount = StellarAccount(
      publicKey: 'test_public_key',
      secretKey: 'test_secret_key',
      balance: 100.0,
      mnemonic: tMnemonic,
      createdAt: DateTime.now(),
    );

    test(
      'should emit [Loading, AccountImported] when import is successful',
      () async {
        // arrange
        when(
          mockImportAccountUseCase(
            mnemonic: tMnemonic,
            passphrase: tPassphrase,
          ),
        ).thenAnswer((_) async => Right(tAccount));

        // assert later
        final expected = [StellarLoading(), AccountImported(tAccount)];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(
          ImportAccountEvent(mnemonic: tMnemonic, passphrase: tPassphrase),
        );
      },
    );

    test(
      'should emit [Loading, Error] when import fails with StellarFailure',
      () async {
        // arrange
        final tFailure = StellarFailure(
          stellarCode: 'INVALID_MNEMONIC',
          stellarMessage: 'Invalid mnemonic phrase',
        );
        when(
          mockImportAccountUseCase(
            mnemonic: tMnemonic,
            passphrase: tPassphrase,
          ),
        ).thenAnswer((_) async => Left(tFailure));

        // assert later
        final expected = [StellarLoading(), StellarError(tFailure.message)];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(
          ImportAccountEvent(mnemonic: tMnemonic, passphrase: tPassphrase),
        );
      },
    );

    test(
      'should emit [Loading, Error] when import throws StellarFailure',
      () async {
        // arrange
        final tFailure = StellarFailure(
          stellarCode: 'INVALID_MNEMONIC',
          stellarMessage: 'Invalid mnemonic phrase',
        );
        when(
          mockImportAccountUseCase(
            mnemonic: tMnemonic,
            passphrase: tPassphrase,
          ),
        ).thenThrow(tFailure);

        // assert later
        final expected = [StellarLoading(), StellarError(tFailure.message)];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(
          ImportAccountEvent(mnemonic: tMnemonic, passphrase: tPassphrase),
        );
      },
    );

    test(
      'should emit [Loading, Error] when import throws unexpected error',
      () async {
        // arrange
        when(
          mockImportAccountUseCase(
            mnemonic: tMnemonic,
            passphrase: tPassphrase,
          ),
        ).thenThrow(Exception('Unexpected error'));

        // assert later
        final expected = [
          StellarLoading(),
          StellarError('Unexpected error. Try again!'),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(
          ImportAccountEvent(mnemonic: tMnemonic, passphrase: tPassphrase),
        );
      },
    );

    test('should handle empty passphrase', () async {
      // arrange
      when(
        mockImportAccountUseCase(mnemonic: tMnemonic, passphrase: ''),
      ).thenAnswer((_) async => Right(tAccount));

      // assert later
      final expected = [StellarLoading(), AccountImported(tAccount)];
      expectLater(bloc.stream, emitsInOrder(expected));

      // act
      bloc.add(ImportAccountEvent(mnemonic: tMnemonic, passphrase: ''));
    });
  });

  group('GetAccountAssets', () {
    final tPublicKey = 'test_public_key';
    final tAssets = [
      StellarAsset(code: 'XLM', balance: 100.0, type: 'native'),
      StellarAsset(
        code: 'USDC',
        balance: 50.0,
        type: 'credit_alphanum4',
        issuer: 'test_issuer',
      ),
    ];

    test(
      'should emit [AssetsLoading, AssetsLoaded] when getting assets is successful',
      () async {
        // arrange
        when(
          mockGetAccountAssetsUseCase(tPublicKey),
        ).thenAnswer((_) async => Right(tAssets));

        // assert later
        final expected = [AssetsLoading(), AssetsLoaded(tAssets)];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAccountAssetsEvent(tPublicKey));
      },
    );

    test(
      'should emit [AssetsLoading, Error] when getting assets fails with StellarFailure',
      () async {
        // arrange
        final tFailure = StellarFailure(
          stellarCode: 'INVALID_ACCOUNT',
          stellarMessage: 'Invalid account',
        );
        when(
          mockGetAccountAssetsUseCase(tPublicKey),
        ).thenAnswer((_) async => Left(tFailure));

        // assert later
        final expected = [AssetsLoading(), StellarError(tFailure.message)];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAccountAssetsEvent(tPublicKey));
      },
    );

    test(
      'should emit [AssetsLoading, Error] when getting assets throws StellarFailure',
      () async {
        // arrange
        final tFailure = StellarFailure(
          stellarCode: 'INVALID_ACCOUNT',
          stellarMessage: 'Invalid account',
        );
        when(
          mockGetAccountAssetsUseCase(tPublicKey),
        ).thenAnswer((_) async => Left(tFailure));

        // assert later
        final expected = [AssetsLoading(), StellarError(tFailure.message)];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAccountAssetsEvent(tPublicKey));
      },
    );

    test(
      'should emit [AssetsLoading, Error] when getting assets throws unexpected error',
      () async {
        // arrange
        when(
          mockGetAccountAssetsUseCase(tPublicKey),
        ).thenAnswer((_) async => throw Exception('Unexpected error'));

        // assert later
        final expected = [
          AssetsLoading(),
          StellarError('Unexpected error. Try again!'),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAccountAssetsEvent(tPublicKey));
      },
    );
  });
}
