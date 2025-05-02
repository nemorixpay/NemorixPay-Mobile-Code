/// @file        route_names.dart
/// @brief       Centralized route name constants for NemorixPay.
/// @details     This class contains all the named routes used throughout the application.
///             These constants ensure consistency and prevent typos in route names.
/// @author      Miguel Fagundez
/// @date        2025-04-28
/// @version     1.0
/// @copyright   Apache 2.0 License
class RouteNames {
  /// Initial splash screen route
  static const splash = "splash";

  /// User authentication - Sign In page
  static const signIn = "sign_in";

  /// User authentication - Sign Up page
  static const signUp = "sign_up";

  /// Password recovery page
  static const forgotPassword = "forgot_password";

  /// Analytics dashboard page
  static const homeAnalytics = "home_analytics";

  /// Main home page with cryptocurrency overview
  static const home = "home";

  /// Detailed view of a specific cryptocurrency
  static const cryptoDetails = "crypto_details";

  /// Page for purchasing cryptocurrencies
  static const buyCrypto = "buy_crypto";

  /// Page for selecting payment methods
  static const paymentMethod = "payment_method";

  /// Page for selecting payment methods
  static const walletSetup = "wallet_setup";

  /// Page for importing seed phrase
  static const importSeedPhrase = "import_seed_phrase";
}
