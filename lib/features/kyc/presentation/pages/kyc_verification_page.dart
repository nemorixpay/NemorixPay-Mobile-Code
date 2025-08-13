import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nemorixpay/features/kyc/presentation/bloc/kyc_bloc.dart';
import 'package:nemorixpay/features/kyc/presentation/bloc/kyc_event.dart';
import '../widgets/kyc_webview_widget.dart';

/// @file        kyc_verification_page.dart
/// @brief       KYC verification page using WebView
/// @details     Page that displays the Didit KYC verification interface
///              using a WebView component with proper navigation
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class KYCVerificationPage extends StatefulWidget {
  final String verificationUrl;

  const KYCVerificationPage({
    super.key,
    required this.verificationUrl,
  });

  @override
  State<KYCVerificationPage> createState() => _KYCVerificationPageState();
}

class _KYCVerificationPageState extends State<KYCVerificationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Verificación de Identidad'),
        leading: IconButton(
          icon: const Icon(Icons.close),
          //onPressed: () => Navigator.of(context).pop(),
          onPressed: () {
            debugPrint('LoadKYCStatus because WebView was closed');
            Navigator.of(context).pop();
            context.read<KYCBloc>().add(const LoadKYCStatus());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.help_outline),
            onPressed: _showHelpDialog,
          ),
        ],
      ),
      body: KYCWebViewWidget(
        url: widget.verificationUrl,
        onPageFinished: _onPageFinished,
        onError: _onError,
        onNavigationRequest: _onNavigationRequest,
      ),
    );
  }

  void _onPageFinished() {
    // TODO: Handle page finished event
    // This could trigger status updates or navigation
    debugPrint('KYC verification page finished loading');
  }

  void _onError() {
    // TODO: Handle error event
    // This could show a snackbar or trigger retry logic
    debugPrint('KYC verification page encountered an error');
  }

  void _onNavigationRequest() {
    // TODO: Handle navigation requests
    // This could be used to detect completion or specific navigation patterns
    debugPrint('KYC verification navigation request');
  }

  void _showHelpDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Ayuda - Verificación de Identidad'),
          content: const Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Para completar su verificación de identidad:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Text('• Asegúrese de tener buena iluminación'),
              Text('• Mantenga su documento estable'),
              Text('• Siga las instrucciones en pantalla'),
              Text('• Complete todos los pasos requeridos'),
              SizedBox(height: 8),
              Text(
                'Si tiene problemas, puede cerrar y reintentar más tarde.',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Entendido'),
            ),
          ],
        );
      },
    );
  }
}
