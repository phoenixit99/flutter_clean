import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/providers/pactus_provider.dart';
import 'src/features/wallet/screens/wallet_screen.dart';
import 'dart:io';

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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String message = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pactus Daemon Check',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(message),
            const WalletScreen(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            final file = File('lib/assets/pactus/pactus-cli_1.6.4_darwin_arm64.tar.gz');
            setState(() {
              if (file.existsSync()) {
                message = 'Pactus CLI file exists! File size: ${file.lengthSync()} bytes';
              } else {
                message = 'Pactus CLI file does not exist. Expected path: ${file.absolute.path}';
              }
            });
          },
          child: const Icon(Icons.check),
          tooltip: 'Check Pactus CLI',
        ),
      ),
    );
  }
}