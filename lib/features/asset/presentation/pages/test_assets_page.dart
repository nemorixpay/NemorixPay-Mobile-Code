import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_bloc.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_event.dart';
import 'package:nemorixpay/features/asset/presentation/bloc/asset_state.dart';
import 'package:nemorixpay/shared/common/presentation/widgets/main_header.dart';

/// @file        test_assets_page.dart
/// @brief       Test page for assets list functionality.
/// @details     This page is used to test the assets list functionality.
/// @author      Miguel Fagundez
/// @date        2025-05-27
/// @version     1.0
/// @copyright   Apache 2.0 License
class TestAssetsPage extends StatelessWidget {
  const TestAssetsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const MainHeader(
              title: 'Assets List Test',
              showSearchButton: false,
            ),
            Expanded(
              child: BlocConsumer<AssetBloc, AssetState>(
                listener: (context, state) {
                  if (state is AssetListLoaded) {
                    debugPrint('Assets loaded: ${state.assets.length}');
                    for (var asset in state.assets) {
                      debugPrint('Asset: ${asset.name} (${asset.symbol})');
                    }
                  } else if (state is AssetListError) {
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
                        if (state is AssetListLoading)
                          const CircularProgressIndicator()
                        else
                          ElevatedButton(
                            onPressed: () {
                              context.read<AssetBloc>().add(GetAssetsList());
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
