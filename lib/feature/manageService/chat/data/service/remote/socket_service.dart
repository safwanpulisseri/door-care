import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketService {
  final String chatApiLink = dotenv.env['CHAT_API_LINK']!;
  late IO.Socket socket;

  void initializeSocket(String userId) {
    socket = IO.io(chatApiLink, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Connect to the socket server
    socket.connect();

    // Listen for connection events
    socket.on('connect', (_) {
      print('Connected to socket server');
      socket.emit('join', userId); // Join a room with userId
    });

    socket.on('disconnect', (_) => print('Disconnected from socket server'));
  }

  void sendMessage(String conversationId, String message) {
    socket.emit('message', {
      'conversationId': conversationId,
      'message': message,
    });
  }

  void listenForMessages(Function onMessageReceived) {
    socket.on('message', (data) {
      onMessageReceived(data);
    });
  }

  void dispose() {
    socket.dispose();
  }
}
