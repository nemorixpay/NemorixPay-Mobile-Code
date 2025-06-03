import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_account.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/create_account_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/generate_mnemonic_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/get_account_balance_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/get_account_assets_usecase.dart';
import 'package:nemorixpay/shared/stellar/domain/usecases/get_available_assets_usecase.dart';
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
  GetAvailableAssetsUseCase,
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
  late MockGetAvailableAssetsUseCase mockGetAvailableAssetsUseCase;

  setUp(() {
    mockGenerateMnemonicUseCase = MockGenerateMnemonicUseCase();
    mockCreateAccountUseCase = MockCreateAccountUseCase();
    mockGetAccountBalanceUseCase = MockGetAccountBalanceUseCase();
    mockSendPaymentUseCase = MockSendPaymentUseCase();
    mockValidateTransactionUseCase = MockValidateTransactionUseCase();
    mockImportAccountUseCase = MockImportAccountUseCase();
    mockGetAccountAssetsUseCase = MockGetAccountAssetsUseCase();
    mockGetAvailableAssetsUseCase = MockGetAvailableAssetsUseCase();

    bloc = StellarBloc(
      generateMnemonicUseCase: mockGenerateMnemonicUseCase,
      createAccountUseCase: mockCreateAccountUseCase,
      getAccountBalanceUseCase: mockGetAccountBalanceUseCase,
      sendPaymentUseCase: mockSendPaymentUseCase,
      validateTransactionUseCase: mockValidateTransactionUseCase,
      importAccountUseCase: mockImportAccountUseCase,
      getAccountAssetsUseCase: mockGetAccountAssetsUseCase,
      getAvailableAssetsUseCase: mockGetAvailableAssetsUseCase,
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
      AssetEntity(
        assetCode: 'XLM',
        balance: 100.0,
        assetType: 'native',
        id: '',
        name: '',
        network: '',
        decimals: 7,
      ),
      AssetEntity(
        assetCode: 'USDC',
        balance: 50.0,
        assetType: 'credit_alphanum4',
        assetIssuer: 'test_issuer',
        id: '',
        name: '',
        network: '',
        decimals: 7,
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

  group('GetAvailableAssets', () {
    final tAssets = [
      AssetEntity(
        assetCode: 'XLM',
        name: 'Stellar Lumens',
        description: 'Native asset of the Stellar network',
        assetIssuer: '',
        issuerName: 'Stellar Development Foundation',
        isVerified: true,
        logoUrl: 'https://example.com/xlm.png',
        decimals: 7,
        assetType: 'native',
        id: '',
        network: '',
      ),
      AssetEntity(
        assetCode: 'USDC',
        name: 'USD Coin',
        description: 'USD Coin on Stellar',
        assetIssuer: 'G...',
        issuerName: 'Circle',
        isVerified: true,
        logoUrl: 'https://example.com/usdc.png',
        decimals: 7,
        assetType: 'credit_alphanum4',
        id: '',
        network: '',
      ),
    ];

    // test(
    //   'should emit [AvailableAssetsLoading, AvailableAssetsLoaded] when getting assets is successful',
    //   () async {
    //     // arrange
    //     when(
    //       mockGetAvailableAssetsUseCase(),
    //     ).thenAnswer((_) async => Right(tAssets));

    //     // assert later
    //     final expected = [
    //       AvailableAssetsLoading(),
    //       AvailableAssetsLoaded(tAssets),
    //     ];
    //     expectLater(bloc.stream, emitsInOrder(expected));

    //     // act
    //     bloc.add(GetAvailableAssetsEvent());
    //   },
    // );

    test(
      'should emit [AvailableAssetsLoading, Error] when getting assets fails with StellarFailure',
      () async {
        // arrange
        final tFailure = StellarFailure(
          stellarCode: 'INVALID_ASSETS',
          stellarMessage: 'Invalid assets',
        );
        when(
          mockGetAvailableAssetsUseCase(),
        ).thenAnswer((_) async => Left(tFailure));

        // assert later
        final expected = [
          AvailableAssetsLoading(),
          StellarError(tFailure.message),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAvailableAssetsEvent());
      },
    );

    test(
      'should emit [AvailableAssetsLoading, Error] when getting assets throws unexpected error',
      () async {
        // arrange
        when(
          mockGetAvailableAssetsUseCase(),
        ).thenAnswer((_) async => throw Exception('Unexpected error'));

        // assert later
        final expected = [
          AvailableAssetsLoading(),
          StellarError('Unexpected error. Try again!'),
        ];
        expectLater(bloc.stream, emitsInOrder(expected));

        // act
        bloc.add(GetAvailableAssetsEvent());
      },
    );
  });
}
