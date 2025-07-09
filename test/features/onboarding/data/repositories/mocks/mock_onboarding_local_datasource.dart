import 'package:nemorixpay/features/onboarding/data/datasources/onboarding_local_datasource.dart';
import 'package:nemorixpay/features/onboarding/data/models/onboarding_model.dart';

class MockOnboardingLocalDatasource implements OnboardingLocalDatasource {
  String? _language;
  bool _isCompleted = false;
  bool _hasWallet = false;
  bool _shouldThrow = false;
  String? _errorMessage;

  void setShouldThrow(bool value, {String? message}) {
    _shouldThrow = value;
    _errorMessage = message;
  }

  void _checkForError() {
    if (_shouldThrow) {
      throw Exception(_errorMessage ?? 'Mock error');
    }
  }

  @override
  Future<bool> saveLanguage(String language) async {
    _checkForError();
    _language = language;
    return true;
  }

  @override
  Future<String?> getLanguage() async {
    _checkForError();
    return _language;
  }

  @override
  Future<bool> completeOnboarding() async {
    _checkForError();
    _isCompleted = true;
    return true;
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    _checkForError();
    return _isCompleted;
  }

  Future<OnboardingModel> getOnboardingData() async {
    _checkForError();
    return OnboardingModel(
      language: _language ?? 'en',
      isCompleted: _isCompleted,
      hasWallet: _hasWallet,
    );
  }

  Future<void> saveOnboardingData(OnboardingModel data) async {
    _checkForError();
    _language = data.language;
    _isCompleted = data.isCompleted;
    _hasWallet = data.hasWallet;
  }

  @override
  Future<bool> resetOnboarding() {
    // TODO: implement resetOnboarding
    throw UnimplementedError();
  }
}
