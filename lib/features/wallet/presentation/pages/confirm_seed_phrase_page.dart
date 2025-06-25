import 'dart:math';
import 'package:flutter/material.dart';
import 'package:nemorixpay/config/routes/route_names.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_event.dart';
import 'package:nemorixpay/features/wallet/presentation/bloc/wallet_state.dart';
import 'package:nemorixpay/features/wallet/presentation/widgets/seed_phrase_success_dialog.dart';
import 'package:nemorixpay/shared/cache/core/managers/asset_cache_manager.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/app_loader.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/base_card.dart';
import 'package:nemorixpay/features/wallet/presentation/widgets/continue_button.dart';
import 'package:nemorixpay/l10n/app_localizations.dart';
import 'package:nemorixpay/config/theme/nemorix_colors.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/nemorix_snackbar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// @file        confirm_seed_phrase_page.dart
/// @brief       Confirm Seed Phrase screen for NemorixPay wallet feature.
/// @details     This page verifies that the user has correctly written down their seed phrase by asking them to select specific words in the correct order. It supports both 12 and 24 word phrases and provides feedback on user selection.
/// @author      Miguel Fagundez
/// @date        2025-05-24
/// @version     1.1
/// @copyright   Apache 2.0 License
class ConfirmSeedPhrasePage extends StatefulWidget {
  final List<String> seedPhrase;
  final int attempts;
  final void Function()? onSuccess;
  final void Function()? onFail;

  /// @param seedPhrase The list of words (12 or 24) to verify
  /// @param attempts Number of verification attempts (default: 2)
  /// @param onSuccess Callback when user passes verification
  /// @param onFail Callback when user fails verification
  const ConfirmSeedPhrasePage({
    super.key,
    required this.seedPhrase,
    this.attempts = 2,
    this.onSuccess,
    this.onFail,
  });

  @override
  State<ConfirmSeedPhrasePage> createState() => _ConfirmSeedPhrasePageState();
}

class _ConfirmSeedPhrasePageState extends State<ConfirmSeedPhrasePage> {
  late int _currentAttempt;
  late int _randomIndex;
  late List<String> _options;
  int? _selectedIndex;
  bool _showError = false;
  int? _previousIndex;

  @override
  void initState() {
    super.initState();
    _currentAttempt = 1;
    _prepareQuestion();
  }

  void _prepareQuestion() {
    final rand = Random();
    int newIndex;
    do {
      newIndex = rand.nextInt(widget.seedPhrase.length);
    } while (_previousIndex != null && newIndex == _previousIndex);
    _randomIndex = newIndex;
    if (_currentAttempt == 1) {
      _previousIndex = _randomIndex;
    }
    // Get the correct word
    final correctWord = widget.seedPhrase[_randomIndex];
    // Get 3 distractors
    final distractors = <String>[];
    final pool = List<String>.from(widget.seedPhrase)..removeAt(_randomIndex);
    pool.shuffle(rand);
    distractors.addAll(pool.take(3));
    // Combine and shuffle
    _options = [correctWord, ...distractors];
    _options.shuffle(rand);
    _selectedIndex = null;
    _showError = false;
    setState(() {});
  }

