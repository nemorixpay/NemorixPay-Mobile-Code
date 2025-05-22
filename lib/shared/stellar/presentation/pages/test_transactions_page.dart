import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:nemorixpay/shared/stellar/data/datasources/stellar_datasource_impl.dart';
import 'package:nemorixpay/shared/stellar/data/models/stellar_transaction_model.dart';
import 'package:nemorixpay/shared/stellar/data/providers/stellar_account_provider.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_transaction.dart';
import 'package:nemorixpay/core/errors/stellar/stellar_failure.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_bloc.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_event.dart';
import 'package:nemorixpay/shared/stellar/presentation/bloc/stellar_state.dart';
import 'package:nemorixpay/shared/stellar/domain/entities/stellar_asset_info.dart';

/// @file        test_transactions_page.dart
/// @brief       Test page for displaying Stellar transactions.
/// @details     This page is used to test the transaction functionality
///              of the Stellar integration.
/// @author      Miguel Fagundez
/// @date        2025-05-17
/// @version     1.0
/// @copyright   Apache 2.0 License

class TestTransactionsPage extends StatefulWidget {
  const TestTransactionsPage({super.key});

  @override
  State<TestTransactionsPage> createState() => _TestTransactionsPageState();
}

class _TestTransactionsPageState extends State<TestTransactionsPage> {
  final _stellarDatasource = StellarDataSourceImpl();
  final _accountProvider = StellarAccountProvider();
  List<StellarTransactionModel> _transactions = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    //_loadTransactions();
  }

  Future<void> _loadTransactions() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final transactions = await _stellarDatasource.getTransactions();
      setState(() {
        _transactions = transactions;
        _isLoading = false;
      });
    } on StellarFailure catch (e) {
      setState(() {
        _error = 'Error Stellar: ${e.stellarMessage}\nCódigo: ${e.stellarCode}';
        _isLoading = false;
      });
      debugPrint(
        'StellarDatasource: getTransactions - Error detallado: ${e.stellarMessage} (Código: ${e.stellarCode})',
      );
    } catch (e) {
      setState(() {
        _error = 'Error inesperado: $e';
        _isLoading = false;
      });
      debugPrint('StellarDatasource: getTransactions - Error inesperado: $e');
    }
  }

  void _useTestAccount() {
    _accountProvider.setTestAccount();
    _loadTransactions();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => GetIt.I<StellarBloc>(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Test Transacciones'),
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: _loadTransactions,
            ),
          ],
        ),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _buildAccountInfo(),
          const Divider(),
          _buildAvailableAssets(),
          const Divider(),
          _buildTransactionsList(),
        ],
      ),
    );
  }

  Widget _buildAccountInfo() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Información de la Cuenta de Prueba',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Public Key:', _accountProvider.testPublicKey),
            const SizedBox(height: 8),
            _buildInfoRow('Secret Key:', _accountProvider.testSecretKey),
            const SizedBox(height: 8),
            _buildInfoRow('Mnemonic:', _accountProvider.testMnemonic),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _useTestAccount,
              child: const Text('Usar Cuenta de Prueba'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 100,
          child: Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(
          child: SelectableText(
            value,
            style: const TextStyle(fontFamily: 'monospace'),
          ),
        ),
      ],
    );
  }

  Widget _buildAvailableAssets() {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Assets Disponibles',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            BlocBuilder<StellarBloc, StellarState>(
              builder: (context, state) {
                if (state is AvailableAssetsLoading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state is AvailableAssetsLoaded) {
                  final assets = state.assets.take(10).toList();
                  return Column(
                    children:
                        assets.map((asset) => _buildAssetItem(asset)).toList(),
                  );
                } else if (state is StellarError) {
                  return Center(
                    child: Column(
                      children: [
                        Text(
                          state.message,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            context.read<StellarBloc>().add(
                              GetAvailableAssetsEvent(),
                            );
                          },
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ),
                  );
                }
                return ElevatedButton(
                  onPressed: () {
                    context.read<StellarBloc>().add(GetAvailableAssetsEvent());
                  },
                  child: const Text('Cargar Assets Disponibles'),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssetItem(StellarAssetInfo asset) {
    Widget leadingWidget;
    if (asset.logoUrl != null) {
      leadingWidget = CircleAvatar(
        backgroundImage: NetworkImage(asset.logoUrl!),
        onBackgroundImageError: (_, __) {},
        child: const Icon(Icons.currency_exchange),
      );
    } else {
      leadingWidget = const CircleAvatar(child: Icon(Icons.currency_exchange));
    }

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: leadingWidget,
        title: Text(asset.name),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Código: ${asset.code}'),
            Text('Emisor: ${asset.issuerName}'),
            if (asset.isVerified)
              const Chip(
                label: Text('Verificado'),
                backgroundColor: Colors.green,
                labelStyle: TextStyle(color: Colors.white),
              ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }

  Widget _buildTransactionsList() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _error!,
              style: const TextStyle(color: Colors.red),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loadTransactions,
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (_transactions.isEmpty) {
      return const Center(child: Text('No hay transacciones para mostrar'));
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: _transactions.length,
      itemBuilder: (context, index) {
        final tx = _transactions[index];
        debugPrint('Hash: ${tx.hash}');
        debugPrint('Hash: ${tx.amount}');
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: ListTile(
            title: Text('Hash: ${tx.hash.substring(0, 8)}...'),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('De: ${tx.sourceAccount.substring(0, 8)}...'),
                Text('A: ${tx.destinationAccount.substring(0, 8)}...'),
                Text('Monto: ${tx.amount} XLM'),
                Text('Fecha: ${tx.createdAt}'),
                Text('Estado: ${tx.successful ? 'Exitoso' : 'Fallido'}'),
              ],
            ),
            isThreeLine: true,
          ),
        );
      },
    );
  }
}
