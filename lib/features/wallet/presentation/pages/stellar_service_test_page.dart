import 'package:flutter/material.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_secure_storage_datasource.dart';
import 'package:stellar_flutter_sdk/stellar_flutter_sdk.dart';
import 'package:nemorixpay/features/wallet/data/datasources/stellar_service.dart';
import 'dart:convert';

/// @file        stellar_service_test_page.dart
/// @brief       Test page for StellarService integration in NemorixPay.
/// @details     Allows isolated testing of mnemonic generation, key derivation, account creation and transactions on the Stellar testnet.
/// @author      Miguel Fagundez
/// @date        2025-05-04
/// @version     1.1
/// @copyright   Apache 2.0 License
class StellarServiceTestPage extends StatefulWidget {
  const StellarServiceTestPage({super.key});

  @override
  State<StellarServiceTestPage> createState() => _StellarServiceTestPageState();
}

class _StellarServiceTestPageState extends State<StellarServiceTestPage> {
  late final StellarService _stellarService;
  final StellarSecureStorageDataSource _stellarSecureStorageDataSource =
      StellarSecureStorageDataSource();
  String? _mnemonic;
  String? _publicKey;
  String? _secretSeed;
  String? _friendbotResult;
  String? _transactionHash;
  String? _transactionResult;
  String? _privateKeyResult;
  bool _loading = false;
  double? _currentBalance;

