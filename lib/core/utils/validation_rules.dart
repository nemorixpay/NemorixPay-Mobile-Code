/// @file        validation_rules.dart
/// @brief       Base class to implement some validation rules within the app.
/// @details
/// @author      Miguel Fagundez
/// @date        04/09/2025
/// @version     1.0
/// @copyright   Apache 2.0 License
class ValidationRules {
  static final emailValidation = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
}
