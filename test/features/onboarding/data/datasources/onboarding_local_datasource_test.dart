import 'package:flutter_test/flutter_test.dart';
import 'package:nemorixpay/features/onboarding/data/datasources/onboarding_local_datasource_impl.dart';
import 'package:nemorixpay/features/onboarding/data/models/onboarding_model.dart';
import 'mocks/mock_shared_preferences.dart';

void main() {
  late OnboardingLocalDatasourceImpl datasource;
  late MockSharedPreferences mockPrefs;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    datasource = OnboardingLocalDatasourceImpl(mockPrefs);
  });

  group('saveLanguage', () {
    const tLanguage = 'en';

    test('should save language successfully', () async {
      // act
      final result = await datasource.saveLanguage(tLanguage);
      // assert
      expect(result, true);
      expect(mockPrefs.getString('language'), tLanguage);
    });
  });

  group('getLanguage', () {
    test('should return language when it exists', () async {
      // arrange
      const tLanguage = 'es';
      await mockPrefs.setString('language', tLanguage);
      // act
      final result = await datasource.getLanguage();
      // assert
      expect(result, tLanguage);
    });

    test('should return null when language does not exist', () async {
      // act
      final result = await datasource.getLanguage();
      // assert
      expect(result, null);
    });
  });

  group('completeOnboarding', () {
    test('should mark onboarding as completed', () async {
      // act
      final result = await datasource.completeOnboarding();
      // assert
      expect(result, true);
      expect(mockPrefs.getBool('onboarding_completed'), true);
    });
  });

  group('isOnboardingCompleted', () {
    test('should return true when onboarding is completed', () async {
      // arrange
      await mockPrefs.setBool('onboarding_completed', true);
      // act
      final result = await datasource.isOnboardingCompleted();
      // assert
      expect(result, true);
    });

    test('should return false when onboarding is not completed', () async {
      // arrange
      await mockPrefs.setBool('onboarding_completed', false);
      // act
      final result = await datasource.isOnboardingCompleted();
      // assert
      expect(result, false);
    });

    test('should return false when onboarding status is null', () async {
      // act
      final result = await datasource.isOnboardingCompleted();
      // assert
      expect(result, false);
    });
  });

  group('getOnboardingData', () {
    test('should return OnboardingModel with correct data', () async {
      // arrange
      const tLanguage = 'es';
      const tIsCompleted = true;
      const tHasWallet = false;
      await mockPrefs.setString('language', tLanguage);
      await mockPrefs.setBool('onboarding_completed', tIsCompleted);
      await mockPrefs.setBool('has_wallet', tHasWallet);
      // act
      final result = await datasource.getOnboardingData();
      // assert
      expect(
        result,
        OnboardingModel(
          language: tLanguage,
          isCompleted: tIsCompleted,
          hasWallet: tHasWallet,
        ),
      );
    });

    test('should return default OnboardingModel when data is null', () async {
      // act
      final result = await datasource.getOnboardingData();
      // assert
      expect(
        result,
        OnboardingModel(language: 'en', isCompleted: false, hasWallet: false),
      );
    });
  });

  group('saveOnboardingData', () {
    test('should save OnboardingModel data successfully', () async {
      // arrange
      final tModel = OnboardingModel(
        language: 'es',
        isCompleted: true,
        hasWallet: false,
      );
      // act
      await datasource.saveOnboardingData(tModel);
      // assert
      expect(mockPrefs.getString('language'), tModel.language);
      expect(mockPrefs.getBool('onboarding_completed'), tModel.isCompleted);
      expect(mockPrefs.getBool('has_wallet'), tModel.hasWallet);
    });
  });
}
