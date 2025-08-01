import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// @file        kyc_webview_widget.dart
/// @brief       WebView widget for KYC verification
/// @details     Reusable WebView component for displaying Didit KYC
///              verification interface with loading and error states
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class KYCWebViewWidget extends StatefulWidget {
  final String url;
  final VoidCallback? onPageFinished;
  final VoidCallback? onError;
  final VoidCallback? onNavigationRequest;

  const KYCWebViewWidget({
    super.key,
    required this.url,
    this.onPageFinished,
    this.onError,
    this.onNavigationRequest,
  });

  @override
  State<KYCWebViewWidget> createState() => _KYCWebViewWidgetState();
}

class _KYCWebViewWidgetState extends State<KYCWebViewWidget> {
  late final WebViewController _controller;
  bool _isLoading = true;
  bool _hasError = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeWebView();
  }

  void _initializeWebView() {
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              _isLoading = true;
              _hasError = false;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              _isLoading = false;
            });
            widget.onPageFinished?.call();
          },
          onWebResourceError: (WebResourceError error) {
            setState(() {
              _isLoading = false;
              _hasError = true;
              _errorMessage = error.description;
            });
            widget.onError?.call();
          },
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigation requests for now
            // Can be customized based on requirements
            widget.onNavigationRequest?.call();
            return NavigationDecision.navigate;
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // WebView
          WebViewWidget(controller: _controller),

          // Loading indicator
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),

          // Error state
          if (_hasError)
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar la verificación',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _errorMessage,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _retry,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  void _retry() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });
    _controller.reload();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
