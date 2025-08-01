import 'package:flutter/material.dart';
import '../widgets/kyc_webview_widget.dart';

/// @file        kyc_test_page.dart
/// @brief       Test page for KYC WebView functionality
/// @details     Temporary page to test WebView with Google.com
///              This page will be removed after testing
/// @author      Miguel Fagundez
/// @date        07/31/2025
/// @version     1.0
/// @copyright   Apache 2.0 License

class KYCTestPage extends StatefulWidget {
  const KYCTestPage({super.key});

  @override
  State<KYCTestPage> createState() => _KYCTestPageState();
}

class _KYCTestPageState extends State<KYCTestPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test WebView - Google.com'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Column(
        children: [
          // Test info banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            color: Colors.black54,
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Colors.orange,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Building a reusable WebView for KYC integration',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: Colors.orange.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ),
              ],
            ),
          ),

          // WebView
          Expanded(
            child: KYCWebViewWidget(
              url: 'https://www.google.com',
              onPageFinished: _onPageFinished,
              onError: _onError,
              onNavigationRequest: _onNavigationRequest,
            ),
          ),
        ],
      ),
    );
  }

  void _onPageFinished() {
    debugPrint('✅ Google.com loaded successfully!');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('✅ Google.com loaded successfully!'),
        backgroundColor: Colors.green,
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _onError() {
    debugPrint('❌ Error loading Google.com');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('❌ Error al cargar Google.com'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _onNavigationRequest() {
    debugPrint('🔄 Navigation request detected');
  }
}