  void _onOptionSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _showError = false;
    });
  }

  void _onNextPressed() {
    if (_selectedIndex == null) return;
    final selectedWord = _options[_selectedIndex!];
    final correctWord = widget.seedPhrase[_randomIndex];
    if (selectedWord == correctWord) {
      if (_currentAttempt < widget.attempts) {
        NemorixSnackBar.show(
          context,
          message: AppLocalizations.of(context)!.confirmSeedPhraseSuccess,
          type: SnackBarType.success,
        );
        _currentAttempt++;
        _prepareQuestion();
      } else {
        debugPrint('Before SeedPhraseSuccessDialog');
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) => SeedPhraseSuccessDialog(
            onContinue: () {
              debugPrint('SeedPhraseSuccessDialog - Pressed - WalletBloc');
              Navigator.of(context).pop();
              context.read<WalletBloc>().add(
                    CreateWalletRequested(widget.seedPhrase.join(' ')),
                  );
            },
          ),
        );
        debugPrint('After SeedPhraseSuccessDialog');
      }
    } else {
      setState(() {
        _showError = true;
      });
      if (widget.onFail != null) widget.onFail!();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return BlocListener<WalletBloc, WalletState>(
      listener: (context, state) {
        debugPrint('WalletBloc: ConfirmSeedPhrasePage');
        if (state is WalletLoading) {
          debugPrint('WALLET LOADING!');
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AppLoader(message: l10n.creatingNewAccount),
          );
        } else if (state is WalletError) {
          debugPrint('WALLET ERROR!');
          Navigator.of(context).pop(); // Close loader if open
          NemorixSnackBar.show(
            context,
            message: state.message,
            type: SnackBarType.error,
          );
        } else if (state is WalletCreated) {
          Navigator.of(context).pop(); // Close loader if open
          debugPrint('WALLET CREATED!');
          debugPrint('New Public Key: ${state.wallet.publicKey}');
          debugPrint('New Secret Key: ${state.wallet.secretKey}');
          // Get current user ID from Firebase and save public key
          final firebaseUser = FirebaseAuth.instance.currentUser;

          if (firebaseUser != null) {
            if (state.wallet.publicKey == null) {
              debugPrint(
                  'PublicKey is null, cannot save public key (ConfirmSeedPhrasePage)');
            } else {
              AssetCacheManager cache = AssetCacheManager();

              cache.setPublicKey(state.wallet.publicKey!);
              cache.setUserId(firebaseUser.uid);

              debugPrint('Saving public key for user: ${firebaseUser.uid}');
              context.read<WalletBloc>().add(
                    SavePublicKeyRequested(
                      publicKey: state.wallet.publicKey!,
                      userId: firebaseUser.uid,
                    ),
                  );
            }
          } else {
            debugPrint('No Firebase user found, cannot save public key');
          }

          Navigator.pushNamedAndRemoveUntil(
            context,
            RouteNames.successWalletCreation,
            arguments: l10n.walletSuccessTitle,
            (route) => false,
          );
        } else if (state is PublicKeySaved) {
          AssetCacheManager cache = AssetCacheManager();

          cache.setPublicKey(state.publicKey);
          cache.setUserId(state.userId);
          debugPrint('Public key saved successfully for user: ${state.userId}');
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MainHeader(
                title: l10n.confirmSeedPhraseTitle,
                showBackButton: true,
                showSearchButton: false,
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Text(
                  l10n.confirmSeedPhraseInstructions,
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ),
              const SizedBox(height: 24),
              Center(
                child: Text(
                  '${_randomIndex + 1}.',
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: BaseCard(
                  cardWidget: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 12,
                          crossAxisSpacing: 12,
                          childAspectRatio: 2.8,
                        ),
                        itemCount: _options.length,
                        itemBuilder: (context, index) {
                          final isSelected = _selectedIndex == index;
                          return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isSelected
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(
                                      context,
                                    ).colorScheme.surfaceContainerHighest,
                              foregroundColor: isSelected
                                  ? NemorixColors.mainBlack
                                  : Theme.of(context).colorScheme.onSurface,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: isSelected ? 2 : 0,
                            ),
                            onPressed: () => _onOptionSelected(index),
                            child: Text(
                              _options[index],
                              style: Theme.of(
                                context,
                              ).textTheme.bodyLarge?.copyWith(
                                    fontWeight: isSelected
                                        ? FontWeight.bold
                                        : FontWeight.normal,
                                  ),
                            ),
                          );
                        },
                      ),
                      if (_showError)
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 24.0,
                            bottom: 8.0,
                          ),
                          child: Text(
                            l10n.confirmSeedPhraseError,
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                  fontWeight: FontWeight.bold,
                                ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24.0,
                  vertical: 24.0,
                ),
                child: ContinueButton(
                  label: l10n.next,
                  enabled: _selectedIndex != null,
                  onPressed: () {
                    if (_selectedIndex != null) {
                      _onNextPressed();
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
