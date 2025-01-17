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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const WalletScreen(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final file = File('lib/assets/pactus/pactus-cli_1.6.4_darwin_arm64.tar.gz');
          setState(() {
            if (file.existsSync()) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('File Check'),
                    content: Text('Pactus CLI file exists! File size: ${file.lengthSync()} bytes'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            } else {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('File Check'),
                    content: Text('Pactus CLI file does not exist. Expected path: ${file.absolute.path}'),
                    actions: <Widget>[
                      TextButton(
                        child: const Text('OK'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            }
          });
        },
        child: const Icon(Icons.check),
        tooltip: 'Check Pactus CLI',
      ),
    );
  }
}