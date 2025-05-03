import 'package:flutter/material.dart';
import 'package:nemorixpay/features/wallet/ui/widgets/continue_button.dart';
import 'package:nemorixpay/shared/ui/widgets/main_header.dart';
import 'package:nemorixpay/shared/ui/widgets/base_card.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../core/security/secure_screen_mixin.dart';

/// @file        show_seed_phrase_page.dart
/// @brief       Show Seed Phrase screen for NemorixPay wallet feature.
/// @details     This file displays the generated seed phrase (12 or 24 words) for the user to write down and keep safe. It reuses existing widgets and adapts the grid for display only.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.1
/// @copyright   Apache 2.0 License

/// @brief Page to display the generated seed phrase for the user to write down.
/// @details The grid adapts to 12 or 24 words and is read-only.
class ShowSeedPhrasePage extends StatefulWidget {
  final List<String> seedPhrase;
  final VoidCallback? onNext;

  /// @param seedPhrase List of words (12 or 24) to display
  /// @param onNext Callback for the Next button
  const ShowSeedPhrasePage({super.key, required this.seedPhrase, this.onNext});

  @override
  _ShowSeedPhrasePageState createState() => _ShowSeedPhrasePageState();
}

class _ShowSeedPhrasePageState extends State<ShowSeedPhrasePage>
    with SecureScreenMixin {
  @override
  Widget buildSecureScreen(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              MainHeader(
                title: l10n.writeDownSeedPhraseTitle,
                showBackButton: true,
                showSearchButton: false,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Text(
                  l10n.writeDownSeedPhraseInstructions,
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: BaseCard(
                  cardWidget: SeedPhraseDisplayGrid(words: widget.seedPhrase),
                ),
              ),
              const SizedBox(height: 32),
              // Continue button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ContinueButton(
                  label: l10n.next,
                  onPressed: widget.onNext ?? () {},
                ),
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}

/// @brief Widget to display the seed phrase in a grid (read-only).
/// @details Adapts to 12 or 24 words, showing index and word in two columns.
class SeedPhraseDisplayGrid extends StatelessWidget {
  final List<String> words;
  const SeedPhraseDisplayGrid({super.key, required this.words});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 4.5,
        mainAxisSpacing: 8,
        crossAxisSpacing: 12,
      ),
      itemCount: words.length,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(8),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Text(
                '${index + 1}.',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  words[index],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
