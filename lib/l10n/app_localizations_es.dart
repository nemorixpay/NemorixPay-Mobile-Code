// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appName => 'NemorixPay';

  @override
  String get welcomeBack => 'Bienvenido de nuevo';

  @override
  String get youHaveBeenMissed => 'Te hemos extrañado';

  @override
  String get emailAddress => 'Correo Electrónico';

  @override
  String get emailIsRequired => 'El correo electrónico es requerido';

  @override
  String get enterValidEmail => 'Por favor, ingresa un correo electrónico válido';

  @override
  String get password => 'Contraseña';

  @override
  String get passwordIsRequired => 'La contraseña es requerida';

  @override
  String get passwordAtLeast6Characters => 'La contraseña debe tener al menos 6 caracteres';

  @override
  String get forgotPassword => '¿Olvidaste tu contraseña?';

  @override
  String get signIn => 'Iniciar Sesión';

  @override
  String get or => 'O';

  @override
  String get continueWithGoogle => 'Continuar con Google';

  @override
  String get continueWithApple => 'Continuar con Apple';

  @override
  String get dontHaveAnAccount => '¿No tienes una cuenta?';

  @override
  String get emailWasSent => 'Se ha enviado el correo de restablecimiento de contraseña. Por favor, revisa tu bandeja de entrada.';

  @override
  String get forgotPasswordTitle => 'Olvidé mi Contraseña';

  @override
  String get forgotPasswordSubtitle => 'Ingresa tu correo electrónico y te enviaremos instrucciones para restablecer tu contraseña.';

  @override
  String get sendEmail => 'Enviar Correo';

  @override
  String get signUp => 'Registrarse';

  @override
  String get onlyTakesAminute => 'Solo toma un minuto crear tu cuenta';

  @override
  String get firstNameRequired => 'El nombre es requerido';

  @override
  String get firstName => 'Nombre';

  @override
  String get lastNameRequired => 'El apellido es requerido';

  @override
  String get lastName => 'Apellido';

  @override
  String get confirmYourPassword => 'Confirma tu contraseña';

  @override
  String get passwordsDoNotMatch => 'Las contraseñas no coinciden';

  @override
  String get securityWordRequired => 'La palabra de seguridad es requerida';

  @override
  String get securityWord => 'Palabra de seguridad (para recuperación de cuenta)';

  @override
  String get birthdateRequired => 'La fecha de nacimiento es requerida';

  @override
  String get fillRegistrationData => 'Por favor completa todos los campos de registro para continuar';

  @override
  String get acceptTermsAndConditions => 'Por favor acepta los términos y condiciones';

  @override
  String get alreadyHaveAnAccount => '¿Ya tienes una cuenta? Inicia sesión';

  @override
  String get registrationSuccess => 'Tu cuenta ha sido creada exitosamente. Ahora puedes iniciar sesión con tus credenciales.';

  @override
  String get agreeToTerms => 'Acepto los términos y condiciones';

  @override
  String get verifyEmailTitle => 'Verifica tu Correo Electrónico';

  @override
  String get verifyEmailSubtitle => 'Te hemos enviado un correo de verificación. Por favor, revisa tu bandeja de entrada y haz clic en el enlace de verificación para activar tu cuenta.';

  @override
  String get resendVerificationEmail => 'Reenviar Correo de Verificación';

  @override
  String get verificationEmailSent => 'Se ha enviado el correo de verificación. Por favor, revisa tu bandeja de entrada.';

  @override
  String get iReceivedTheEmail => 'Ya recibí el correo';

  @override
  String get authErrorEmailNotVerified => 'Por favor, verifica tu correo electrónico antes de iniciar sesión.';

  @override
  String get verifyEmailMessage => 'Te hemos enviado un correo electrónico de verificación. Por favor, revisa tu bandeja de entrada y sigue las instrucciones para verificar tu cuenta.';

  @override
  String waitTimeMessage(int minutes) {
    return 'Tiempo de espera: $minutes minutos';
  }

  @override
  String get close => 'Cerrar';

  @override
  String get resendVerification => 'Reenviar verificación';

  @override
  String get seedPhraseVerifiedTitle => '¡Frase Semilla Verificada!';

  @override
  String get seedPhraseVerifiedMessage => 'Has verificado correctamente tu frase semilla. Recuerda guardarla en un lugar seguro, ya que es la única forma de recuperar tu wallet si pierdes acceso a tu cuenta.';

  @override
  String get iUnderstand => 'Entendido';

  @override
  String get walletSuccessTitle => 'Has creado tu wallet exitosamente.';

  @override
  String get importWalletSuccessTitle => 'Has importado tu wallet exitosamente.';

  @override
  String get walletSuccessSecurity => 'Recuerda mantener tu frase semilla segura, ¡es tu responsabilidad!';

  @override
  String get walletSuccessInfo => 'NemorixPay no puede recuperar tu wallet si la pierdes. Puedes encontrar tu frase semilla en Ajustes > Seguridad & Privacidad.';

  @override
  String get goToHomePage => 'Ir a la página principal';

  @override
  String get search => 'Buscar';

  @override
  String get myAssets => 'Mis Activos';

  @override
  String get seeAll => 'Ver Todo';

  @override
  String get livePrices => 'Precios en Tiempo Real';

  @override
  String get currentWalletBalance => 'Saldo Actual de la Cartera';

  @override
  String get deposit => 'Depositar';

  @override
  String get withdraw => 'Retirar';

  @override
  String get send => 'Enviar';

  @override
  String get receive => 'Recibir';

  @override
  String get sell => 'Vender';

  @override
  String get buy => 'Comprar';

  @override
  String get marketCap => 'Capitalización de Mercado';

  @override
  String get volume => 'Volumen';

  @override
  String get circulatingSupply => 'Suministro en Circulación';

  @override
  String get totalSupply => 'Suministro Total';

  @override
  String get allTimeHigh => 'Máximo Histórico';

  @override
  String get performance => 'Rendimiento';

  @override
  String get youPay => 'Tú Pagas';

  @override
  String get youReceive => 'Tú Recibes';

  @override
  String get exchangeFee => 'Comisión de cambio';

  @override
  String get clickHereFor => 'Haz clic aquí para ';

  @override
  String get termsAndConditions => 'Términos y Condiciones.';

  @override
  String get transactionFeeTaken => 'Para esta transacción se tomará una comisión.';

  @override
  String get continueLabel => 'Continuar';

  @override
  String get personalInformation => 'Información Personal';

  @override
  String get enterYourPersonalInfo => 'Por favor, ingresa tu información personal';

  @override
  String get accountInformation => 'Información de la Cuenta';

  @override
  String get enterYourAccountInfo => 'Por favor, ingresa tu información de cuenta';

  @override
  String get security => 'Seguridad';

  @override
  String get enterYourSecurityInfo => 'Por favor, ingresa una palabra de seguridad que puedas recordar en caso de perder acceso a tu cuenta en NemorixPay.';

  @override
  String get loginCredentials => 'Credenciales de Acceso';

  @override
  String get enterYourLoginInfo => 'Por favor, ingresa tu correo electrónico y contraseña para acceder a tu cuenta';

  @override
  String get loginOptions => 'Opciones de Acceso';

  @override
  String get chooseYourLoginMethod => 'Elige cómo quieres acceder a tu cuenta';

  @override
  String get invalidAmountFormat => 'Por favor, ingresa un monto valido';

  @override
  String get minimumAmount => 'El monto minimo es de \$1';

  @override
  String get maximumAmount => 'El monto máximo diario es de \$10,000';

  @override
  String get commissionBelowMinimum => 'La tasa de comisión está por debajo del mínimo permitido (0.05%)';

  @override
  String get commissionAboveMaximum => 'La tasa de comisión excede el máximo permitido (1.0%)';

  @override
  String get commissionExceedsLimit => 'El monto de la comisión excede el límite máximo (\$50)';

  @override
  String get totalAmount => 'Monto Total';

  @override
  String get continueText => 'Continuar';

  @override
  String get noPaymentMethodSelected => 'Por favor selecciona un método de pago';

  @override
  String get invalidCardSelected => 'Por favor selecciona una tarjeta válida';

  @override
  String get cardExpired => 'La tarjeta seleccionada ha expirado';

  @override
  String get walletSetupTitle => 'Configuración de Billetera';

  @override
  String get walletSetupSubtitle => 'Importa una billetera existente o crea una nueva';

  @override
  String get importUsingSeedPhrase => 'Importar Usando Frase Semilla';

  @override
  String get creatingSeedPhrase => 'Creando Frase Semilla..';

  @override
  String get creatingNewAccount => 'Creando Nueva Wallet..';

  @override
  String get createNewAccount => 'Crear Nueva Cuenta';

  @override
  String get importSeedPhraseInstructions => 'Introduce tu frase semilla (12 o 24 palabras). NemorixPay no almacenará tus frases mnemotécnicas.';

  @override
  String get next => 'Siguiente';

  @override
  String get writeDownSeedPhraseTitle => 'Anota tu frase semilla';

  @override
  String get writeDownSeedPhraseInstructions => 'Esta es tu frase semilla. Escríbela en un papel y guárdala en un lugar seguro. Se te pedirá que vuelvas a ingresar esta frase (en el mismo orden) en el siguiente paso.';

  @override
  String get importStellarAccountTitle => 'Importar tu cuenta Stellar';

  @override
  String get importingWallet => 'Importando Billetera...';

  @override
  String get seedPhraseTypeLabel => 'Tipo de frase semilla';

  @override
  String get seedPhraseLabel => 'Frase semilla';

  @override
  String get confirmSeedPhraseTitle => 'Confirma tu frase semilla';

  @override
  String get confirmSeedPhraseInstructions => 'Selecciona cada palabra en el orden en que te fue presentada.';

  @override
  String get confirmSeedPhraseError => 'Palabra incorrecta. Por favor, revisa tu frase semilla y asegúrate de haber anotado todas las palabras en el orden correcto. Si cometes un error, podrías perder el acceso a tu cuenta.';

  @override
  String get confirmSeedPhraseSuccess => '¡Correcto! Ahora confirma una segunda palabra de tu frase semilla.';

  @override
  String get authErrorUserNotFound => 'No existe una cuenta con este correo electrónico.';

  @override
  String get authErrorWrongPassword => 'La contraseña es incorrecta.';

  @override
  String get authErrorInvalidEmail => 'El formato del correo electrónico no es válido.';

  @override
  String get authErrorUserDisabled => 'Esta cuenta ha sido deshabilitada.';

  @override
  String get authErrorEmailAlreadyInUse => 'Ya existe una cuenta con este correo electrónico.';

  @override
  String get authErrorWeakPassword => 'La contraseña es demasiado débil.';

  @override
  String get authErrorOperationNotAllowed => 'Esta operación no está permitida.';

  @override
  String get authErrorTooManyRequests => 'Demasiados intentos fallidos. Por favor, intente más tarde.';

  @override
  String get authErrorNetworkRequestFailed => 'Error de conexión. Verifique su conexión a internet.';

  @override
  String get authErrorRequiresRecentLogin => 'Por favor, inicie sesión nuevamente para realizar esta acción.';

  @override
  String get authErrorUnknown => 'Ha ocurrido un error inesperado. Por favor, intente nuevamente.';

  @override
  String get authErrorInvalidCredential => 'Credenciales inválidas.';

  @override
  String get authErrorAccountExistsWithDifferentCredential => 'Ya existe una cuenta con estas credenciales.';

  @override
  String get authErrorInvalidVerificationCode => 'Código de verificación inválido.';

  @override
  String get authErrorInvalidVerificationId => 'ID de verificación inválido.';

  @override
  String get authErrorMissingVerificationCode => 'Falta el código de verificación.';

  @override
  String get authErrorMissingVerificationId => 'Falta el ID de verificación.';

  @override
  String get stellarErrorAccountNotFound => 'Cuenta Stellar no encontrada';

  @override
  String get stellarErrorAccountExists => 'La cuenta Stellar ya existe';

  @override
  String get stellarErrorInvalidAccount => 'Cuenta Stellar inválida';

  @override
  String get stellarErrorInsufficientBalance => 'Saldo insuficiente en la cuenta Stellar';

  @override
  String get stellarErrorTransactionFailed => 'Transacción Stellar fallida';

  @override
  String get stellarErrorInvalidTransaction => 'Transacción Stellar inválida';

  @override
  String get stellarErrorTransactionExpired => 'Transacción Stellar expirada';

  @override
  String get stellarErrorInvalidAmount => 'Monto inválido para la transacción Stellar';

  @override
  String get stellarErrorNetworkError => 'Error de red Stellar';

  @override
  String get stellarErrorServerError => 'Error del servidor Stellar';

  @override
  String get stellarErrorTimeoutError => 'Tiempo de espera agotado en Stellar';

  @override
  String get stellarErrorUnknown => 'Error desconocido en Stellar';

  @override
  String get stellarErrorInvalidOperation => 'Operación Stellar inválida';

  @override
  String get stellarErrorInvalidMnemonic => 'Frase mnemotécnica Stellar inválida';

  @override
  String get stellarErrorInvalidSecretKey => 'Clave secreta Stellar inválida';

  @override
  String get stellarErrorInvalidPublicKey => 'La clave pública no es válida';

  @override
  String get stellarErrorInvalidMemo => 'El memo no puede tener más de 28 caracteres';

  @override
  String get stellarErrorAccountNotInitialized => 'No hay una cuenta Stellar inicializada';

  @override
  String get walletErrorCreationFailed => 'Error al crear la wallet. Por favor, inténtalo de nuevo.';

  @override
  String get walletErrorInvalidMnemonic => 'Frase mnemotécnica inválida. Por favor, verifica e inténtalo de nuevo.';

  @override
  String get walletErrorMnemonicGenerationFailed => 'Error al generar la frase mnemotécnica. Por favor, inténtalo de nuevo.';

  @override
  String get walletErrorImportFailed => 'Error al importar la wallet. Por favor, verifica tu frase mnemotécnica e inténtalo de nuevo.';

  @override
  String get walletErrorInvalidSecretKey => 'Clave secreta inválida. Por favor, verifica e inténtalo de nuevo.';

  @override
  String get walletErrorBalanceRetrievalFailed => 'Error al obtener el balance de la wallet. Por favor, inténtalo de nuevo.';

  @override
  String get walletErrorInsufficientFunds => 'Fondos insuficientes para completar la transacción.';

  @override
  String get walletErrorAccountNotFound => 'Cuenta de wallet no encontrada. Por favor, verifica tus credenciales.';

  @override
  String get walletErrorNetworkError => 'Error de red. Por favor, verifica tu conexión e inténtalo de nuevo.';

  @override
  String get walletErrorTimeoutError => 'La solicitud ha expirado. Por favor, inténtalo de nuevo.';

  @override
  String get walletErrorUnknown => 'Ha ocurrido un error desconocido. Por favor, inténtalo de nuevo.';

  @override
  String get assetErrorPriceUpdateFailed => 'Error al actualizar el precio del activo';

  @override
  String get assetErrorInvalidPriceData => 'Datos de precio inválidos recibidos';

  @override
  String get assetErrorPriceHistoryNotFound => 'Historial de precios no encontrado para este activo';

  @override
  String get assetErrorNetworkError => 'Error de red al obtener datos del activo';

  @override
  String get assetErrorTimeoutError => 'Tiempo de espera agotado al obtener datos del activo';

  @override
  String get assetErrorInvalidSymbol => 'Símbolo de activo inválido';

  @override
  String get assetErrorDataParsingError => 'Error al procesar los datos del activo';

  @override
  String get assetErrorUnknown => 'Ocurrió un error inesperado con el activo';

  @override
  String get assetErrorAssetsListFailed => 'No se pudieron obtener los activos disponibles';

  @override
  String get assetErrorMarketDataNotFound => 'Los datos de mercado para este activo no están disponibles actualmente';

  @override
  String get assetErrorDetailsNotFound => 'No se pudo encontrar información detallada para este activo';

  @override
  String get assetErrorMarketDataUpdateFailed => 'Error al actualizar los datos de mercado. Por favor, intente más tarde.';
}
