import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/providers/pactus_provider.dart';
import 'src/features/wallet/screens/wallet_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PactusProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pactus Daemon Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const WalletScreen(),
    );
  }
}