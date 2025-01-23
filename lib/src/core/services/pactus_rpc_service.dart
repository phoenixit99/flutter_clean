import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:json_rpc_2/json_rpc_2.dart';

class PactusRpcService {
  late final WebSocketChannel _channel;
  late final Client _client;
  bool _isConnected = false;

  Future<void> connect() async {
    try {
      _channel = WebSocketChannel.connect(
        Uri.parse('ws://127.0.0.1:8545'),
      );
      
      _client = Client(_channel.cast<String>());
      await _client.listen();
      _isConnected = true;
    } catch (e) {
      _isConnected = false;
      throw Exception('Failed to connect to Pactus daemon: $e');
    }
  }

  Future<void> subscribe(String event, Function(dynamic) callback) async {
    if (!_isConnected) await connect();
    
    try {
      await _client.sendRequest('subscribe', [event]);
      _channel.stream.listen((message) {
        if (message.containsKey('method') && message['method'] == event) {
          callback(message['params']);
        }
      });
    } catch (e) {
      throw Exception('Failed to subscribe to $event: $e');
    }
  }

  Future<void> disconnect() async {
    await _client.close();
    await _channel.sink.close();
    _isConnected = false;
  }
} 