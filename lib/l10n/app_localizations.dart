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

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'It is loading'**
  String get loading;

  /// No description provided for @featureNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'This feature has not been fully implemented'**
  String get featureNotImplemented;

  /// No description provided for @testingPurposes.
  ///
  /// In en, this message translates to:
  /// **'Testing Purposes'**
  String get testingPurposes;

  /// No description provided for @showIndividualScreens.
  ///
  /// In en, this message translates to:
  /// **'Show Individual Screens'**
  String get showIndividualScreens;

  /// No description provided for @deletePublicPrivateKeys.
  ///
  /// In en, this message translates to:
  /// **'Delete Public/Private Keys'**
  String get deletePublicPrivateKeys;

  /// No description provided for @deleteTermsOfServices.
  ///
  /// In en, this message translates to:
  /// **'Delete Terms of Services'**
  String get deleteTermsOfServices;

  /// No description provided for @deleteOnboardingSteps.
  ///
  /// In en, this message translates to:
  /// **'Delete Onboarding Steps'**
  String get deleteOnboardingSteps;

  /// No description provided for @allKeysDeleted.
  ///
  /// In en, this message translates to:
  /// **'All keys were deleted - Secure Storage'**
  String get allKeysDeleted;

  /// No description provided for @termsDeleted.
  ///
  /// In en, this message translates to:
  /// **'Terms were deleted - Internal Storage'**
  String get termsDeleted;

  /// No description provided for @onboardingReset.
  ///
  /// In en, this message translates to:
  /// **'Onboarding was reset - Internal Storage'**
  String get onboardingReset;

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

  /// No description provided for @googleSignInNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'Google Sign-In not implemented yet'**
  String get googleSignInNotImplemented;

  /// No description provided for @appleSignInNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'Apple Sign-In not implemented yet'**
  String get appleSignInNotImplemented;

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
  /// **'NemorixPay cannot recover your wallet if you lose it. You can find your security options in Settings > Security & Privacy.'**
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

  /// No description provided for @lastUpdateOnly.
  ///
  /// In en, this message translates to:
  /// **'Last update'**
  String get lastUpdateOnly;

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

  /// No description provided for @noAvailableData.
  ///
  /// In en, this message translates to:
  /// **'No available data. Try again!'**
  String get noAvailableData;

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

  /// No description provided for @walletErrorUserNotAuthenticated.
  ///
  /// In en, this message translates to:
  /// **'User not authenticated. Please sign in again.'**
  String get walletErrorUserNotAuthenticated;

  /// No description provided for @walletErrorCreationFailedGeneric.
  ///
  /// In en, this message translates to:
  /// **'Could not create wallet. Please try again.'**
  String get walletErrorCreationFailedGeneric;

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

  /// No description provided for @assetErrorAssetsListFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to get available assets'**
  String get assetErrorAssetsListFailed;

  /// No description provided for @assetErrorMarketDataNotFound.
  ///
  /// In en, this message translates to:
  /// **'Market data for this asset is currently unavailable'**
  String get assetErrorMarketDataNotFound;

  /// No description provided for @assetErrorDetailsNotFound.
  ///
  /// In en, this message translates to:
  /// **'Could not find detailed information for this asset'**
  String get assetErrorDetailsNotFound;

  /// No description provided for @assetErrorMarketDataUpdateFailed.
  ///
  /// In en, this message translates to:
  /// **'Failed to update market data. Please try again later.'**
  String get assetErrorMarketDataUpdateFailed;

  /// No description provided for @termsOfServices.
  ///
  /// In en, this message translates to:
  /// **'Terms of Services'**
  String get termsOfServices;

  /// No description provided for @lastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last update on June 2025'**
  String get lastUpdate;

  /// No description provided for @termsContent.
  ///
  /// In en, this message translates to:
  /// **'Welcome to NemorixPay. Please read these Terms of Services carefully before using our application.'**
  String get termsContent;

  /// No description provided for @termsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get termsTitle;

  /// No description provided for @termsTitleTesting.
  ///
  /// In en, this message translates to:
  /// **'Terms (Testing purposes)'**
  String get termsTitleTesting;

  /// No description provided for @termsAndConditionsContent.
  ///
  /// In en, this message translates to:
  /// **'NEMORIXPAY TERMS AND CONDITIONS\n\nWelcome to NemorixPay. By using our application, you agree to these terms and conditions.\n\n1. SERVICE DESCRIPTION\nNemorixPay is a cryptocurrency wallet and payment application that allows users to store, send, and receive digital assets on the Stellar network.\n\n'**
  String get termsAndConditionsContent;

  /// No description provided for @termsLastUpdate.
  ///
  /// In en, this message translates to:
  /// **'Last updated: February 2025'**
  String get termsLastUpdate;

  /// No description provided for @termsBody.
  ///
  /// In en, this message translates to:
  /// **'USER RESPONSIBILITIES\n- You are responsible for maintaining the security of your wallet\n- Keep your private keys safe and never share them with anyone\n- Verify all transaction details before confirming\n- Report any suspicious activity immediately\n\n SECURITY\n- We implement industry-standard security measures\n- However, you are ultimately responsible for your wallet\'s security\n- We cannot recover lost private keys or stolen funds\n- Enable two-factor authentication when available\n\n TRANSACTIONS\n- All transactions are irreversible once confirmed on the blockchain\n- Verify recipient addresses carefully before sending\n- Network fees may apply and are non-refundable\n- Transaction times may vary based on network conditions\n\n PRIVACITY\n- We collect and process personal data as described in our Privacy Policy\n- Your data is protected using encryption and secure protocols\n- We do not sell your personal information to third parties\n- You can request data deletion at any time\n\n LIMITATIONS OF LIABILITY\n- We are not liable for losses due to user error or negligence\n- We do not guarantee uninterrupted service availability\n- Maximum liability is limited to the amount of fees paid\n- We are not responsible for third-party service disruptions\n\n INTELLECTUAL PROPERTY\n- NemorixPay and its content are protected by copyright\n- You may not copy, modify, or distribute our software without permission\n- All trademarks and logos belong to their respective owners\n\n GOVERNING LAW\n- These terms are governed by applicable laws\n- Disputes will be resolved through arbitration\n- Changes to terms will be communicated via the app\n'**
  String get termsBody;

  /// No description provided for @licenseTitle.
  ///
  /// In en, this message translates to:
  /// **'Use License and Contact Details'**
  String get licenseTitle;

  /// No description provided for @licenseBody.
  ///
  /// In en, this message translates to:
  /// **'@copyright: Apache 2.0 License\n\nCONTACT INFORMATION\nFor questions about these terms, contact us at:\nEmail: support@nemorixpay.com\nWebsite: www.nemorixpay.com\n\nLast updated: February 2025\nVersion: 1.0'**
  String get licenseBody;

  /// No description provided for @accept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get accept;

  /// No description provided for @decline.
  ///
  /// In en, this message translates to:
  /// **'Decline'**
  String get decline;

  /// No description provided for @acceptTermsCheckbox.
  ///
  /// In en, this message translates to:
  /// **'I accept the terms and conditions'**
  String get acceptTermsCheckbox;

  /// No description provided for @confirmDeclineTerms.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to decline our terms of service?'**
  String get confirmDeclineTerms;

  /// No description provided for @yesDecline.
  ///
  /// In en, this message translates to:
  /// **'Yes, decline'**
  String get yesDecline;

  /// No description provided for @noContinue.
  ///
  /// In en, this message translates to:
  /// **'No, continue'**
  String get noContinue;

  /// No description provided for @loremIpsumTitle.
  ///
  /// In en, this message translates to:
  /// **'Lorem Ipsum'**
  String get loremIpsumTitle;

  /// No description provided for @loremIpsumContent.
  ///
  /// In en, this message translates to:
  /// **'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'**
  String get loremIpsumContent;

  /// No description provided for @onboarding_security_title.
  ///
  /// In en, this message translates to:
  /// **'Your Security is Our Priority'**
  String get onboarding_security_title;

  /// No description provided for @onboarding_security_subtitle.
  ///
  /// In en, this message translates to:
  /// **'We protect your funds and personal data'**
  String get onboarding_security_subtitle;

  /// No description provided for @onboarding_security_feature_biometric_title.
  ///
  /// In en, this message translates to:
  /// **'Biometric Authentication'**
  String get onboarding_security_feature_biometric_title;

  /// No description provided for @onboarding_security_feature_biometric_desc.
  ///
  /// In en, this message translates to:
  /// **'Access securely with your fingerprint'**
  String get onboarding_security_feature_biometric_desc;

  /// No description provided for @onboarding_security_feature_encryption_title.
  ///
  /// In en, this message translates to:
  /// **'End-to-End Encryption'**
  String get onboarding_security_feature_encryption_title;

  /// No description provided for @onboarding_security_feature_encryption_desc.
  ///
  /// In en, this message translates to:
  /// **'Your data is always protected'**
  String get onboarding_security_feature_encryption_desc;

  /// No description provided for @onboarding_security_feature_monitoring_title.
  ///
  /// In en, this message translates to:
  /// **'24/7 Monitoring'**
  String get onboarding_security_feature_monitoring_title;

  /// No description provided for @onboarding_security_feature_monitoring_desc.
  ///
  /// In en, this message translates to:
  /// **'Constant surveillance of your transactions'**
  String get onboarding_security_feature_monitoring_desc;

  /// No description provided for @onboarding_button_skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboarding_button_skip;

  /// No description provided for @onboarding_button_next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboarding_button_next;

  /// No description provided for @onboarding_button_back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get onboarding_button_back;

  /// No description provided for @onboarding_features_title.
  ///
  /// In en, this message translates to:
  /// **'Everything You Need in One Place'**
  String get onboarding_features_title;

  /// No description provided for @onboarding_features_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your cryptocurrencies easily'**
  String get onboarding_features_subtitle;

  /// No description provided for @onboarding_features_trading_title.
  ///
  /// In en, this message translates to:
  /// **'Instant Trading'**
  String get onboarding_features_trading_title;

  /// No description provided for @onboarding_features_trading_desc.
  ///
  /// In en, this message translates to:
  /// **'Trade cryptocurrencies quickly and securely'**
  String get onboarding_features_trading_desc;

  /// No description provided for @onboarding_features_monitoring_title.
  ///
  /// In en, this message translates to:
  /// **'Real-Time Monitoring'**
  String get onboarding_features_monitoring_title;

  /// No description provided for @onboarding_features_monitoring_desc.
  ///
  /// In en, this message translates to:
  /// **'Track market prices instantly'**
  String get onboarding_features_monitoring_desc;

  /// No description provided for @onboarding_features_history_title.
  ///
  /// In en, this message translates to:
  /// **'Transaction History'**
  String get onboarding_features_history_title;

  /// No description provided for @onboarding_features_history_desc.
  ///
  /// In en, this message translates to:
  /// **'Access your complete operation history'**
  String get onboarding_features_history_desc;

  /// No description provided for @onboarding_features_notifications_title.
  ///
  /// In en, this message translates to:
  /// **'Market Notifications'**
  String get onboarding_features_notifications_title;

  /// No description provided for @onboarding_features_notifications_desc.
  ///
  /// In en, this message translates to:
  /// **'Receive alerts about important movements'**
  String get onboarding_features_notifications_desc;

  /// No description provided for @onboarding_features_wallets_title.
  ///
  /// In en, this message translates to:
  /// **'Multiple Wallets'**
  String get onboarding_features_wallets_title;

  /// No description provided for @onboarding_features_wallets_desc.
  ///
  /// In en, this message translates to:
  /// **'Manage all your wallets in one place'**
  String get onboarding_features_wallets_desc;

  /// No description provided for @onboarding_benefits_title.
  ///
  /// In en, this message translates to:
  /// **'The Best Crypto Experience'**
  String get onboarding_benefits_title;

  /// No description provided for @onboarding_benefits_subtitle.
  ///
  /// In en, this message translates to:
  /// **'Enjoy exclusive advantages'**
  String get onboarding_benefits_subtitle;

  /// No description provided for @onboarding_benefits_fees_title.
  ///
  /// In en, this message translates to:
  /// **'Competitive Fees'**
  String get onboarding_benefits_fees_title;

  /// No description provided for @onboarding_benefits_fees_desc.
  ///
  /// In en, this message translates to:
  /// **'The lowest fees in the market'**
  String get onboarding_benefits_fees_desc;

  /// No description provided for @onboarding_benefits_support_title.
  ///
  /// In en, this message translates to:
  /// **'24/7 Support'**
  String get onboarding_benefits_support_title;

  /// No description provided for @onboarding_benefits_support_desc.
  ///
  /// In en, this message translates to:
  /// **'Technical support available at all times'**
  String get onboarding_benefits_support_desc;

  /// No description provided for @onboarding_benefits_ui_title.
  ///
  /// In en, this message translates to:
  /// **'Intuitive Interface'**
  String get onboarding_benefits_ui_title;

  /// No description provided for @onboarding_benefits_ui_desc.
  ///
  /// In en, this message translates to:
  /// **'Easy to use and understand design'**
  String get onboarding_benefits_ui_desc;

  /// No description provided for @onboarding_benefits_speed_title.
  ///
  /// In en, this message translates to:
  /// **'Instant Transactions'**
  String get onboarding_benefits_speed_title;

  /// No description provided for @onboarding_benefits_speed_desc.
  ///
  /// In en, this message translates to:
  /// **'Fast and efficient operations'**
  String get onboarding_benefits_speed_desc;

  /// No description provided for @onboarding_benefits_coins_title.
  ///
  /// In en, this message translates to:
  /// **'Wide Selection'**
  String get onboarding_benefits_coins_title;

  /// No description provided for @onboarding_benefits_coins_desc.
  ///
  /// In en, this message translates to:
  /// **'Access to over 100 cryptocurrencies'**
  String get onboarding_benefits_coins_desc;

  /// Title for receive crypto page
  ///
  /// In en, this message translates to:
  /// **'Receive {cryptoName}'**
  String receiveCryptoTitle(String cryptoName);

  /// No description provided for @scanQrCodeText.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR code to get Receive address'**
  String get scanQrCodeText;

  /// No description provided for @orDividerText.
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get orDividerText;

  /// Label for the crypto address field
  ///
  /// In en, this message translates to:
  /// **'Your {cryptoName} Address'**
  String yourCryptoAddress(String cryptoName);

  /// No description provided for @blockTimeInfo.
  ///
  /// In en, this message translates to:
  /// **'* Block/Time will be calculated after the transaction is generated and broadcasted'**
  String get blockTimeInfo;

  /// No description provided for @copyAddressButton.
  ///
  /// In en, this message translates to:
  /// **'Copy Address'**
  String get copyAddressButton;

  /// No description provided for @shareAddressButton.
  ///
  /// In en, this message translates to:
  /// **'Share Address'**
  String get shareAddressButton;

  /// No description provided for @addressCopiedMessage.
  ///
  /// In en, this message translates to:
  /// **'Address copied to clipboard!'**
  String get addressCopiedMessage;

  /// Title for send crypto page
  ///
  /// In en, this message translates to:
  /// **'Send {cryptoName}'**
  String sendCryptoTitle(String cryptoName);

  /// No description provided for @enterAddress.
  ///
  /// In en, this message translates to:
  /// **'Enter Address'**
  String get enterAddress;

  /// No description provided for @recipientAddress.
  ///
  /// In en, this message translates to:
  /// **'Recipient address'**
  String get recipientAddress;

  /// No description provided for @invalidAddress.
  ///
  /// In en, this message translates to:
  /// **'Invalid address'**
  String get invalidAddress;

  /// No description provided for @ownAddressError.
  ///
  /// In en, this message translates to:
  /// **'Cannot send to your own address'**
  String get ownAddressError;

  /// No description provided for @amount.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get amount;

  /// No description provided for @amountHint.
  ///
  /// In en, this message translates to:
  /// **'0.00'**
  String get amountHint;

  /// No description provided for @invalidAmount.
  ///
  /// In en, this message translates to:
  /// **'The amount exceeds your available balance'**
  String get invalidAmount;

  /// No description provided for @note.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get note;

  /// No description provided for @noteHint.
  ///
  /// In en, this message translates to:
  /// **'Optional note'**
  String get noteHint;

  /// Transaction Fees
  ///
  /// In en, this message translates to:
  /// **'Transaction fees: {fee} {cryptoName}'**
  String transactionFees(double fee, String cryptoName);

  /// Transaction Fees
  ///
  /// In en, this message translates to:
  /// **'Min: {min} {cryptoName} - Max: {max} {cryptoName}'**
  String sendCryptominMax(double min, double max, String cryptoName);

  /// No description provided for @availableBalance.
  ///
  /// In en, this message translates to:
  /// **'Available Balance'**
  String get availableBalance;

  /// Label for send button
  ///
  /// In en, this message translates to:
  /// **'Send {cryptoName}'**
  String sendButton(String cryptoName);

  /// No description provided for @qrNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'QR scanner not implemented yet.'**
  String get qrNotImplemented;

  /// No description provided for @sendNotImplemented.
  ///
  /// In en, this message translates to:
  /// **'Send option not implemented yet.'**
  String get sendNotImplemented;

  /// No description provided for @stellarLumens.
  ///
  /// In en, this message translates to:
  /// **'Stellar Lumens'**
  String get stellarLumens;

  /// No description provided for @transactionSent.
  ///
  /// In en, this message translates to:
  /// **'Transaction has been sent!'**
  String get transactionSent;

  /// No description provided for @transactionFailed.
  ///
  /// In en, this message translates to:
  /// **'Transaction has failed!'**
  String get transactionFailed;

  /// No description provided for @sendingTransaction.
  ///
  /// In en, this message translates to:
  /// **'Sending your transaction...'**
  String get sendingTransaction;

  /// No description provided for @transactionSuccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Transaction Successful!'**
  String get transactionSuccessTitle;

  /// Success message for completed transaction
  ///
  /// In en, this message translates to:
  /// **'Your {cryptoName} transaction has been successfully sent to the Stellar network. The transaction is now being processed and will be confirmed shortly.'**
  String transactionSuccessMessage(String cryptoName);

  /// Transaction hash information
  ///
  /// In en, this message translates to:
  /// **'Transaction Hash: {hash}'**
  String transactionHashInfo(String hash);

  /// No description provided for @transactionConfirmationNote.
  ///
  /// In en, this message translates to:
  /// **'You can use this hash to track your transaction on the Stellar network explorer.'**
  String get transactionConfirmationNote;

  /// No description provided for @memoLongErrorMessage.
  ///
  /// In en, this message translates to:
  /// **'Note cannot be longer than 28 characters'**
  String get memoLongErrorMessage;

  /// No description provided for @confirmTransactionTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirm Transaction'**
  String get confirmTransactionTitle;

  /// No description provided for @confirmTransactionCanceled.
  ///
  /// In en, this message translates to:
  /// **'Transaction canceled!'**
  String get confirmTransactionCanceled;

  /// No description provided for @confirmTransactionFees.
  ///
  /// In en, this message translates to:
  /// **'Transaction fees:'**
  String get confirmTransactionFees;

  /// No description provided for @transactionSummary.
  ///
  /// In en, this message translates to:
  /// **'Transaction Summary'**
  String get transactionSummary;

  /// No description provided for @transactionDetails.
  ///
  /// In en, this message translates to:
  /// **'Transaction Details'**
  String get transactionDetails;

  /// Button text for confirming and sending transaction
  ///
  /// In en, this message translates to:
  /// **'Confirm & Send {cryptoName}'**
  String confirmAndSend(String cryptoName);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home Page'**
  String get home;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @signOut.
  ///
  /// In en, this message translates to:
  /// **'Sign Out'**
  String get signOut;

  /// No description provided for @confirmSignOut.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to sign out?'**
  String get confirmSignOut;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @userProfile.
  ///
  /// In en, this message translates to:
  /// **'User Profile'**
  String get userProfile;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @myAccount.
  ///
  /// In en, this message translates to:
  /// **'My Account'**
  String get myAccount;

  /// No description provided for @billingPayment.
  ///
  /// In en, this message translates to:
  /// **'Billing/Payment'**
  String get billingPayment;

  /// No description provided for @faqSupport.
  ///
  /// In en, this message translates to:
  /// **'FAQ & Support'**
  String get faqSupport;

  /// No description provided for @setting.
  ///
  /// In en, this message translates to:
  /// **'Setting'**
  String get setting;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @paymentMethodTitle.
  ///
  /// In en, this message translates to:
  /// **'Payment Method'**
  String get paymentMethodTitle;

  /// No description provided for @creditCardLabel.
  ///
  /// In en, this message translates to:
  /// **'Credit Card'**
  String get creditCardLabel;

  /// No description provided for @addNewCardTitle.
  ///
  /// In en, this message translates to:
  /// **'Add New Card'**
  String get addNewCardTitle;

  /// No description provided for @cardNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardNumberLabel;

  /// No description provided for @cardHolderLabel.
  ///
  /// In en, this message translates to:
  /// **'Card Holder'**
  String get cardHolderLabel;

  /// No description provided for @expiryDateLabel.
  ///
  /// In en, this message translates to:
  /// **'Expiry Date'**
  String get expiryDateLabel;

  /// No description provided for @addButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get addButton;

  /// No description provided for @addNewCardButton.
  ///
  /// In en, this message translates to:
  /// **'+add new card'**
  String get addNewCardButton;

  /// No description provided for @googlePayLabel.
  ///
  /// In en, this message translates to:
  /// **'Google Pay'**
  String get googlePayLabel;

  /// No description provided for @applePayLabel.
  ///
  /// In en, this message translates to:
  /// **'Apple Pay'**
  String get applePayLabel;

  /// No description provided for @mobileBankingLabel.
  ///
  /// In en, this message translates to:
  /// **'Mobile Banking'**
  String get mobileBankingLabel;

  /// No description provided for @sendReceiptLabel.
  ///
  /// In en, this message translates to:
  /// **'Send receipt to your email'**
  String get sendReceiptLabel;
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
