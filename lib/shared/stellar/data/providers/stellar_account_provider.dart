import 'package:nemorixpay/shared/common/data/models/asset_model.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';

/// @file        stellar_account_provider.dart
/// @brief       Provider for managing the current Stellar account.
/// @details     This class provides a singleton instance to manage the current
///              Stellar account state throughout the application.
/// @author      Miguel Fagundez
/// @date        2025-05-17
/// @version     1.1
/// @copyright   Apache 2.0 License

class StellarAccountProvider {
  static final StellarAccountProvider _instance =
      StellarAccountProvider._internal();
  factory StellarAccountProvider() => _instance;
  StellarAccountProvider._internal();

  /// Internal user account
  StellarAccountModel? _currentAccount = const StellarAccountModel();

  /// Firebase user account id
  String? userId;

  /// Gets the current Stellar account
  StellarAccountModel? get currentAccount => _currentAccount;

  // Validation method
  bool get hasValidAccount => _currentAccount?.isValid ?? false;

  /// Sets the current Stellar account
  void setCurrentAccount(StellarAccountModel account) {
    _currentAccount = account;
  }

  /// Updates the current mnemonic, public & secret keys
  void updateSecretKey(String newSecretKey) {
    if (_currentAccount != null) {
      _currentAccount = _currentAccount!.copyWith(secretKey: newSecretKey);
    }
  }

  void updatePublicKey(String newPublicKey) {
    if (_currentAccount != null) {
      _currentAccount = _currentAccount!.copyWith(publicKey: newPublicKey);
    }
  }

  void updateMnemonic(String newMnemonic) {
    if (_currentAccount != null) {
      _currentAccount = _currentAccount!.copyWith(mnemonic: newMnemonic);
    }
  }

  /// Updates the current account balance
  void updateBalance(double newBalance) {
    if (_currentAccount != null) {
      _currentAccount = _currentAccount!.copyWith(balance: newBalance);
    }
  }

  /// Updates the current account assets
  void updateAssets(List<AssetModel> newAssets) {
    if (_currentAccount != null) {
      _currentAccount = _currentAccount!.copyWith(assets: newAssets);
    }
  }

  /// Clears the current account
  void clearCurrentAccount() {
    _currentAccount = null;
    _currentAccount = const StellarAccountModel();
  }

  /// Gets the secret key for the current account
  /// Returns null if there is no current account or if the secret key is not available
  String? getSecretKey() {
    return _currentAccount?.secretKey;
  }

  /// Gets the public key for the current account
  /// Returns null if there is no current account or if the public key is not available
  String? getPublicKey() {
    return _currentAccount?.publicKey;
  }

  /// Gets the mnemonic for the current account
  /// Returns null if there is no current account or if the mnemonic is not available
  String? getMnemonic() {
    return _currentAccount?.mnemonic;
  }

  // Sync methods
  Future<void> syncWithSecureStorage() async {
    // TODO: Need to check secure storage if needed
  }
}
