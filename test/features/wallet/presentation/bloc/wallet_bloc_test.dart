import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/wallet/wallet_failure.dart';
import 'package:nemorixpay/features/wallet/domain/entities/wallet.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_event.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_state.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/create_wallet.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/import_wallet.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/get_wallet_balance.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/seed_phrase_usecase.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/save_public_key_usecase.dart';

import 'wallet_bloc_test.mocks.dart';

@GenerateMocks([
  CreateWalletUseCase,
  ImportWalletUseCase,
  GetWalletBalanceUseCase,
  CreateSeedPhraseUseCase,
  SavePublicKeyUseCase,
])

/// @file        wallet_bloc_test.dart
/// @brief       Tests for the Wallet Bloc implementation
/// @details     Verifies the behavior of the Wallet Bloc, including wallet creation,
///             import, and balance retrieval operations.
/// @author      Miguel Fagundez
/// @date        23/05/2024
/// @version     1.1
/// @copyright   Apache 2.0 License
void main() {
  late WalletBloc walletBloc;
  late MockCreateWalletUseCase mockCreateWallet;
  late MockImportWalletUseCase mockImportWallet;
  late MockGetWalletBalanceUseCase mockGetWalletBalance;
  late MockCreateSeedPhraseUseCase mockCreateSeedPhrase;
  late MockSavePublicKeyUseCase mockSavePublicKey;

  setUp(() {
    mockCreateWallet = MockCreateWalletUseCase();
    mockImportWallet = MockImportWalletUseCase();
    mockGetWalletBalance = MockGetWalletBalanceUseCase();
    mockCreateSeedPhrase = MockCreateSeedPhraseUseCase();
    mockSavePublicKey = MockSavePublicKeyUseCase();
    walletBloc = WalletBloc(
      createWalletUseCase: mockCreateWallet,
      importWalletUseCase: mockImportWallet,
      getWalletBalanceUseCase: mockGetWalletBalance,
      createSeedPhraseUseCase: mockCreateSeedPhrase,
      savePublicKeyUseCase: mockSavePublicKey,
    );
  });

  tearDown(() {
    walletBloc.close();
  });

  test('initial state should be WalletInitial', () {
    expect(walletBloc.state, equals(const WalletInitial()));
  });

  group('CreateWalletRequested', () {
    final tWallet = Wallet(
      publicKey: 'test_public_key',
      secretKey: 'test_secret_key',
      balance: 100.0,
      mnemonic: 'test mnemonic',
      createdAt: DateTime.now(),
    );

    test(
      'should emit [WalletLoading, WalletCreated] when wallet is created successfully',
      () async {
        // arrange
        when(
          mockCreateWallet(tWallet.mnemonic),
        ).thenAnswer((_) async => Right(tWallet));

        // assert later
        final expected = [
          const WalletLoading(isSecondLoading: true),
          WalletCreated(tWallet)
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(CreateWalletRequested(tWallet.mnemonic));
      },
    );

    test(
      'should emit [WalletLoading, WalletError] when wallet creation fails',
      () async {
        // arrange
        when(mockCreateWallet(tWallet.mnemonic)).thenAnswer(
          (_) async =>
              Left(WalletFailure.creationFailed('Error creating wallet')),
        );

        // assert later
        final expected = [
          const WalletLoading(isSecondLoading: true),
          const WalletError('Error creating wallet'),
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(CreateWalletRequested(tWallet.mnemonic));
      },
    );
  });

  group('ImportWalletRequested', () {
    const tMnemonic = 'test mnemonic phrase';
    final tWallet = Wallet(
      publicKey: 'test_public_key',
      secretKey: 'test_secret_key',
      balance: 100.0,
      mnemonic: 'test mnemonic',
      createdAt: DateTime.now(),
    );

    test(
      'should emit [WalletLoading, WalletImported] when wallet is imported successfully',
      () async {
        // arrange
        when(
          mockImportWallet(tMnemonic),
        ).thenAnswer((_) async => Right(tWallet));

        // assert later
        final expected = [
          const WalletLoading(isSecondLoading: true),
          WalletImported(tWallet)
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const ImportWalletRequested(tMnemonic));
      },
    );

    test(
      'should emit [WalletLoading, WalletError] when wallet import fails',
      () async {
        // arrange
        when(mockImportWallet(tMnemonic)).thenAnswer(
          (_) async =>
              Left(WalletFailure.importFailed('Error importing wallet')),
        );

        // assert later
        final expected = [
          const WalletLoading(isSecondLoading: true),
          const WalletError('Error importing wallet'),
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const ImportWalletRequested(tMnemonic));
      },
    );
  });

  group('GetWalletBalanceRequested', () {
    const tPublicKey = 'test_public_key';
    const tBalance = 100.0;

    test(
      'should emit [WalletLoading, WalletBalanceLoaded] when balance is retrieved successfully',
      () async {
        // arrange
        when(
          mockGetWalletBalance(tPublicKey),
        ).thenAnswer((_) async => const Right(tBalance));

        // assert later
        final expected = [
          const WalletLoading(),
          const WalletBalanceLoaded(tBalance),
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const GetWalletBalanceRequested(tPublicKey));
      },
    );

    test(
      'should emit [WalletLoading, WalletError] when balance retrieval fails',
      () async {
        // arrange
        when(mockGetWalletBalance(tPublicKey)).thenAnswer(
          (_) async =>
              Left(WalletFailure.accountNotFound('Error getting balance')),
        );

        // assert later
        final expected = [
          const WalletLoading(),
          const WalletError('Error getting balance'),
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const GetWalletBalanceRequested(tPublicKey));
      },
    );
  });

  group('GenerateSeedPhraseRequested', () {
    final tMnemonic = ['test', 'mnemonic', 'phrase'];

    test(
      'should emit [WalletLoading, SeedPhraseCreated] when seed phrase is generated successfully',
      () async {
        // arrange
        when(mockCreateSeedPhrase()).thenAnswer((_) async => Right(tMnemonic));

        // assert later
        final expected = [const WalletLoading(), SeedPhraseCreated(tMnemonic)];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const GenerateSeedPhraseRequested());
      },
    );

    test(
      'should emit [WalletLoading, WalletError] when seed phrase generation fails',
      () async {
        // arrange
        when(mockCreateSeedPhrase()).thenAnswer(
          (_) async => Left(
            WalletFailure.creationFailed('Error generating seed phrase'),
          ),
        );

        // assert later
        final expected = [
          const WalletLoading(),
          const WalletError('Error generating seed phrase'),
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const GenerateSeedPhraseRequested());
      },
    );
  });

  group('SavePublicKeyRequested', () {
    const tPublicKey = 'test_public_key';
    const tUserId = 'test_user_id';

    test(
      'should emit [WalletLoading, PublicKeySaved] when public key is saved successfully',
      () async {
        // arrange
        when(
          mockSavePublicKey(tPublicKey, tUserId),
        ).thenAnswer((_) async => true);

        // assert later
        final expected = [
          const WalletLoading(),
          const PublicKeySaved(
            publicKey: tPublicKey,
            userId: tUserId,
          ),
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const SavePublicKeyRequested(
          publicKey: tPublicKey,
          userId: tUserId,
        ));
      },
    );

    test(
      'should emit [WalletLoading, WalletError] when public key saving fails',
      () async {
        // arrange
        when(mockSavePublicKey(tPublicKey, tUserId)).thenAnswer(
          (_) async => false,
        );

        // assert later
        final expected = [
          const WalletLoading(),
          const WalletError('Failed to save public key'),
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const SavePublicKeyRequested(
          publicKey: tPublicKey,
          userId: tUserId,
        ));
      },
    );

    test(
      'should emit [WalletLoading, WalletError] when save public key use case throws exception',
      () async {
        // arrange
        when(mockSavePublicKey(tPublicKey, tUserId)).thenAnswer(
          (_) async => throw Exception('Error saving public key'),
        );

        // assert later
        final expected = [
          const WalletLoading(),
          const WalletError('Exception: Error saving public key'),
        ];
        expectLater(walletBloc.stream, emitsInOrder(expected));

        // act
        walletBloc.add(const SavePublicKeyRequested(
          publicKey: tPublicKey,
          userId: tUserId,
        ));
      },
    );
  });
}
