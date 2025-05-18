import 'package:nemorixpay/shared/stellar/data/models/stellar_account_model.dart';

/// @file        stellar_account_provider.dart
/// @brief       Provider for managing the current Stellar account.
/// @details     This class provides a singleton instance to manage the current
///              Stellar account state throughout the application.
/// @author      Miguel Fagundez
/// @date        2025-05-17
/// @version     1.0
/// @copyright   Apache 2.0 License

class StellarAccountProvider {
  static final StellarAccountProvider _instance =
      StellarAccountProvider._internal();
  factory StellarAccountProvider() => _instance;
  StellarAccountProvider._internal();

  StellarAccountModel? _currentAccount;

  // Datos de la cuenta de prueba
  static const String _testMnemonic =
      'blush fragile rapid arrange visit skin autumn jazz muscle save nature drastic crystal slab casual grow crush remain foil cigar any century heavy print';
  static const String _testPublicKey =
      'GBHMJ4EBAHCXEPNJK5RAMWFBGKCDMRA4ZRWFOJNUIPHUSJD2HNEVU6V4';
  static const String _testSecretKey =
      'SBNAOADD6GUXD4SMKK5H7SOFSZ3AO3IW3XAYZFQ2VOEOJOSBGBBGX4GI';

  /// Gets the current Stellar account
  StellarAccountModel? get currentAccount => _currentAccount;

  /// Sets the current Stellar account
  void setCurrentAccount(StellarAccountModel account) {
    _currentAccount = account;
  }

  /// Updates the current account balance
  void updateBalance(double newBalance) {
    if (_currentAccount != null) {
      _currentAccount = _currentAccount!.copyWith(balance: newBalance);
    }
  }

  /// Clears the current account
  void clearCurrentAccount() {
    _currentAccount = null;
  }

  /// Sets the test account as the current account
  void useTestAccount() {
    _currentAccount = StellarAccountModel(
      publicKey: _testPublicKey,
      secretKey: _testSecretKey,
      balance: 0.0, // Se actualizará cuando se consulte el balance
      mnemonic: _testMnemonic,
      createdAt: DateTime.now(),
    );
  }

  /// Gets the test account mnemonic
  String get testMnemonic => _testMnemonic;

  /// Gets the test account public key
  String get testPublicKey => _testPublicKey;

  /// Gets the test account secret key
  String get testSecretKey => _testSecretKey;
}
