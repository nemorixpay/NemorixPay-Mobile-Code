/// @file        stellar_service_test_page.dart
/// @brief       Test page for StellarService integration in NemorixPay.
/// @details     Allows isolated testing of mnemonic generation, key derivation, and account creation on the Stellar testnet. Results are shown on screen and in the debug console.
/// @author      Miguel Fagundez
/// @date        2025-05-03
/// @version     1.0
/// @copyright   Apache 2.0 License

import 'package:flutter/material.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:nemorixpay/features/wallet/data/datasources/stellar_service.dart';

class StellarServiceTestPage extends StatefulWidget {
  const StellarServiceTestPage({super.key});

  @override
  State<StellarServiceTestPage> createState() => _StellarServiceTestPageState();
}

class _StellarServiceTestPageState extends State<StellarServiceTestPage> {
  late final StellarService _stellarService;
  String? _mnemonic;
  String? _publicKey;
  String? _secretSeed;
  String? _friendbotResult;
  String? _balancePublicKey;
  double? _balanceResult;
  String? _balanceError;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    _stellarService = StellarService(sdk: StellarSDK.TESTNET);
  }

  void _generateMnemonic() {
    setState(() {
      _mnemonic = _stellarService.generateMnemonic();
      _publicKey = null;
      _secretSeed = null;
      _friendbotResult = null;
    });
    debugPrint('Mnemonic: $_mnemonic');
  }

  Future<void> _deriveKeys() async {
    if (_mnemonic == null) return;
    setState(() => _loading = true);
    try {
      final keyPair = await _stellarService.getKeyPairFromMnemonic(_mnemonic!);
      setState(() {
        _publicKey = keyPair.accountId;
        _secretSeed = keyPair.secretSeed;
      });
      debugPrint('Public Key: $_publicKey');
      debugPrint('Secret Seed: $_secretSeed');
    } catch (e) {
      debugPrint('Error deriving keys: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _createAccount() async {
    if (_publicKey == null) return;
    setState(() => _loading = true);
    try {
      await _stellarService.createAccountInTestnet(_publicKey!);
      setState(() {
        _friendbotResult = 'Account created and funded in testnet!';
      });
      debugPrint('Account created and funded in testnet!');
    } catch (e) {
      setState(() {
        _friendbotResult = 'Error: $e';
      });
      debugPrint('Error creating account: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _checkBalance() async {
    if (_balancePublicKey == null || _balancePublicKey!.isEmpty) return;
    setState(() {
      _loading = true;
      _balanceResult = null;
      _balanceError = null;
    });
    try {
      final balance = await _stellarService.getBalance(_balancePublicKey!);
      setState(() {
        _balanceResult = balance;
      });
      debugPrint('Balance for $_balancePublicKey: $balance XLM');
    } catch (e) {
      setState(() {
        _balanceError = 'Error: $e';
      });
      debugPrint('Error checking balance: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StellarService Test')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _loading ? null : _generateMnemonic,
              child: const Text('Generate Mnemonic'),
            ),
            const SizedBox(height: 12),
            if (_mnemonic != null) SelectableText('Mnemonic: $_mnemonic'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: (_loading || _mnemonic == null) ? null : _deriveKeys,
              child: const Text('Derive Keys from Mnemonic'),
            ),
            const SizedBox(height: 12),
            if (_publicKey != null) SelectableText('Public Key: $_publicKey'),
            if (_secretSeed != null)
              SelectableText('Secret Seed: $_secretSeed'),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  (_loading || _publicKey == null) ? null : _createAccount,
              child: const Text('Create Account in Testnet (Friendbot)'),
            ),
            const SizedBox(height: 12),
            if (_friendbotResult != null)
              Text(
                _friendbotResult!,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            const SizedBox(height: 32),
            Text(
              'Check XLM Balance for Public Key:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextField(
              decoration: const InputDecoration(
                labelText: 'Public Key',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) => _balancePublicKey = value.trim(),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _checkBalance,
              child: const Text('Check Balance'),
            ),
            if (_balanceResult != null)
              Text(
                'Balance: $_balanceResult XLM',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            if (_balanceError != null)
              Text(_balanceError!, style: const TextStyle(color: Colors.red)),
            if (_loading)
              const Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: Center(child: CircularProgressIndicator()),
              ),
          ],
        ),
      ),
    );
  }
}
