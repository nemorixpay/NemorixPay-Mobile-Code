import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_es.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('es')
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'NemorixPay'**
  String get appName;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @youHaveBeenMissed.
  ///
  /// In en, this message translates to:
  /// **'You have been missed'**
  String get youHaveBeenMissed;

  /// No description provided for @emailAddress.
  ///
  /// In en, this message translates to:
  /// **'Email Address'**
  String get emailAddress;

  /// No description provided for @emailIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailIsRequired;

  /// No description provided for @enterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email address'**
  String get enterValidEmail;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @passwordIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordIsRequired;

  /// No description provided for @passwordAtLeast6Characters.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordAtLeast6Characters;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @signIn.
  ///
  /// In en, this message translates to:
  /// **'Sign In'**
  String get signIn;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'OR'**
  String get or;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In en, this message translates to:
  /// **'Continue with Apple'**
  String get continueWithApple;

  /// No description provided for @dontHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account'**
  String get dontHaveAnAccount;

  /// No description provided for @emailWasSent.
  ///
  /// In en, this message translates to:
  /// **'Password reset email has been sent. Please check your inbox.'**
  String get emailWasSent;

  /// No description provided for @forgotPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password'**
  String get forgotPasswordTitle;

  /// No description provided for @forgotPasswordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you instructions to reset your password.'**
  String get forgotPasswordSubtitle;

  /// No description provided for @sendEmail.
  ///
  /// In en, this message translates to:
  /// **'Send Email'**
  String get sendEmail;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @onlyTakesAminute.
  ///
  /// In en, this message translates to:
  /// **'It only takes a minute to create your account'**
  String get onlyTakesAminute;

  /// No description provided for @firstNameRequired.
  ///
  /// In en, this message translates to:
  /// **'First name is required'**
  String get firstNameRequired;

  /// No description provided for @firstName.
  ///
  /// In en, this message translates to:
  /// **'First Name'**
  String get firstName;

  /// No description provided for @lastNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Last name is required'**
  String get lastNameRequired;

  /// No description provided for @lastName.
  ///
  /// In en, this message translates to:
  /// **'Last Name'**
  String get lastName;

  /// No description provided for @confirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm your password'**
  String get confirmYourPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @securityWordRequired.
  ///
  /// In en, this message translates to:
  /// **'Security word is required'**
  String get securityWordRequired;

  /// No description provided for @securityWord.
  ///
  /// In en, this message translates to:
  /// **'Security word'**
  String get securityWord;

  /// No description provided for @birthdateRequired.
  ///
  /// In en, this message translates to:
  /// **'Birthdate is required'**
  String get birthdateRequired;

  /// No description provided for @fillRegistrationData.
  ///
  /// In en, this message translates to:
  /// **'Please fill in all registration fields to continue'**
  String get fillRegistrationData;

  /// No description provided for @acceptTermsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms and conditions'**
  String get acceptTermsAndConditions;

  /// No description provided for @alreadyHaveAnAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account? Sign in'**
  String get alreadyHaveAnAccount;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Your account has been created successfully. You can now sign in with your credentials.'**
  String get registrationSuccess;

  /// No description provided for @agreeToTerms.
  ///
  /// In en, this message translates to:
  /// **'I agree to the terms and conditions'**
  String get agreeToTerms;

  /// No description provided for @verifyEmailTitle.
  ///
  /// In en, this message translates to:
  /// **'Verify Your Email'**
  String get verifyEmailTitle;

  /// No description provided for @verifyEmailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent you a verification email. Please check your inbox and click the verification link to activate your account.'**
  String get verifyEmailSubtitle;

  /// No description provided for @resendVerificationEmail.
  ///
  /// In en, this message translates to:
  /// **'Resend Verification Email'**
  String get resendVerificationEmail;

  /// No description provided for @verificationEmailSent.
  ///
  /// In en, this message translates to:
  /// **'Verification email has been sent. Please check your inbox.'**
  String get verificationEmailSent;

  /// No description provided for @iReceivedTheEmail.
  ///
  /// In en, this message translates to:
  /// **'I already received the email'**
  String get iReceivedTheEmail;

  /// No description provided for @authErrorEmailNotVerified.
  ///
  /// In en, this message translates to:
  /// **'Please verify your email before signing in.'**
  String get authErrorEmailNotVerified;

  /// No description provided for @verifyEmailMessage.
  ///
  /// In en, this message translates to:
  /// **'We have sent you a verification email. Please check your inbox and follow the instructions to verify your account.'**
  String get verifyEmailMessage;

  /// No description provided for @waitTimeMessage.
  ///
  /// In en, this message translates to:
  /// **'Wait time: {minutes} minutes'**
  String waitTimeMessage(int minutes);

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @resendVerification.
  ///
  /// In en, this message translates to:
  /// **'Resend verification'**
  String get resendVerification;

  /// No description provided for @seedPhraseVerifiedTitle.
  ///
  /// In en, this message translates to:
  /// **'Seed Phrase Verified!'**
  String get seedPhraseVerifiedTitle;

  /// No description provided for @seedPhraseVerifiedMessage.
  ///
  /// In en, this message translates to:
  /// **'You have successfully verified your seed phrase. Remember to keep it in a safe place, as it\'s the only way to recover your wallet if you lose access to your account.'**
  String get seedPhraseVerifiedMessage;

  /// No description provided for @iUnderstand.
  ///
  /// In en, this message translates to:
  /// **'I understand'**
  String get iUnderstand;

  /// No description provided for @walletSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'ve successfully created your wallet.'**
  String get walletSuccessTitle;

  /// No description provided for @importWalletSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'You\'ve successfully imported your wallet.'**
  String get importWalletSuccessTitle;

  /// No description provided for @walletSuccessSecurity.
  ///
  /// In en, this message translates to:
  /// **'Remember to keep your seed phrase safe, it\'s your responsibility!'**
  String get walletSuccessSecurity;

  /// No description provided for @walletSuccessInfo.
  ///
  /// In en, this message translates to:
  /// **'NemorixPay cannot recover your wallet if you lose it. You can find your seed phrase in Settings > Security & Privacy.'**
  String get walletSuccessInfo;

  /// No description provided for @goToHomePage.
  ///
  /// In en, this message translates to:
  /// **'Go to Home Page'**
  String get goToHomePage;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @myAssets.
  ///
  /// In en, this message translates to:
  /// **'My Assets'**
  String get myAssets;

  /// No description provided for @seeAll.
  ///
  /// In en, this message translates to:
  /// **'See All'**
  String get seeAll;

  /// No description provided for @livePrices.
  ///
  /// In en, this message translates to:
  /// **'Live Prices'**
  String get livePrices;

  /// No description provided for @currentWalletBalance.
  ///
  /// In en, this message translates to:
  /// **'Current Wallet Balance'**
  String get currentWalletBalance;

  /// No description provided for @deposit.
  ///
  /// In en, this message translates to:
  /// **'Deposit'**
  String get deposit;

  /// No description provided for @withdraw.
  ///
  /// In en, this message translates to:
  /// **'Withdraw'**
  String get withdraw;

  /// No description provided for @send.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get send;

  /// No description provided for @receive.
  ///
  /// In en, this message translates to:
  /// **'Receive'**
  String get receive;

  /// No description provided for @sell.
  ///
  /// In en, this message translates to:
  /// **'Sell'**
  String get sell;

  /// No description provided for @buy.
  ///
  /// In en, this message translates to:
  /// **'Buy'**
  String get buy;

  /// No description provided for @marketCap.
  ///
  /// In en, this message translates to:
  /// **'Market Cap'**
  String get marketCap;

  /// No description provided for @volume.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get volume;

  /// No description provided for @circulatingSupply.
  ///
  /// In en, this message translates to:
  /// **'Circulating Supply'**
  String get circulatingSupply;

  /// No description provided for @totalSupply.
  ///
  /// In en, this message translates to:
  /// **'Total Supply'**
  String get totalSupply;

  /// No description provided for @allTimeHigh.
  ///
  /// In en, this message translates to:
  /// **'All Time High'**
  String get allTimeHigh;

  /// No description provided for @performance.
  ///
  /// In en, this message translates to:
  /// **'Performance'**
  String get performance;

  /// No description provided for @youPay.
  ///
  /// In en, this message translates to:
  /// **'You Pay'**
  String get youPay;

  /// No description provided for @youReceive.
  ///
  /// In en, this message translates to:
  /// **'You Receive'**
  String get youReceive;

  /// No description provided for @exchangeFee.
  ///
  /// In en, this message translates to:
  /// **'Exchange fee'**
  String get exchangeFee;

  /// No description provided for @clickHereFor.
  ///
  /// In en, this message translates to:
  /// **'Click here for '**
  String get clickHereFor;

  /// No description provided for @termsAndConditions.
  ///
  /// In en, this message translates to:
  /// **'Terms & Conditions.'**
  String get termsAndConditions;

  /// No description provided for @transactionFeeTaken.
  ///
  /// In en, this message translates to:
  /// **'For this transaction fee will be taken.'**
  String get transactionFeeTaken;

  /// No description provided for @continueLabel.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueLabel;

  /// No description provided for @personalInformation.
  ///
  /// In en, this message translates to:
  /// **'Personal Information'**
  String get personalInformation;

  /// No description provided for @enterYourPersonalInfo.
  ///
  /// In en, this message translates to:
  /// **'Please enter your personal information'**
  String get enterYourPersonalInfo;

  /// No description provided for @accountInformation.
  ///
  /// In en, this message translates to:
  /// **'Account Information'**
  String get accountInformation;

  /// No description provided for @enterYourAccountInfo.
  ///
  /// In en, this message translates to:
  /// **'Please enter your account information'**
  String get enterYourAccountInfo;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @enterYourSecurityInfo.
  ///
  /// In en, this message translates to:
  /// **'Please enter a security word that you can remember in case you lose access to your NemorixPay account.'**
  String get enterYourSecurityInfo;

  /// No description provided for @loginCredentials.
  ///
  /// In en, this message translates to:
  /// **'Login Credentials'**
  String get loginCredentials;

  /// No description provided for @enterYourLoginInfo.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email and password to access your account'**
  String get enterYourLoginInfo;

  /// No description provided for @loginOptions.
  ///
  /// In en, this message translates to:
  /// **'Login Options'**
  String get loginOptions;

  /// No description provided for @chooseYourLoginMethod.
  ///
  /// In en, this message translates to:
  /// **'Choose how you want to access your account'**
  String get chooseYourLoginMethod;

  /// No description provided for @invalidAmountFormat.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid amount'**
  String get invalidAmountFormat;

  /// No description provided for @minimumAmount.
  ///
  /// In en, this message translates to:
  /// **'Minimum amount is \$1'**
  String get minimumAmount;

  /// No description provided for @maximumAmount.
  ///
  /// In en, this message translates to:
  /// **'Maximum daily amount is \$10,000'**
  String get maximumAmount;

  /// No description provided for @commissionBelowMinimum.
  ///
  /// In en, this message translates to:
  /// **'Commission rate is below minimum allowed (0.05%)'**
  String get commissionBelowMinimum;

  /// No description provided for @commissionAboveMaximum.
  ///
  /// In en, this message translates to:
  /// **'Commission rate exceeds maximum allowed (1.0%)'**
  String get commissionAboveMaximum;

  /// No description provided for @commissionExceedsLimit.
  ///
  /// In en, this message translates to:
  /// **'Commission amount exceeds maximum limit (\$50)'**
  String get commissionExceedsLimit;

  /// No description provided for @totalAmount.
  ///
  /// In en, this message translates to:
  /// **'Total Amount'**
  String get totalAmount;

  /// No description provided for @continueText.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueText;

  /// No description provided for @noPaymentMethodSelected.
  ///
  /// In en, this message translates to:
  /// **'Please select a payment method'**
  String get noPaymentMethodSelected;

  /// No description provided for @invalidCardSelected.
  ///
  /// In en, this message translates to:
  /// **'Please select a valid card'**
  String get invalidCardSelected;

  /// No description provided for @cardExpired.
  ///
  /// In en, this message translates to:
  /// **'The selected card has expired'**
  String get cardExpired;

  /// No description provided for @walletSetupTitle.
  ///
  /// In en, this message translates to:
  /// **'Wallet Setup'**
  String get walletSetupTitle;

  /// No description provided for @walletSetupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Import an existing wallet or create a new one'**
  String get walletSetupSubtitle;

  /// No description provided for @importUsingSeedPhrase.
  ///
  /// In en, this message translates to:
  /// **'Import Using Seed Phrase'**
  String get importUsingSeedPhrase;

  /// No description provided for @creatingSeedPhrase.
  ///
  /// In en, this message translates to:
  /// **'Creating Seed Phrase..'**
  String get creatingSeedPhrase;

  /// No description provided for @creatingNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Creating a New Wallet..'**
  String get creatingNewAccount;

  /// No description provided for @createNewAccount.
  ///
  /// In en, this message translates to:
  /// **'Create a New Account'**
  String get createNewAccount;

  /// No description provided for @importSeedPhraseInstructions.
  ///
  /// In en, this message translates to:
  /// **'Enter Your Seed Phrase (12 or 24 words). NemorixPay will not store your mnemonic phrases.'**
  String get importSeedPhraseInstructions;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @writeDownSeedPhraseTitle.
  ///
  /// In en, this message translates to:
  /// **'Write Down Your Seed Phrase'**
  String get writeDownSeedPhraseTitle;

  /// No description provided for @writeDownSeedPhraseInstructions.
  ///
  /// In en, this message translates to:
  /// **'This is your seed phrase. Write it down on a paper and keep it in a safe place. You will be asked to re-enter this phrase (in order) on the next step.'**
  String get writeDownSeedPhraseInstructions;

  /// No description provided for @importStellarAccountTitle.
  ///
  /// In en, this message translates to:
  /// **'Import Your Stellar Account'**
  String get importStellarAccountTitle;

  /// No description provided for @importingWallet.
  ///
  /// In en, this message translates to:
  /// **'Importing Wallet...'**
  String get importingWallet;

  /// No description provided for @seedPhraseTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Seed Phrase Type'**
  String get seedPhraseTypeLabel;

  /// No description provided for @seedPhraseLabel.
  ///
  /// In en, this message translates to:
  /// **'Seed Phrase'**
  String get seedPhraseLabel;

  /// No description provided for @confirmSeedPhraseTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Seed Phrase'**
  String get confirmSeedPhraseTitle;

  /// No description provided for @confirmSeedPhraseInstructions.
  ///
  /// In en, this message translates to:
  /// **'Select each word in the order it was presented to you.'**
  String get confirmSeedPhraseInstructions;

  /// No description provided for @confirmSeedPhraseError.
  ///
  /// In en, this message translates to:
  /// **'Incorrect word. Please check your seed phrase and make sure you wrote down all the words in the correct order. If you make a mistake, you may lose access to your account.'**
  String get confirmSeedPhraseError;

  /// No description provided for @confirmSeedPhraseSuccess.
  ///
  /// In en, this message translates to:
  /// **'Correct! Now confirm a second word from your seed phrase.'**
  String get confirmSeedPhraseSuccess;

  /// No description provided for @authErrorUserNotFound.
  ///
  /// In en, this message translates to:
  /// **'No account found with this email.'**
  String get authErrorUserNotFound;

  /// No description provided for @authErrorWrongPassword.
  ///
  /// In en, this message translates to:
  /// **'Incorrect password.'**
  String get authErrorWrongPassword;

  /// No description provided for @authErrorInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format.'**
  String get authErrorInvalidEmail;

  /// No description provided for @authErrorUserDisabled.
  ///
  /// In en, this message translates to:
  /// **'This account has been disabled.'**
  String get authErrorUserDisabled;

  /// No description provided for @authErrorEmailAlreadyInUse.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with this email.'**
  String get authErrorEmailAlreadyInUse;

  /// No description provided for @authErrorWeakPassword.
  ///
  /// In en, this message translates to:
  /// **'Password is too weak.'**
  String get authErrorWeakPassword;

  /// No description provided for @authErrorOperationNotAllowed.
  ///
  /// In en, this message translates to:
  /// **'This operation is not allowed.'**
  String get authErrorOperationNotAllowed;

  /// No description provided for @authErrorTooManyRequests.
  ///
  /// In en, this message translates to:
  /// **'Too many failed attempts. Please try again later.'**
  String get authErrorTooManyRequests;

  /// No description provided for @authErrorNetworkRequestFailed.
  ///
  /// In en, this message translates to:
  /// **'Connection error. Please check your internet connection.'**
  String get authErrorNetworkRequestFailed;

  /// No description provided for @authErrorRequiresRecentLogin.
  ///
  /// In en, this message translates to:
  /// **'Please sign in again to perform this action.'**
  String get authErrorRequiresRecentLogin;

  /// No description provided for @authErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again.'**
  String get authErrorUnknown;

  /// No description provided for @authErrorInvalidCredential.
  ///
  /// In en, this message translates to:
  /// **'Invalid credentials.'**
  String get authErrorInvalidCredential;

  /// No description provided for @authErrorAccountExistsWithDifferentCredential.
  ///
  /// In en, this message translates to:
  /// **'An account already exists with these credentials.'**
  String get authErrorAccountExistsWithDifferentCredential;

  /// No description provided for @authErrorInvalidVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification code.'**
  String get authErrorInvalidVerificationCode;

  /// No description provided for @authErrorInvalidVerificationId.
  ///
  /// In en, this message translates to:
  /// **'Invalid verification ID.'**
  String get authErrorInvalidVerificationId;

  /// No description provided for @authErrorMissingVerificationCode.
  ///
  /// In en, this message translates to:
  /// **'Missing verification code.'**
  String get authErrorMissingVerificationCode;

  /// No description provided for @authErrorMissingVerificationId.
  ///
  /// In en, this message translates to:
  /// **'Missing verification ID.'**
  String get authErrorMissingVerificationId;

  /// No description provided for @stellarErrorAccountNotFound.
  ///
  /// In en, this message translates to:
  /// **'Stellar account not found'**
  String get stellarErrorAccountNotFound;

  /// No description provided for @stellarErrorAccountExists.
  ///
  /// In en, this message translates to:
  /// **'Stellar account already exists'**
  String get stellarErrorAccountExists;

  /// No description provided for @stellarErrorInvalidAccount.
  ///
  /// In en, this message translates to:
  /// **'Invalid Stellar account'**
  String get stellarErrorInvalidAccount;

  /// No description provided for @stellarErrorInsufficientBalance.
  ///
  /// In en, this message translates to:
  /// **'Insufficient balance in Stellar account'**
  String get stellarErrorInsufficientBalance;

  /// No description provided for @stellarErrorTransactionFailed.
  ///
  /// In en, this message translates to:
  /// **'Stellar transaction failed'**
  String get stellarErrorTransactionFailed;

  /// No description provided for @stellarErrorInvalidTransaction.
  ///
  /// In en, this message translates to:
  /// **'Invalid Stellar transaction'**
  String get stellarErrorInvalidTransaction;

  /// No description provided for @stellarErrorTransactionExpired.
  ///
  /// In en, this message translates to:
  /// **'Stellar transaction expired'**
  String get stellarErrorTransactionExpired;

  /// No description provided for @stellarErrorInvalidAmount.
  ///
  /// In en, this message translates to:
  /// **'Invalid amount for Stellar transaction'**
  String get stellarErrorInvalidAmount;

  /// No description provided for @stellarErrorNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Stellar network error'**
  String get stellarErrorNetworkError;

  /// No description provided for @stellarErrorServerError.
  ///
  /// In en, this message translates to:
  /// **'Stellar server error'**
  String get stellarErrorServerError;

  /// No description provided for @stellarErrorTimeoutError.
  ///
  /// In en, this message translates to:
  /// **'Stellar request timed out'**
  String get stellarErrorTimeoutError;

  /// No description provided for @stellarErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown Stellar error'**
  String get stellarErrorUnknown;

  /// No description provided for @stellarErrorInvalidOperation.
  ///
  /// In en, this message translates to:
  /// **'Invalid Stellar operation'**
  String get stellarErrorInvalidOperation;

  /// No description provided for @stellarErrorInvalidMnemonic.
  ///
  /// In en, this message translates to:
  /// **'Invalid Stellar mnemonic phrase'**
  String get stellarErrorInvalidMnemonic;

  /// No description provided for @stellarErrorInvalidSecretKey.
  ///
  /// In en, this message translates to:
  /// **'Invalid Stellar secret key'**
  String get stellarErrorInvalidSecretKey;

  /// No description provided for @stellarErrorInvalidPublicKey.
  ///
  /// In en, this message translates to:
  /// **'Invalid public key'**
  String get stellarErrorInvalidPublicKey;

  /// No description provided for @stellarErrorInvalidMemo.
  ///
  /// In en, this message translates to:
  /// **'Memo cannot be longer than 28 characters'**
  String get stellarErrorInvalidMemo;

  /// No description provided for @stellarErrorAccountNotInitialized.
  ///
  /// In en, this message translates to:
  /// **'No Stellar account has been initialized'**
  String get stellarErrorAccountNotInitialized;

  /// No description provided for @walletErrorCreationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to create wallet. Please try again.'**
  String get walletErrorCreationFailed;

  /// No description provided for @walletErrorInvalidMnemonic.
  ///
  /// In en, this message translates to:
  /// **'Invalid mnemonic phrase. Please check and try again.'**
  String get walletErrorInvalidMnemonic;

  /// No description provided for @walletErrorMnemonicGenerationFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to generate mnemonic phrase. Please try again.'**
  String get walletErrorMnemonicGenerationFailed;

  /// No description provided for @walletErrorImportFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to import wallet. Please check your mnemonic and try again.'**
  String get walletErrorImportFailed;

  /// No description provided for @walletErrorInvalidSecretKey.
  ///
  /// In en, this message translates to:
  /// **'Invalid secret key. Please check and try again.'**
  String get walletErrorInvalidSecretKey;

  /// No description provided for @walletErrorBalanceRetrievalFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to retrieve wallet balance. Please try again.'**
  String get walletErrorBalanceRetrievalFailed;

  /// No description provided for @walletErrorInsufficientFunds.
  ///
  /// In en, this message translates to:
  /// **'Insufficient funds to complete the transaction.'**
  String get walletErrorInsufficientFunds;

  /// No description provided for @walletErrorAccountNotFound.
  ///
  /// In en, this message translates to:
  /// **'Wallet account not found. Please check your credentials.'**
  String get walletErrorAccountNotFound;

  /// No description provided for @walletErrorNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Network error. Please check your connection and try again.'**
  String get walletErrorNetworkError;

  /// No description provided for @walletErrorTimeoutError.
  ///
  /// In en, this message translates to:
  /// **'Request timed out. Please try again.'**
  String get walletErrorTimeoutError;

  /// No description provided for @walletErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unknown error occurred. Please try again.'**
  String get walletErrorUnknown;

  /// No description provided for @assetErrorPriceUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update asset price'**
  String get assetErrorPriceUpdateFailed;

  /// No description provided for @assetErrorInvalidPriceData.
  ///
  /// In en, this message translates to:
  /// **'Invalid price data received'**
  String get assetErrorInvalidPriceData;

  /// No description provided for @assetErrorPriceHistoryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Price history not found for this asset'**
  String get assetErrorPriceHistoryNotFound;

  /// No description provided for @assetErrorNetworkError.
  ///
  /// In en, this message translates to:
  /// **'Network error while fetching asset data'**
  String get assetErrorNetworkError;

  /// No description provided for @assetErrorTimeoutError.
  ///
  /// In en, this message translates to:
  /// **'Request timed out while fetching asset data'**
  String get assetErrorTimeoutError;

  /// No description provided for @assetErrorInvalidSymbol.
  ///
  /// In en, this message translates to:
  /// **'Invalid asset symbol'**
  String get assetErrorInvalidSymbol;

  /// No description provided for @assetErrorDataParsingError.
  ///
  /// In en, this message translates to:
  /// **'Error parsing asset data'**
  String get assetErrorDataParsingError;

  /// No description provided for @assetErrorUnknown.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred with the asset'**
  String get assetErrorUnknown;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'es'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'es': return AppLocalizationsEs();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
