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
  String get loading => 'Se esta cargando';

  @override
  String get featureNotImplemented => 'Esta función no se ha implementado completamente';

  @override
  String get testingPurposes => 'Propósitos de Prueba';

  @override
  String get showIndividualScreens => 'Mostrar Pantallas Individuales';

  @override
  String get deletePublicPrivateKeys => 'Eliminar Claves Públicas/Privadas';

  @override
  String get deleteTermsOfServices => 'Eliminar Términos de Servicio';

  @override
  String get deleteOnboardingSteps => 'Eliminar Pasos de Onboarding';

  @override
  String get allKeysDeleted => 'Todas las claves fueron eliminadas - Almacenamiento Seguro';

  @override
  String get termsDeleted => 'Términos eliminados - Almacenamiento Interno';

  @override
  String get onboardingReset => 'Onboarding reiniciado - Almacenamiento Interno';

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
  String get googleSignInNotImplemented => 'Inicio de sesión con Google aún no implementado';

  @override
  String get appleSignInNotImplemented => 'Inicio de sesión con Apple aún no implementado';

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
  String get countryOfResidence => 'Selecciona tu país de residencia';

  @override
  String get countryOfResidenceRequired => 'Por favor selecciona tu país de residencia';

  @override
  String get searchCountry => 'Buscar país';

  @override
  String get startTypingToSearch => 'Comienza a escribir para buscar';

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
  String get walletSuccessInfo => 'NemorixPay no puede recuperar tu wallet si la pierdes. Puedes encontrar tus opciones de seguridad en Ajustes > Seguridad & Privacidad.';

  @override
  String get goToHomePage => 'Ir a la página principal';

  @override
  String get search => 'Buscar...';

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
  String get send => 'Enviado';

  @override
  String get receive => 'Recibido';

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
  String get lastUpdateOnly => 'Última actualización';

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
  String get noAvailableData => 'Datos no disponible. ¡Trata mas tarde!';

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
  String get walletErrorUserNotAuthenticated => 'Usuario no autenticado. Por favor, inicia sesión nuevamente.';

  @override
  String get walletErrorCreationFailedGeneric => 'No se pudo crear la wallet. Inténtalo de nuevo.';

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

  @override
  String get termsOfServices => 'Términos y Condiciones';

  @override
  String get lastUpdate => 'Última actualización en Junio 2025';

  @override
  String get termsContent => 'Bienvenido a NemorixPay. Por favor, lea estos Términos y Condiciones cuidadosamente antes de usar nuestra aplicación.';

  @override
  String get termsTitle => 'Términos';

  @override
  String get termsTitleTesting => 'Términos (Modo de prueba)';

  @override
  String get termsAndConditionsContent => 'TÉRMINOS Y CONDICIONES DE NEMORIXPAY\n\nBienvenido a NemorixPay. Al usar nuestra aplicación, usted acepta estos términos y condiciones.\n\n1. DESCRIPCIÓN DEL SERVICIO\nNemorixPay es una aplicación de billetera de criptomonedas y pagos que permite a los usuarios almacenar, enviar y recibir activos digitales en la red Stellar.\n\n';

  @override
  String get termsLastUpdate => 'Última actualización: Febrero 2025';

  @override
  String get termsBody => 'RESPONSABILIDADES DEL USUARIO\n- Usted es responsable de mantener la seguridad de su billetera\n- Mantenga sus claves privadas seguras y nunca las comparta con nadie\n- Verifique todos los detalles de la transacción antes de confirmar\n- Reporte cualquier actividad sospechosa inmediatamente\n\n SEGURIDAD\n- Implementamos medidas de seguridad estándar de la industria\n- Sin embargo, usted es responsable de la seguridad de su billetera\n- No podemos recuperar claves privadas perdidas o fondos robados\n- Habilite la autenticación de dos factores cuando esté disponible\n\n TRANSACCIONES\n- Todas las transacciones son irreversibles una vez confirmadas en la blockchain\n- Verifique las direcciones del destinatario cuidadosamente antes de enviar\n- Pueden aplicarse tarifas de red y no son reembolsables\n- Los tiempos de transacción pueden variar según las condiciones de la red\n\n PRIVACIDAD\n- Recopilamos y procesamos datos personales como se describe en nuestra Política de Privacidad\n- Sus datos están protegidos usando encriptación y protocolos seguros\n- No vendemos su información personal a terceros\n- Puede solicitar la eliminación de datos en cualquier momento\n\n LIMITACIONES DE RESPONSABILIDAD\n- No somos responsables de pérdidas debido a errores o negligencia del usuario\n- No garantizamos la disponibilidad ininterrumpida del servicio\n- La responsabilidad máxima está limitada al monto de las tarifas pagadas\n- No somos responsables de interrupciones de servicios de terceros\n\n PROPIEDAD INTELECTUAL\n- NemorixPay y su contenido están protegidos por derechos de autor\n- No puede copiar, modificar o distribuir nuestro software sin permiso\n- Todas las marcas comerciales y logos pertenecen a sus respectivos propietarios\n\n LEY APLICABLE\n- Estos términos se rigen por las leyes aplicables\n- Las disputas se resolverán a través de arbitraje\n- Los cambios en los términos se comunicarán a través de la aplicación\n\n';

  @override
  String get licenseTitle => 'Licencia de Uso y Detalles de Contacto';

  @override
  String get licenseBody => '@copyright: Apache 2.0 License\n\nINFORMACIÓN DE CONTACTO\nPara preguntas sobre estos términos, contáctenos en:\nEmail: support@nemorixpay.com\nSitio web: www.nemorixpay.com\n\nÚltima actualización: Febrero 2025\nVersión: 1.0';

  @override
  String get accept => 'Aceptar';

  @override
  String get decline => 'Rechazar';

  @override
  String get acceptTermsCheckbox => 'Acepto los términos y condiciones';

  @override
  String get confirmDeclineTerms => '¿Estás seguro de que quieres rechazar nuestros términos de servicio?';

  @override
  String get yesDecline => 'Sí, rechazar';

  @override
  String get noContinue => 'No, continuar';

  @override
  String get loremIpsumTitle => 'Lorem Ipsum';

  @override
  String get loremIpsumContent => 'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum. \n\nLorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.';

  @override
  String get onboarding_security_title => 'Tu Seguridad es Nuestra Prioridad';

  @override
  String get onboarding_security_subtitle => 'Protegemos tus fondos y datos personales';

  @override
  String get onboarding_security_feature_biometric_title => 'Autenticación Biométrica';

  @override
  String get onboarding_security_feature_biometric_desc => 'Accede de forma segura con tu huella digital';

  @override
  String get onboarding_security_feature_encryption_title => 'Encriptación de Extremo a Extremo';

  @override
  String get onboarding_security_feature_encryption_desc => 'Tus datos siempre protegidos';

  @override
  String get onboarding_security_feature_monitoring_title => 'Monitoreo 24/7';

  @override
  String get onboarding_security_feature_monitoring_desc => 'Vigilancia constante de tus transacciones';

  @override
  String get onboarding_button_skip => 'Saltar';

  @override
  String get onboarding_button_next => 'Siguiente';

  @override
  String get onboarding_button_back => 'Atras';

  @override
  String get onboarding_features_title => 'Todo lo que Necesitas en un Solo Lugar';

  @override
  String get onboarding_features_subtitle => 'Gestiona tus criptomonedas de forma sencilla';

  @override
  String get onboarding_features_trading_title => 'Compra y Vende al Instante';

  @override
  String get onboarding_features_trading_desc => 'Opera criptomonedas de forma rápida y segura';

  @override
  String get onboarding_features_monitoring_title => 'Monitoreo en Tiempo Real';

  @override
  String get onboarding_features_monitoring_desc => 'Sigue los precios del mercado al instante';

  @override
  String get onboarding_features_history_title => 'Historial de Transacciones';

  @override
  String get onboarding_features_history_desc => 'Accede a tu historial completo de operaciones';

  @override
  String get onboarding_features_notifications_title => 'Notificaciones de Mercado';

  @override
  String get onboarding_features_notifications_desc => 'Recibe alertas sobre movimientos importantes';

  @override
  String get onboarding_features_wallets_title => 'Múltiples Wallets';

  @override
  String get onboarding_features_wallets_desc => 'Gestiona todas tus carteras en un solo lugar';

  @override
  String get onboarding_benefits_title => 'La Mejor Experiencia Cripto';

  @override
  String get onboarding_benefits_subtitle => 'Disfruta de ventajas exclusivas';

  @override
  String get onboarding_benefits_fees_title => 'Comisiones Competitivas';

  @override
  String get onboarding_benefits_fees_desc => 'Las comisiones más bajas del mercado';

  @override
  String get onboarding_benefits_support_title => 'Soporte 24/7';

  @override
  String get onboarding_benefits_support_desc => 'Atención técnica disponible en todo momento';

  @override
  String get onboarding_benefits_ui_title => 'Interfaz Intuitiva';

  @override
  String get onboarding_benefits_ui_desc => 'Diseño fácil de usar y entender';

  @override
  String get onboarding_benefits_speed_title => 'Transacciones Instantáneas';

  @override
  String get onboarding_benefits_speed_desc => 'Operaciones rápidas y eficientes';

  @override
  String get onboarding_benefits_coins_title => 'Amplia Selección';

  @override
  String get onboarding_benefits_coins_desc => 'Acceso a más de 100 criptomonedas';

  @override
  String receiveCryptoTitle(String cryptoName) {
    return 'Recibir $cryptoName';
  }

  @override
  String get scanQrCodeText => 'Escanee el código QR para obtener la dirección de recepción';

  @override
  String get orDividerText => 'o';

  @override
  String yourCryptoAddress(String cryptoName) {
    return 'Su dirección de $cryptoName';
  }

  @override
  String get blockTimeInfo => '* Bloque/Tiempo se calculará después de que la transacción sea generada y transmitida';

  @override
  String get copyAddressButton => 'Copiar Dirección';

  @override
  String get shareAddressButton => 'Compartir Dirección';

  @override
  String get addressCopiedMessage => '¡Dirección copiada al portapapeles!';

  @override
  String sendCryptoTitle(String cryptoName) {
    return 'Enviar $cryptoName';
  }

  @override
  String get enterAddress => 'Ingresar dirección';

  @override
  String get recipientAddress => 'Dirección de destino';

  @override
  String get invalidAddress => 'Dirección inválida';

  @override
  String get ownAddressError => 'No puedes enviar a tu propia dirección';

  @override
  String get amount => 'Monto';

  @override
  String get amountHint => '0.00';

  @override
  String get invalidAmount => 'El monto excede tu saldo disponible';

  @override
  String get note => 'Nota';

  @override
  String get noteHint => 'Nota opcional';

  @override
  String transactionFees(double fee, String cryptoName) {
    return 'Comisión de transacción: $fee $cryptoName';
  }

  @override
  String sendCryptominMax(double min, double max, String cryptoName) {
    return 'Min: $min $cryptoName - Max: $max $cryptoName';
  }

  @override
  String get availableBalance => 'Saldo disponible';

  @override
  String sendButton(String cryptoName) {
    return 'Enviar $cryptoName';
  }

  @override
  String get qrNotImplemented => 'Escáner QR aún no implementado.';

  @override
  String get sendNotImplemented => 'Enviar aún no implementado.';

  @override
  String get stellarLumens => 'Stellar Lumens';

  @override
  String get transactionSent => '¡Transacción enviada!';

  @override
  String get transactionFailed => '¡Transacción fallida!';

  @override
  String get sendingTransaction => 'Enviando tu transacción...';

  @override
  String get transactionSuccessTitle => '¡Transacción Exitosa!';

  @override
  String transactionSuccessMessage(String cryptoName) {
    return 'Tu transacción de $cryptoName ha sido enviada exitosamente a la red Stellar. La transacción está siendo procesada y será confirmada en breve.';
  }

  @override
  String transactionHashInfo(String hash) {
    return 'Hash de Transacción: $hash';
  }

  @override
  String get transactionConfirmationNote => 'Puedes usar este hash para rastrear tu transacción en el explorador de la red Stellar.';

  @override
  String get memoLongErrorMessage => 'La nota no puede tener más de 28 caracteres';

  @override
  String get confirmTransactionTitle => 'Confirmar Transacción';

  @override
  String get confirmTransactionCanceled => '¡Transacción cancelada!';

  @override
  String get confirmTransactionFees => 'Comisión de transacción:';

  @override
  String get transactionSummary => 'Resumen de Transacción';

  @override
  String get transactionDetails => 'Detalles de Transacción';

  @override
  String confirmAndSend(String cryptoName) {
    return 'Confirmar y Enviar $cryptoName';
  }

  @override
  String get cancel => 'Cancelar';

  @override
  String get home => 'Página principal';

  @override
  String get settings => 'Herramientas';

  @override
  String get signOut => 'Cerrar sesión';

  @override
  String get confirmSignOut => '¿Estás seguro de que quieres cerra sesión?';

  @override
  String get yes => 'Si';

  @override
  String get no => 'No';

  @override
  String get userProfile => 'Perfil de Usuario';

  @override
  String get general => 'General';

  @override
  String get myAccount => 'Mi Cuenta';

  @override
  String get billingPayment => 'Facturación/Pagos';

  @override
  String get faqSupport => 'FAQ & Soporte';

  @override
  String get setting => 'Configuración';

  @override
  String get language => 'Idioma';

  @override
  String get darkMode => 'Modo Oscuro';

  @override
  String get selectLanguage => 'Seleccionar Idioma';

  @override
  String get saveChanges => 'Guardar';

  @override
  String get paymentMethodTitle => 'Método de Pago';

  @override
  String get creditCardLabel => 'Tarjeta de Crédito';

  @override
  String get addNewCardTitle => 'Agregar Nueva Tarjeta';

  @override
  String get cardNumberLabel => 'Número de Tarjeta';

  @override
  String get cardHolderLabel => 'Titular de la Tarjeta';

  @override
  String get expiryDateLabel => 'Fecha de Vencimiento';

  @override
  String get addButton => 'Agregar';

  @override
  String get addNewCardButton => '+agregar nueva tarjeta';

  @override
  String get googlePayLabel => 'Google Pay';

  @override
  String get applePayLabel => 'Apple Pay';

  @override
  String get mobileBankingLabel => 'Banca Móvil';

  @override
  String get sendReceiptLabel => 'Enviar recibo a tu email';

  @override
  String get transactionHistory => 'Historial de Transacciones';

  @override
  String get searchTransactions => 'Buscar transacciones...';

  @override
  String get noTransactionsFound => 'No se encontraron transacciones';

  @override
  String noTransactionsFoundFor(Object query) {
    return 'No se encontraron transacciones para \"$query\"';
  }

  @override
  String get errorLoadingTransactions => 'Error al cargar transacciones';

  @override
  String get retry => 'Reintentar';

  @override
  String get loadingMore => 'Cargando más...';

  @override
  String get confirmed => 'Confirmado';

  @override
  String get failed => 'Fallido';

  @override
  String get notAvailable => 'N/D';

  @override
  String transactionId(Object id) {
    return 'Transacción: $id';
  }
}
