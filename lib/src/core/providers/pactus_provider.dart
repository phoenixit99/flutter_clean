import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';

class PactusProvider extends ChangeNotifier {
  bool _isChecking = false;
  bool _isInstalling = false;
  double _downloadProgress = 0;
  final List<String> _logs = [];

  bool get isChecking => _isChecking;
  bool get isInstalling => _isInstalling;
  double get downloadProgress => _downloadProgress;
  List<String> get logs => List.unmodifiable(_logs);

  void _log(String message) {
    final timestamp = DateTime.now().toString();
    final logMessage = '[$timestamp] $message';
    print(logMessage);
    _logs.add(logMessage);
    notifyListeners();
  }

  Future<String> get _pactusPath async {
    final appDocDir = await getApplicationDocumentsDirectory();
    return path.join(appDocDir.path, '.pactus');
  }

  Future<void> _downloadWithProgress(String url, String savePath) async {
    final dio = Dio();
    _downloadProgress = 0;
    
    try {
      await dio.download(
        url,
        savePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            _downloadProgress = received / total;
            _log('Download progress: ${(_downloadProgress * 100).toStringAsFixed(1)}%');
            notifyListeners();
          }
        },
      );
      _downloadProgress = 1;
      notifyListeners();
    } catch (e) {
      _log('Download error: $e');
      rethrow;
    }
  }

  Future<void> checkDaemonVersion() async {
    try {
      _isChecking = true;
      _log('Starting installation check...');
      notifyListeners();

      final pactusDir = await _pactusPath;
      final daemonPath = path.join(pactusDir, 'bin', 'pactus-daemon');
      _log('Daemon path: $daemonPath');

      if (!await File(daemonPath).exists()) {
        _log('Daemon not found, starting installation...');
        await _installPactus();
        _log('Installation completed');
      } else {
        _log('Daemon found at: $daemonPath');
      }

    } catch (e) {
      _log('Error checking installation: $e');
    } finally {
      _isChecking = false;
      notifyListeners();
    }
  }

  Future<void> _installPactus() async {
    try {
      _isInstalling = true;
      _downloadProgress = 0;
      notifyListeners();

      final pactusDir = await _pactusPath;
      final binDir = Directory(path.join(pactusDir, 'bin'));
      
      _log('Installation paths:');
      _log('Pactus directory: $pactusDir');
      _log('Binary directory: ${binDir.path}');
      
      // Create directories
      await Directory(pactusDir).create(recursive: true);
      await binDir.create(recursive: true);
      
      // Download the binary with progress
      final downloadUrl = 'https://github.com/pactus-project/pactus/releases/download/v1.6.4/pactus-cli_1.6.4_darwin_arm64.tar.gz';
      final downloadPath = path.join(pactusDir, 'pactus.tar.gz');
      
      _log('Downloading from: $downloadUrl');
      await _downloadWithProgress(downloadUrl, downloadPath);

      final fileSize = await File(downloadPath).length();
      _log('Download successful, file size: ${(fileSize / 1024 / 1024).toStringAsFixed(2)} MB');

      // Extract with progress tracking
      _log('Extracting archive...');
      _downloadProgress = 0;
      notifyListeners();

      final extractResult = await Process.run('tar', [
        'xzf',
        downloadPath,
        '-C',
        binDir.path,
        '--verbose'
      ]);

      if (extractResult.exitCode != 0) {
        _log('Extraction error: ${extractResult.stderr}');
        throw Exception('Failed to extract Pactus: ${extractResult.stderr}');
      }

      _downloadProgress = 0.5;
      notifyListeners();
      _log('Extraction completed');

      // Move binaries with progress
      final binaries = ['pactus-daemon', 'pactus-shell', 'pactus-wallet'];
      double progressPerBinary = 0.5 / binaries.length;
      
      for (int i = 0; i < binaries.length; i++) {
        final binary = binaries[i];
        final sourcePath = path.join(binDir.path, 'pactus-cli_1.6.4', binary);
        final targetPath = path.join(binDir.path, binary);
        
        if (await File(sourcePath).exists()) {
          await File(sourcePath).rename(targetPath);
          await Process.run('chmod', ['+x', targetPath]);
          _log('Installed $binary to: $targetPath');
          
          _downloadProgress = 0.5 + (progressPerBinary * (i + 1));
          notifyListeners();
        } else {
          _log('Warning: Binary not found: $sourcePath');
        }
      }

      // Clean up
      await File(downloadPath).delete();
      final extractedDir = Directory(path.join(binDir.path, 'pactus-cli_1.6.4'));
      if (await extractedDir.exists()) {
        await extractedDir.delete(recursive: true);
      }
      
      _log('Cleaned up temporary files');

      // Verify installation
      final installedFiles = await binDir.list().toList();
      _log('Installed files:');
      for (var file in installedFiles) {
        final stat = file.statSync();
        _log('- ${file.path}');
        _log('  Size: ${(stat.size / 1024).toStringAsFixed(2)} KB');
        _log('  Mode: ${stat.mode}');
      }

      _downloadProgress = 1.0;
      notifyListeners();
      _log('Pactus installation completed successfully');
    } catch (e) {
      _log('Error installing Pactus: $e');
      rethrow;
    } finally {
      _isInstalling = false;
      notifyListeners();
    }
  }
} 