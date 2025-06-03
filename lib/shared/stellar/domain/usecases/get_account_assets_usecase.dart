import 'package:dartz/dartz.dart';
import 'package:nemorixpay/core/errors/failures.dart';
import 'package:nemorixpay/shared/common/domain/entities/asset_entity.dart';
import 'package:nemorixpay/shared/stellar/domain/repositories/stellar_repository.dart';

/// @file        get_account_assets_usecase.dart
/// @brief       Use case for retrieving all assets from a Stellar account.
/// @details     This use case handles the business logic for retrieving
///              all assets and their balances from a Stellar account.
/// @author      Miguel Fagundez
/// @date        2025-05-21
/// @version     1.0
/// @copyright   Apache 2.0 License

class GetAccountAssetsUseCase {
  final StellarRepository repository;

  GetAccountAssetsUseCase({required this.repository});

  /// Gets all assets and their balances for a given Stellar account
  /// @param publicKey The public key of the account
  /// @return Either<Failure, List<AssetEntity>> List of assets with their balances or error
  Future<Either<Failure, List<AssetEntity>>> call(String publicKey) async {
    return await repository.getAccountAssets(publicKey);
  }
}
