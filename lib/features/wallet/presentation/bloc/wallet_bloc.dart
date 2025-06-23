import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/create_wallet.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/get_wallet_balance.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/import_wallet.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/seed_phrase_usecase.dart';
import 'package:nemorixpay/features/wallet/domain/usecases/save_public_key_usecase.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_event.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_state.dart';

/// @file        wallet_bloc.dart
/// @brief       Implements the Wallet Bloc
/// @details     Manages the state and business logic for wallet operations,
///             including creation, import, and balance retrieval.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.1
/// @copyright   Apache 2.0 License
class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final CreateSeedPhraseUseCase _createSeedPhraseUseCase;
  final CreateWalletUseCase _createWalletUseCase;
  final ImportWalletUseCase _importWalletUseCase;
  final GetWalletBalanceUseCase _getWalletBalanceUseCase;
  final SavePublicKeyUseCase _savePublicKeyUseCase;

  WalletBloc({
    required CreateSeedPhraseUseCase createSeedPhraseUseCase,
    required CreateWalletUseCase createWalletUseCase,
    required ImportWalletUseCase importWalletUseCase,
    required GetWalletBalanceUseCase getWalletBalanceUseCase,
    required SavePublicKeyUseCase savePublicKeyUseCase,
  })  : _createSeedPhraseUseCase = createSeedPhraseUseCase,
        _createWalletUseCase = createWalletUseCase,
        _importWalletUseCase = importWalletUseCase,
        _getWalletBalanceUseCase = getWalletBalanceUseCase,
        _savePublicKeyUseCase = savePublicKeyUseCase,
        super(const WalletInitial()) {
    on<GenerateSeedPhraseRequested>(_onGenerateSeedPhrase);
    on<CreateWalletRequested>(_onCreateWallet);
    on<ImportWalletRequested>(_onImportWallet);
    on<GetWalletBalanceRequested>(_onGetWalletBalance);
    on<SavePublicKeyRequested>(_onSavePublicKey);
  }

  Future<void> _onGenerateSeedPhrase(
    GenerateSeedPhraseRequested event,
    Emitter<WalletState> emit,
  ) async {
    debugPrint('WalletBloc - Begin create seed phrase process');
    emit(const WalletLoading());

    try {
      debugPrint('WalletBloc - Calling create seed phrase use case');
      final result = await _createSeedPhraseUseCase();

      result.fold(
        (failure) {
          debugPrint(
            'WalletBloc - Seed Phrase creation failed: ${failure.message}',
          );
          emit(WalletError(failure.message));
        },
        (seedPhrase) {
          debugPrint('WalletBloc - Seed Phrase created successfully');
          emit(SeedPhraseCreated(seedPhrase));
        },
      );
    } catch (e) {
      debugPrint('WalletBloc - Unexpected error: $e');
      emit(WalletError(e.toString()));
    }
  }

  Future<void> _onCreateWallet(
    CreateWalletRequested event,
    Emitter<WalletState> emit,
  ) async {
    debugPrint('WalletBloc - Begin create wallet process');
    emit(const WalletLoading(isSecondLoading: true));

    try {
      debugPrint('WalletBloc - Calling create wallet use case');
      final result = await _createWalletUseCase(event.mnemonic);

      result.fold(
        (failure) {
          debugPrint('WalletBloc - Wallet creation failed: ${failure.message}');
          emit(WalletError(failure.message));
        },
        (wallet) {
          debugPrint('WalletBloc - Wallet created successfully');
          emit(WalletCreated(wallet));
        },
      );
    } catch (e) {
      debugPrint('WalletBloc - Unexpected error: $e');
      emit(WalletError(e.toString()));
    }
  }

  Future<void> _onImportWallet(
    ImportWalletRequested event,
    Emitter<WalletState> emit,
  ) async {
    debugPrint('WalletBloc - Begin import wallet process');
    emit(const WalletLoading(isSecondLoading: true));

    try {
      debugPrint('WalletBloc - Calling import wallet use case');
      final result = await _importWalletUseCase(event.mnemonic);

      result.fold(
        (failure) {
          debugPrint('WalletBloc - Wallet import failed: ${failure.message}');
          emit(WalletError(failure.message));
        },
        (wallet) {
          debugPrint('WalletBloc - Wallet imported successfully');
          emit(WalletImported(wallet));
        },
      );
    } catch (e) {
      debugPrint('WalletBloc - Unexpected error: $e');
      emit(WalletError(e.toString()));
    }
  }

  Future<void> _onGetWalletBalance(
    GetWalletBalanceRequested event,
    Emitter<WalletState> emit,
  ) async {
    debugPrint('WalletBloc - Begin get wallet balance process');
    emit(const WalletLoading());

    try {
      debugPrint('WalletBloc - Calling get wallet balance use case');
      final result = await _getWalletBalanceUseCase(event.publicKey);

      result.fold(
        (failure) {
          debugPrint('WalletBloc - Get balance failed: ${failure.message}');
          emit(WalletError(failure.message));
        },
        (balance) {
          debugPrint('WalletBloc - Balance retrieved successfully');
          emit(WalletBalanceLoaded(balance));
        },
      );
    } catch (e) {
      debugPrint('WalletBloc - Unexpected error: $e');
      emit(WalletError(e.toString()));
    }
  }

  Future<void> _onSavePublicKey(
    SavePublicKeyRequested event,
    Emitter<WalletState> emit,
  ) async {
    debugPrint('WalletBloc - Begin save public key process');
    debugPrint('WalletBloc - Public key: ${event.publicKey}');
    debugPrint('WalletBloc - User ID: ${event.userId}');
    emit(const WalletLoading());

    try {
      debugPrint('WalletBloc - Calling save public key use case');
      final saved = await _savePublicKeyUseCase(event.publicKey, event.userId);

      if (saved) {
        debugPrint('WalletBloc - Public key saved successfully');
        emit(PublicKeySaved(
          publicKey: event.publicKey,
          userId: event.userId,
        ));
      } else {
        debugPrint('WalletBloc - Failed to save public key');
        emit(const WalletError('Failed to save public key'));
      }
    } catch (e) {
      debugPrint('WalletBloc - Unexpected error saving public key: $e');
      emit(WalletError(e.toString()));
    }
  }
}
