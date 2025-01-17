import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'src/core/providers/pactus_provider.dart';
import 'src/features/wallet/screens/wallet_screen.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

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
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String message = '';

  Future<void> checkFile() async {
    final directory = await getApplicationSupportDirectory();
    final file = File('${directory.path}/pactus-cli_1.6.4_darwin_arm64.tar.gz');

    if (await file.exists()) {
      setState(() async {
        message = 'Pactus CLI file exists! File size: ${await file.length()} bytes';
      });
    } else {
      setState(() {
        message = 'Pactus CLI file does not exist. Expected path: ${file.absolute.path}';
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const WalletScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          checkFile();
        },
        child: const Icon(Icons.check),
        tooltip: 'Check Pactus CLI',
      ),
    );
  }
}