import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/providers/pactus_provider.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    Future.microtask(() => 
      context.read<PactusProvider>().checkDaemonVersion()
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pactus Installation'),
      ),
      body: Consumer<PactusProvider>(
        builder: (context, provider, child) {
          return Column(
            children: [
              if (provider.isInstalling || provider.isChecking)
                Column(
                  children: [
                    LinearProgressIndicator(
                      value: provider.downloadProgress,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        '${(provider.downloadProgress * 100).toStringAsFixed(1)}%',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              Expanded(
                child: ListView.builder(
                  controller: _scrollController,
                  itemCount: provider.logs.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8.0,
                        vertical: 4.0,
                      ),
                      child: Text(
                        provider.logs[index],
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 12,
                        ),
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: provider.isInstalling ? null : () => provider.checkDaemonVersion(),
                  child: const Text('Check/Install'),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }
} 