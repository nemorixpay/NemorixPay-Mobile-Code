// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'NemorixPay';

  @override
  String get loading => 'It is loading';

  @override
  String get welcomeBack => 'Welcome Back';

  @override
  String get youHaveBeenMissed => 'You have been missed';

  @override
  String get emailAddress => 'Email Address';

  @override
  String get emailIsRequired => 'Email is required';

  @override
  String get enterValidEmail => 'Please enter a valid email address';

  @override
  String get password => 'Password';

  @override
  String get passwordIsRequired => 'Password is required';

  @override
  String get passwordAtLeast6Characters => 'Password must be at least 6 characters';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get signIn => 'Sign In';

  @override
  String get or => 'OR';

  @override
  String get continueWithGoogle => 'Continue with Google';

  @override
  String get continueWithApple => 'Continue with Apple';

  @override
  String get googleSignInNotImplemented => 'Google Sign-In not implemented yet';

  @override
  String get appleSignInNotImplemented => 'Apple Sign-In not implemented yet';

  @override
  String get dontHaveAnAccount => 'Don\'t have an account';

  @override
  String get emailWasSent => 'Password reset email has been sent. Please check your inbox.';

  @override
  String get forgotPasswordTitle => 'Forgot Password';

  @override
  String get forgotPasswordSubtitle => 'Enter your email address and we\'ll send you instructions to reset your password.';

  @override
  String get sendEmail => 'Send Email';

  @override
  String get signUp => 'Sign Up';

  @override
  String get onlyTakesAminute => 'It only takes a minute to create your account';

  @override
  String get firstNameRequired => 'First name is required';

  @override
  String get firstName => 'First Name';

  @override
  String get lastNameRequired => 'Last name is required';

  @override
  String get lastName => 'Last Name';

  @override
  String get confirmYourPassword => 'Confirm your password';

  @override
  String get passwordsDoNotMatch => 'Passwords do not match';

  @override
  String get securityWordRequired => 'Security word is required';

  @override
  String get securityWord => 'Security word';

  @override
  String get birthdateRequired => 'Birthdate is required';

  @override
  String get fillRegistrationData => 'Please fill in all registration fields to continue';

  @override
  String get acceptTermsAndConditions => 'Please accept the terms and conditions';

  @override
  String get alreadyHaveAnAccount => 'Already have an account? Sign in';

  @override
  String get registrationSuccess => 'Your account has been created successfully. You can now sign in with your credentials.';

  @override
  String get agreeToTerms => 'I agree to the terms and conditions';

  @override
  String get verifyEmailTitle => 'Verify Your Email';

  @override
  String get verifyEmailSubtitle => 'We\'ve sent you a verification email. Please check your inbox and click the verification link to activate your account.';

  @override
  String get resendVerificationEmail => 'Resend Verification Email';

  @override
  String get verificationEmailSent => 'Verification email has been sent. Please check your inbox.';

  @override
  String get iReceivedTheEmail => 'I already received the email';

  @override
  String get authErrorEmailNotVerified => 'Please verify your email before signing in.';

  @override
  String get verifyEmailMessage => 'We have sent you a verification email. Please check your inbox and follow the instructions to verify your account.';

  @override
  String waitTimeMessage(int minutes) {
    return 'Wait time: $minutes minutes';
  }

  @override
  String get close => 'Close';

  @override
  String get resendVerification => 'Resend verification';

  @override
  String get seedPhraseVerifiedTitle => 'Seed Phrase Verified!';

  @override
  String get seedPhraseVerifiedMessage => 'You have successfully verified your seed phrase. Remember to keep it in a safe place, as it\'s the only way to recover your wallet if you lose access to your account.';

  @override
  String get iUnderstand => 'I understand';

  @override
  String get walletSuccessTitle => 'You\'ve successfully created your wallet.';

  @override
  String get importWalletSuccessTitle => 'You\'ve successfully imported your wallet.';

  @override
  String get walletSuccessSecurity => 'Remember to keep your seed phrase safe, it\'s your responsibility!';

  @override
  String get walletSuccessInfo => 'NemorixPay cannot recover your wallet if you lose it. You can find your seed phrase in Settings > Security & Privacy.';

  @override
  String get goToHomePage => 'Go to Home Page';

  @override
  String get search => 'Search';

  @override
  String get myAssets => 'My Assets';

  @override
  String get seeAll => 'See All';

  @override
  String get livePrices => 'Live Prices';

  @override
  String get currentWalletBalance => 'Current Wallet Balance';

  @override
  String get deposit => 'Deposit';

  @override
  String get withdraw => 'Withdraw';

  @override
  String get send => 'Send';

  @override
  String get receive => 'Receive';

  @override
  String get sell => 'Sell';

  @override
  String get buy => 'Buy';

  @override
  String get marketCap => 'Market Cap';

  @override
  String get volume => 'Volume';

  @override
  String get circulatingSupply => 'Circulating Supply';

  @override
  String get totalSupply => 'Total Supply';

  @override
  String get allTimeHigh => 'All Time High';

  @override
  String get performance => 'Performance';

  @override
  String get youPay => 'You Pay';

  @override
  String get youReceive => 'You Receive';

  @override
  String get exchangeFee => 'Exchange fee';

  @override
  String get clickHereFor => 'Click here for ';

  @override
  String get termsAndConditions => 'Terms & Conditions.';

  @override
  String get transactionFeeTaken => 'For this transaction fee will be taken.';

  @override
  String get continueLabel => 'Continue';

  @override
  String get personalInformation => 'Personal Information';

  @override
  String get enterYourPersonalInfo => 'Please enter your personal information';

  @override
  String get accountInformation => 'Account Information';

  @override
  String get enterYourAccountInfo => 'Please enter your account information';

  @override
  String get security => 'Security';

  @override
  String get enterYourSecurityInfo => 'Please enter a security word that you can remember in case you lose access to your NemorixPay account.';

  @override
  String get loginCredentials => 'Login Credentials';

  @override
  String get enterYourLoginInfo => 'Please enter your email and password to access your account';

  @override
  String get loginOptions => 'Login Options';

  @override
  String get chooseYourLoginMethod => 'Choose how you want to access your account';

  @override
  String get invalidAmountFormat => 'Please enter a valid amount';

  @override
  String get minimumAmount => 'Minimum amount is \$1';

  @override
  String get maximumAmount => 'Maximum daily amount is \$10,000';

  @override
  String get commissionBelowMinimum => 'Commission rate is below minimum allowed (0.05%)';

  @override
  String get commissionAboveMaximum => 'Commission rate exceeds maximum allowed (1.0%)';

  @override
  String get commissionExceedsLimit => 'Commission amount exceeds maximum limit (\$50)';

  @override
  String get totalAmount => 'Total Amount';

  @override
  String get continueText => 'Continue';

  @override
  String get noPaymentMethodSelected => 'Please select a payment method';

  @override
  String get invalidCardSelected => 'Please select a valid card';

  @override
  String get cardExpired => 'The selected card has expired';

  @override
  String get walletSetupTitle => 'Wallet Setup';

  @override
  String get walletSetupSubtitle => 'Import an existing wallet or create a new one';

  @override
  String get importUsingSeedPhrase => 'Import Using Seed Phrase';

  @override
  String get creatingSeedPhrase => 'Creating Seed Phrase..';

  @override
  String get creatingNewAccount => 'Creating a New Wallet..';

  @override
  String get createNewAccount => 'Create a New Account';

  @override
  String get importSeedPhraseInstructions => 'Enter Your Seed Phrase (12 or 24 words). NemorixPay will not store your mnemonic phrases.';

  @override
  String get next => 'Next';

  @override
  String get writeDownSeedPhraseTitle => 'Write Down Your Seed Phrase';

  @override
  String get writeDownSeedPhraseInstructions => 'This is your seed phrase. Write it down on a paper and keep it in a safe place. You will be asked to re-enter this phrase (in order) on the next step.';

  @override
  String get importStellarAccountTitle => 'Import Your Stellar Account';

  @override
  String get importingWallet => 'Importing Wallet...';

  @override
  String get seedPhraseTypeLabel => 'Seed Phrase Type';

  @override
  String get seedPhraseLabel => 'Seed Phrase';

  @override
  String get confirmSeedPhraseTitle => 'Confirm Seed Phrase';

  @override
  String get confirmSeedPhraseInstructions => 'Select each word in the order it was presented to you.';

  @override
  String get confirmSeedPhraseError => 'Incorrect word. Please check your seed phrase and make sure you wrote down all the words in the correct order. If you make a mistake, you may lose access to your account.';

  @override
  String get confirmSeedPhraseSuccess => 'Correct! Now confirm a second word from your seed phrase.';

  @override
  String get authErrorUserNotFound => 'No account found with this email.';

  @override
  String get authErrorWrongPassword => 'Incorrect password.';

  @override
  String get authErrorInvalidEmail => 'Invalid email format.';

  @override
  String get authErrorUserDisabled => 'This account has been disabled.';

  @override
  String get authErrorEmailAlreadyInUse => 'An account already exists with this email.';

  @override
  String get authErrorWeakPassword => 'Password is too weak.';

  @override
  String get authErrorOperationNotAllowed => 'This operation is not allowed.';

  @override
  String get authErrorTooManyRequests => 'Too many failed attempts. Please try again later.';

  @override
  String get authErrorNetworkRequestFailed => 'Connection error. Please check your internet connection.';

  @override
  String get authErrorRequiresRecentLogin => 'Please sign in again to perform this action.';

  @override
  String get authErrorUnknown => 'An unexpected error occurred. Please try again.';

  @override
  String get authErrorInvalidCredential => 'Invalid credentials.';

  @override
  String get authErrorAccountExistsWithDifferentCredential => 'An account already exists with these credentials.';

  @override
  String get authErrorInvalidVerificationCode => 'Invalid verification code.';

  @override
  String get authErrorInvalidVerificationId => 'Invalid verification ID.';

  @override
  String get authErrorMissingVerificationCode => 'Missing verification code.';

  @override
  String get authErrorMissingVerificationId => 'Missing verification ID.';

  @override
  String get stellarErrorAccountNotFound => 'Stellar account not found';

  @override
  String get stellarErrorAccountExists => 'Stellar account already exists';

  @override
  String get stellarErrorInvalidAccount => 'Invalid Stellar account';

  @override
  String get stellarErrorInsufficientBalance => 'Insufficient balance in Stellar account';

  @override
  String get stellarErrorTransactionFailed => 'Stellar transaction failed';

  @override
  String get stellarErrorInvalidTransaction => 'Invalid Stellar transaction';

  @override
  String get stellarErrorTransactionExpired => 'Stellar transaction expired';

  @override
  String get stellarErrorInvalidAmount => 'Invalid amount for Stellar transaction';

  @override
  String get stellarErrorNetworkError => 'Stellar network error';

  @override
  String get stellarErrorServerError => 'Stellar server error';

  @override
  String get stellarErrorTimeoutError => 'Stellar request timed out';

  @override
  String get stellarErrorUnknown => 'Unknown Stellar error';

  @override
  String get stellarErrorInvalidOperation => 'Invalid Stellar operation';

  @override
  String get stellarErrorInvalidMnemonic => 'Invalid Stellar mnemonic phrase';

  @override
  String get stellarErrorInvalidSecretKey => 'Invalid Stellar secret key';

  @override
  String get stellarErrorInvalidPublicKey => 'Invalid public key';

  @override
  String get stellarErrorInvalidMemo => 'Memo cannot be longer than 28 characters';

  @override
  String get stellarErrorAccountNotInitialized => 'No Stellar account has been initialized';

  @override
  String get walletErrorCreationFailed => 'Failed to create wallet. Please try again.';

  @override
  String get walletErrorInvalidMnemonic => 'Invalid mnemonic phrase. Please check and try again.';

  @override
  String get walletErrorMnemonicGenerationFailed => 'Failed to generate mnemonic phrase. Please try again.';

  @override
  String get walletErrorImportFailed => 'Failed to import wallet. Please check your mnemonic and try again.';

  @override
  String get walletErrorInvalidSecretKey => 'Invalid secret key. Please check and try again.';

  @override
  String get walletErrorBalanceRetrievalFailed => 'Failed to retrieve wallet balance. Please try again.';

  @override
  String get walletErrorInsufficientFunds => 'Insufficient funds to complete the transaction.';

  @override
  String get walletErrorAccountNotFound => 'Wallet account not found. Please check your credentials.';

  @override
  String get walletErrorNetworkError => 'Network error. Please check your connection and try again.';

  @override
  String get walletErrorTimeoutError => 'Request timed out. Please try again.';

  @override
  String get walletErrorUnknown => 'An unknown error occurred. Please try again.';

  @override
  String get assetErrorPriceUpdateFailed => 'Failed to update asset price';

  @override
  String get assetErrorInvalidPriceData => 'Invalid price data received';

  @override
  String get assetErrorPriceHistoryNotFound => 'Price history not found for this asset';

  @override
  String get assetErrorNetworkError => 'Network error while fetching asset data';

  @override
  String get assetErrorTimeoutError => 'Request timed out while fetching asset data';

  @override
  String get assetErrorInvalidSymbol => 'Invalid asset symbol';

  @override
  String get assetErrorDataParsingError => 'Error parsing asset data';

  @override
  String get assetErrorUnknown => 'An unexpected error occurred with the asset';

  @override
  String get assetErrorAssetsListFailed => 'Failed to get available assets';

  @override
  String get assetErrorMarketDataNotFound => 'Market data for this asset is currently unavailable';

  @override
  String get assetErrorDetailsNotFound => 'Could not find detailed information for this asset';

  @override
  String get assetErrorMarketDataUpdateFailed => 'Failed to update market data. Please try again later.';

  @override
  String get termsOfServices => 'Terms of Services';

  @override
  String get lastUpdate => 'Last update on';

  @override
  String get termsContent => 'Welcome to NemorixPay. Please read these Terms of Services carefully before using our application.';

  @override
  String get termsTitle => 'Terms';

  @override
  String get termsBody => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam dictum, urna eu facilisis cursus, enim libero dictum enim, nec scelerisque enim enim nec enim. \nLorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam dictum, urna eu facilisis cursus, enim libero dictum enim, nec scelerisque enim enim nec enim.';

  @override
  String get licenseTitle => 'Use License';

  @override
  String get licenseBody => 'Adipiscing tempus feugiat viverra iaculis. Odio et a ac pretium nulla pharetra in. Cursus aenean condimentum volutpat ullamcorper eu, feugiat sed massa. \nAdipiscing tempus feugiat viverra iaculis. Odio et a ac pretium nulla pharetra in. Cursus aenean condimentum volutpat ullamcorper eu, feugiat sed massa.';

  @override
  String get accept => 'Accept';

  @override
  String get decline => 'Decline';

  @override
  String get acceptTermsCheckbox => 'I accept the terms and conditions';

  @override
  String get onboarding_security_title => 'Your Security is Our Priority';

  @override
  String get onboarding_security_subtitle => 'We protect your funds and personal data';

  @override
  String get onboarding_security_feature_biometric_title => 'Biometric Authentication';

  @override
  String get onboarding_security_feature_biometric_desc => 'Access securely with your fingerprint';

  @override
  String get onboarding_security_feature_encryption_title => 'End-to-End Encryption';

  @override
  String get onboarding_security_feature_encryption_desc => 'Your data is always protected';

  @override
  String get onboarding_security_feature_monitoring_title => '24/7 Monitoring';

  @override
  String get onboarding_security_feature_monitoring_desc => 'Constant surveillance of your transactions';

  @override
  String get onboarding_button_skip => 'Skip';

  @override
  String get onboarding_button_next => 'Next';

  @override
  String get onboarding_button_back => 'Back';

  @override
  String get onboarding_features_title => 'Everything You Need in One Place';

  @override
  String get onboarding_features_subtitle => 'Manage your cryptocurrencies easily';

  @override
  String get onboarding_features_trading_title => 'Instant Trading';

  @override
  String get onboarding_features_trading_desc => 'Trade cryptocurrencies quickly and securely';

  @override
  String get onboarding_features_monitoring_title => 'Real-Time Monitoring';

  @override
  String get onboarding_features_monitoring_desc => 'Track market prices instantly';

  @override
  String get onboarding_features_history_title => 'Transaction History';

  @override
  String get onboarding_features_history_desc => 'Access your complete operation history';

  @override
  String get onboarding_features_notifications_title => 'Market Notifications';

  @override
  String get onboarding_features_notifications_desc => 'Receive alerts about important movements';

  @override
  String get onboarding_features_wallets_title => 'Multiple Wallets';

  @override
  String get onboarding_features_wallets_desc => 'Manage all your wallets in one place';

  @override
  String get onboarding_benefits_title => 'The Best Crypto Experience';

  @override
  String get onboarding_benefits_subtitle => 'Enjoy exclusive advantages';

  @override
  String get onboarding_benefits_fees_title => 'Competitive Fees';

  @override
  String get onboarding_benefits_fees_desc => 'The lowest fees in the market';

  @override
  String get onboarding_benefits_support_title => '24/7 Support';

  @override
  String get onboarding_benefits_support_desc => 'Technical support available at all times';

  @override
  String get onboarding_benefits_ui_title => 'Intuitive Interface';

  @override
  String get onboarding_benefits_ui_desc => 'Easy to use and understand design';

  @override
  String get onboarding_benefits_speed_title => 'Instant Transactions';

  @override
  String get onboarding_benefits_speed_desc => 'Fast and efficient operations';

  @override
  String get onboarding_benefits_coins_title => 'Wide Selection';

  @override
  String get onboarding_benefits_coins_desc => 'Access to over 100 cryptocurrencies';
}