  // Controllers para formularios
  final _sourceSecretSeedController = TextEditingController();
  final _destinationController = TextEditingController();
  final _amountController = TextEditingController();
  final _hashController = TextEditingController();
  final _secureStorageController = TextEditingController();
  final _memoController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _stellarService = StellarService(sdk: StellarSDK.TESTNET);
  }

  @override
  void dispose() {
    _sourceSecretSeedController.dispose();
    _destinationController.dispose();
    _amountController.dispose();
    _hashController.dispose();
    _secureStorageController.dispose();
    _memoController.dispose();
    super.dispose();
  }

  void _generateMnemonic() {
    setState(() {
      _mnemonic = _stellarService.generateMnemonic();
      _publicKey = null;
      _secretSeed = null;
      _friendbotResult = null;
      _transactionHash = null;
      _transactionResult = null;
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
    if (_sourceSecretSeedController.text.isEmpty) return;

    try {
      final keyPair = KeyPair.fromSecretSeed(_sourceSecretSeedController.text);
      final balance = await _stellarService.getBalance(keyPair.accountId);
      setState(() {
        _currentBalance = balance;
      });
    } catch (e) {
      setState(() {
        _currentBalance = null;
      });
      debugPrint('Error checking balance: $e');
    }
  }

  Future<void> _sendTransaction() async {
    if (_sourceSecretSeedController.text.isEmpty ||
        _destinationController.text.isEmpty ||
        _amountController.text.isEmpty) {
      setState(() {
        _transactionResult = 'Por favor, complete todos los campos requeridos';
      });
      return;
    }

    // Validar balance
    if (_currentBalance == null) {
      await _checkBalance();
    }

    final amount = double.tryParse(_amountController.text);
    if (amount == null) {
      setState(() {
        _transactionResult = 'Por favor, ingrese un monto válido';
      });
      return;
    }

    if (_currentBalance != null && _currentBalance! < amount) {
      setState(() {
        _transactionResult =
            'Balance insuficiente. Balance actual: $_currentBalance XLM, Monto a enviar: $amount XLM';
      });
      return;
    }

    // Validar tamaño del memo
    if (_memoController.text.isNotEmpty) {
      final memoBytes = utf8.encode(_memoController.text);
      if (memoBytes.length > 28) {
        setState(() {
          _transactionResult =
              'El memo no puede exceder 28 bytes (aproximadamente 28 caracteres ASCII)';
        });
        return;
      }
    }

    setState(() => _loading = true);
    try {
      final hash = await _stellarService.sendTransaction(
        sourceSecretSeed: _sourceSecretSeedController.text,
        destinationPublicKey: _destinationController.text,
        amount: amount,
        memo: _memoController.text,
      );
      setState(() {
        _transactionHash = hash;
        _transactionResult = 'Transaction sent successfully!';
        // Actualizar balance después de la transacción
        _checkBalance();
      });
      debugPrint('Transaction sent with hash: $hash');
    } catch (e) {
      setState(() {
        _transactionResult = 'Error: $e';
      });
      debugPrint('Error sending transaction: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _getPrivateKey() async {
    if (_secureStorageController.text.isEmpty) {
      debugPrint('Por favor, ingrese la llave publica de la cuenta');
      setState(() {
        _privateKeyResult =
            'Error: Por favor, ingrese la llave publica de la cuenta..';
      });
      return;
    }

    try {
      String? privateKey = await _stellarSecureStorageDataSource.getPrivateKey(
          publicKey: _secureStorageController.text);

      privateKey ??= 'Private key no fue encontrada';
      setState(() {
        _privateKeyResult = privateKey;
      });
    } catch (e) {
      setState(() {
        _privateKeyResult =
            'Hubo un error al tratar de recuperar la llave privada..';
      });
      return;
    }
  }

  Future<void> _deletePrivateKey() async {
    if (_secureStorageController.text.isEmpty) {
      debugPrint('Por favor, ingrese la llave publica de la cuenta');
      setState(() {
        _privateKeyResult =
            'Error: Por favor, ingrese la llave publica de la cuenta..';
      });
      return;
    }

    try {
      debugPrint('Public Key: ${_secureStorageController.text}');
      final isDeleted = await _stellarSecureStorageDataSource.deletePrivateKey(
          publicKey: _secureStorageController.text);
      debugPrint('isDeleted: ${isDeleted.toString()}');
      setState(() {
        if (isDeleted) {
          _privateKeyResult = 'Private key was deleted succesfully!';
        } else {
          _privateKeyResult = 'Private key no fue encontrad o fue borrada!';
        }
      });
    } catch (e) {
      setState(() {
        _privateKeyResult =
            'Hubo un error al tratar de borrar la llave privada..';
      });
      return;
    }
  }

  Future<void> _validateTransaction() async {
    if (_hashController.text.isEmpty) {
      setState(() {
        _transactionResult = 'Por favor, ingrese el hash de la transacción';
      });
      return;
    }

    setState(() => _loading = true);
    try {
      final result = await _stellarService.validateTransaction(
        _hashController.text.trim(),
      );
      setState(() {
        _transactionResult = 'Transaction details:\n${result.toString()}';
      });
      debugPrint('Transaction validation result: $result');
    } catch (e) {
      setState(() {
        _transactionResult = 'Error: $e';
      });
      debugPrint('Error validating transaction: $e');
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StellarService Test')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sección de creación de cuenta
            const Text(
              'Create New Account:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _generateMnemonic,
              child: const Text('Generate Mnemonic'),
            ),
            const SizedBox(height: 12),
            if (_mnemonic != null) SelectableText('Mnemonic: $_mnemonic'),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: (_loading || _mnemonic == null) ? null : _deriveKeys,
              child: const Text('Derive Keys from Mnemonic'),
            ),
            const SizedBox(height: 12),
            if (_publicKey != null) SelectableText('Public Key: $_publicKey'),
            if (_secretSeed != null)
              SelectableText('Secret Seed: $_secretSeed'),
            const SizedBox(height: 12),
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
            const SizedBox(height: 24),

            // Sección de envío de transacción
            const Text(
              'Send Transaction:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _sourceSecretSeedController,
              decoration: const InputDecoration(
                labelText: 'Source Secret Seed',
                border: OutlineInputBorder(),
              ),
              onChanged: (_) => _checkBalance(),
            ),
            const SizedBox(height: 12),
            if (_currentBalance != null)
              Text(
                'Balance actual: $_currentBalance XLM',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            const SizedBox(height: 12),
            TextField(
              controller: _destinationController,
              decoration: const InputDecoration(
                labelText: 'Destination Public Key',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _amountController,
              decoration: const InputDecoration(
                labelText: 'Amount (XLM)',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onChanged: (_) {
                if (_currentBalance != null &&
                    _amountController.text.isNotEmpty) {
                  final amount = double.tryParse(_amountController.text);
                  if (amount != null && amount > _currentBalance!) {
                    setState(() {
                      _transactionResult =
                          '⚠️ El monto excede el balance disponible';
                    });
                  } else {
                    setState(() {
                      _transactionResult = null;
                    });
                  }
                }
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _memoController,
              decoration: const InputDecoration(
                labelText: 'Memo (optional)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _sendTransaction,
              child: const Text('Send Transaction'),
            ),
            const SizedBox(height: 12),
            if (_transactionResult != null)
              Text(
                _transactionResult!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _transactionResult!.contains('Error') ||
                          _transactionResult!.contains('⚠️')
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            const SizedBox(height: 24),

            // Sección de validación de transacción
            const Text(
              'Validate Transaction:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _hashController,
              decoration: const InputDecoration(
                labelText: 'Transaction Hash',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _loading ? null : _validateTransaction,
              child: const Text('Validate Transaction'),
            ),
            const SizedBox(height: 12),
            if (_privateKeyResult != null)
              Text(
                _privateKeyResult!,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: _privateKeyResult!.contains('Error') ||
                          _privateKeyResult!.contains('⚠️')
                      ? Colors.red
                      : Colors.green,
                ),
              ),
            const SizedBox(height: 24),

            // Sección de validación de almacenamiento seguro (private key)
            const Text(
              'Validate Secure Storage:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _secureStorageController,
              decoration: const InputDecoration(
                labelText: 'Public Key',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _getPrivateKey,
              child: const Text('Get Private Key'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: _deletePrivateKey,
              child: const Text('Delete Private Key'),
            ),
            const SizedBox(height: 12),
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
