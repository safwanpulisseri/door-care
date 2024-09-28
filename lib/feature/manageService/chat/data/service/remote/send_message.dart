import 'dart:convert';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

final String chatApiLink = dotenv.env['CHAT_API_LINK']!;

Future<void> sendMessage(String conversationId, String senderId,
    String receiverId, String text) async {
  final response = await http.post(
    Uri.parse('$chatApiLink/api/chat/message'),
    headers: {'Content-Type': 'application/json'},
    body: json.encode({
      'conversationId': conversationId,
      'senderId': senderId,
      'receiverId': receiverId,
      'text': text,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Failed to send message');
  }
}
