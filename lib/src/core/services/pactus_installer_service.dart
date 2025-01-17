import 'dart:io';
import 'package:path/path.dart' as path;

class PactusDaemonInstaller {
  static Future<bool> installDaemon() async {
    try {
      final homeDir = Platform.environment['HOME'];
      final pactusDir = Directory('$homeDir/.pactus');
      
      // Create pactus directory if it doesn't exist
      if (!await pactusDir.exists()) {
        await pactusDir.create();
      }

      // Check if daemon is already installed
      final daemonPath = '/usr/local/bin/pactus-daemon';
      if (await File(daemonPath).exists()) {
        return true;
      }

      // Download latest release for macOS
      final process = await Process.run('curl', [
        '-L',
        '-o',
        '${pactusDir.path}/pactus-daemon.tar.gz',
        'https://github.com/pactus-project/pactus/releases/latest/download/pactus-darwin-amd64.tar.gz'
      ]);

      if (process.exitCode != 0) {
        throw Exception('Failed to download pactus-daemon');
      }

      // Extract the daemon
      await Process.run('tar', [
        'xzf',
        '${pactusDir.path}/pactus-daemon.tar.gz',
        '-C',
        pactusDir.path
      ]);

      // Move to /usr/local/bin with sudo
      await Process.run('sudo', [
        'mv',
        '${pactusDir.path}/pactus-daemon',
        '/usr/local/bin/'
      ]);

      // Make executable
      await Process.run('sudo', [
        'chmod',
        '+x',
        '/usr/local/bin/pactus-daemon'
      ]);

      return true;
    } catch (e) {
      print('Failed to install pactus-daemon: $e');
      return false;
    }
  }
} 