import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_bloc.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_event.dart';
import 'package:nemorixpay/features/crypto/presentation/bloc/crypto_state.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';

/// @file        test_crypto_page.dart
/// @brief       Test page for crypto list functionality.
/// @details     This page is used to test the crypto list functionality.
/// @author      Miguel Fagundez
/// @date        2025-05-27
/// @version     1.0
/// @copyright   Apache 2.0 License
class TestCryptoPage extends StatelessWidget {
  const TestCryptoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MainHeader(
              title: 'Assets Crypto Test',
              showSearchButton: false,
            ),
            Expanded(
              child: BlocConsumer<CryptoBloc, CryptoState>(
                listener: (context, state) {
                  if (state is CryptoListLoaded) {
                    debugPrint('Assets loaded: ${state.assets.length}');
                    for (var asset in state.assets) {
                      debugPrint('Asset: ${asset.name} (${asset.symbol})');
                    }
                  } else if (state is CryptoListError) {
                    debugPrint(
                      'Error loading assets: ${state.failure.message}',
                    );
                  }
                },
                builder: (context, state) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (state is CryptoListLoading)
                          const CircularProgressIndicator()
                        else
                          ElevatedButton(
                            onPressed: () {
                              context.read<CryptoBloc>().add(GetCryptoList());
                            },
                            child: const Text('Load Assets'),
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
