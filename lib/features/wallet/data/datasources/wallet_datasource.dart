import '../models/wallet_model.dart';

/// @file        wallet_datasource.dart
/// @brief       Interface for wallet data operations.
/// @details     Defines the contract for wallet operations including creation,
///              import, and balance retrieval. This interface abstracts the
///              data source implementation details from the repository layer.
/// @author      Miguel Fagundez
/// @date        2025-05-22
/// @version     1.0
/// @copyright   Apache 2.0 License

abstract class WalletDataSource {
  Future<WalletModel> createWallet(String nmemonic);
  Future<List<String>> createSeedPhrase();
  Future<WalletModel> importWallet(String mnemonic);
  Future<double> getWalletBalance(String publicKey);
}
