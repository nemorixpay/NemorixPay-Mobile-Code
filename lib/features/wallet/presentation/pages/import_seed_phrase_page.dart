import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_event.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_state.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/features/wallet/presentation/widgets/seed_phrase_input_grid.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/features/wallet/presentation/widgets/continue_button.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';
import '../../../../core/security/secure_screen_mixin.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/app_loader.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// @file        import_seed_phrase_page.dart
/// @brief       Import Seed Phrase screen for NemorixPay wallet feature.
/// @details     This file contains the UI and logic for importing a Stellar account using a 12 or 24 word mnemonic phrase.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.2
/// @copyright   Apache 2.0 License

/// @brief Page for importing a Stellar account using a seed phrase.
/// @details Allows the user to input a 12 or 24 word mnemonic phrase to import their wallet. The UI adapts to the selected phrase length and supports both light and dark themes.
class ImportSeedPhrasePage extends StatefulWidget {
  const ImportSeedPhrasePage({super.key});

  @override
  State<ImportSeedPhrasePage> createState() => _ImportSeedPhrasePageState();
}

class _ImportSeedPhrasePageState extends State<ImportSeedPhrasePage>
    with SecureScreenMixin {
  /// @brief Current selected phrase length (12 or 24)
  int _phraseLength = 12;

  /// @brief List of available phrase length options
  final List<int> _phraseOptions = [12, 24];

  /// @brief List of controllers for each seed phrase input field
  late List<TextEditingController> _controllers;

  @override
  void initState() {
    super.initState();
    _initControllers();
    _addListeners();
  }

  /// @brief Initializes the controllers list based on the current phrase length
  void _initControllers() {
    _controllers = List.generate(_phraseLength, (_) => TextEditingController());
  }

  /// @brief Adds listeners to all controllers to update the UI on text change
  void _addListeners() {
    for (final controller in _controllers) {
      controller.addListener(_onFieldChanged);
    }
  }

  /// @brief Removes all listeners from controllers
  void _removeListeners() {
    for (final controller in _controllers) {
      controller.removeListener(_onFieldChanged);
    }
  }

  /// @brief Callback to update the UI when any field changes
  void _onFieldChanged() {
    setState(() {});
  }

  /// @brief Updates the controllers list when the phrase length changes
  void _updateControllers(int newLength) {
    _removeListeners();
    if (newLength == _controllers.length) {
      _addListeners();
      return;
    }
    if (newLength > _controllers.length) {
      _controllers.addAll(
        List.generate(
          newLength - _controllers.length,
          (_) => TextEditingController(),
        ),
      );
    } else {
      _controllers = _controllers.sublist(0, newLength);
    }
    _addListeners();
  }

  /// @brief Checks if all seed phrase fields are filled
  bool get _allFieldsFilled =>
      _controllers.every((c) => c.text.trim().isNotEmpty);

  /// @brief Gets the mnemonic phrase from the input fields
  String get _mnemonic => _controllers
      .map((c) => c.text.trim())
      .where((text) => text.isNotEmpty)
      .join(' ');

  @override
  void dispose() {
    _removeListeners();
    for (final controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget buildSecureScreen(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<WalletBloc, WalletState>(
      listener: (context, state) {
        if (state is WalletLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AppLoader(message: l10n.importingWallet),
          );
        } else if (state is WalletError) {
          debugPrint('Wallet not imported - WalletError');
          NemorixSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is WalletImported) {
          Navigator.of(context).pop(); // Close loader if open
          debugPrint('Wallet imported - Secret Key: ${state.wallet.secretKey}');
          debugPrint('Wallet imported - Seed Phrase: ${state.wallet.mnemonic}');

          // Get current user ID from Firebase and save public key
          final firebaseUser = FirebaseAuth.instance.currentUser;

          if (firebaseUser == null) {
            // ERROR: No authenticated user
            NemorixSnackBar.show(
              context,
              message: l10n.walletErrorUserNotAuthenticated,
              type: SnackBarType.error,
            );
            // Go to SignIn page
            Navigator.pushNamedAndRemoveUntil(
                context, RouteNames.signIn, (route) => false);
            return;
          }

          if (state.wallet.publicKey == null) {
            // ERROR: Wallet did not create it successfully
            NemorixSnackBar.show(
              context,
              message: l10n.walletErrorCreationFailedGeneric,
              type: SnackBarType.error,
            );
            // Go back to Wallet Setup
            Navigator.pop(context);
            return;
          }

          // Saving wallet / account data
          StellarAccountProvider stellarAccountProvider =
              StellarAccountProvider();
          stellarAccountProvider.userId = firebaseUser.uid;
          stellarAccountProvider.updatePublicKey(state.wallet.publicKey!);

          debugPrint('Saving public key for user: ${firebaseUser.uid}');

          // Saving account data in secure internal storage
          context.read<WalletBloc>().add(
                SavePublicKeyRequested(
                  publicKey: state.wallet.publicKey!,
                  userId: firebaseUser.uid,
                ),
              );
        } else if (state is PublicKeySaved) {
          StellarAccountProvider stellarAccountProvider =
              StellarAccountProvider();
          stellarAccountProvider.userId = state.userId;
          stellarAccountProvider.updatePublicKey(state.publicKey);

          debugPrint('Public key saved successfully: ${state.userId}');
          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.successPage,
            arguments: {
              'titleSuccess': l10n.importWalletSuccessTitle,
              'firstParagraph': l10n.walletSuccessSecurity,
              'secondParagraph': l10n.walletSuccessInfo,
            },
            (route) => false,
          );
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                MainHeader(
                  title: l10n.importStellarAccountTitle,
                  showSearchButton: false,
                ),
                const SizedBox(height: 24),
                // Instructions text
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Text(
                    l10n.importSeedPhraseInstructions,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
                const SizedBox(height: 24),
                // Dropdown for selecting phrase length
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: BaseCard(
                    cardWidget: DropdownButtonFormField<int>(
                      value: _phraseLength,
                      decoration: InputDecoration(
                        labelText: l10n.seedPhraseTypeLabel,
                        border: OutlineInputBorder(),
                        isDense: true,
                      ),
                      items: _phraseOptions.map((option) {
                        return DropdownMenuItem<int>(
                          value: option,
                          child: Text('$option ${l10n.seedPhraseLabel}'),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _phraseLength = value;
                            _updateControllers(value);
                          });
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Dynamic grid of seed phrase input fields
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: BaseCard(
                    cardWidget: SeedPhraseInputGrid(
                      phraseLength: _phraseLength,
                      controllers: _controllers,
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                // Continue button
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: ContinueButton(
                    label: l10n.next,
                    enabled: _allFieldsFilled,
                    onPressed: _allFieldsFilled
                        ? () {
                            // context.read<StellarBloc>().add(
                            //   ImportAccountEvent(mnemonic: _mnemonic),
                            // );
                            context.read<WalletBloc>().add(
                                  ImportWalletRequested(_mnemonic),
                                );
                          }
                        : () {},
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
