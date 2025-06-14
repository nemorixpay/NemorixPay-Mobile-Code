import 'package:flutter/services.dart';

/// @file        terms_local_datasource.dart
/// @brief       Local datasource for Terms and Conditions content.
/// @details     Provides access to the terms and conditions text stored locally in the app assets.
/// @author      Miguel Fagundez
/// @date        06/13/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class TermsLocalDatasource {
  Future<String> getTermsContent() async {
    // For now, returns a static string. In the future, load from assets or API.
    return await rootBundle.loadString('assets/terms/terms_en.txt');
  }
}
