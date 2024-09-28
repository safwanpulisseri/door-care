import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/color/app_color.dart';
import '../../../navigation_menu/page/home_navigation_menu.dart';
import '../bloc/bloc/create_conversation_bloc.dart';
import '../data/model/conversation_model.dart';

class ChatPage extends StatefulWidget {
  final ConversationModel conversation;

  const ChatPage({super.key, required this.conversation});

  @override
  createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Dispatch GetAllMessageEvent when the page is initialized
    context.read<CreateConversationBloc>().add(
          GetAllMessageEvent(
            conversationId: widget.conversation.id,
          ),
        );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final messageText = _messageController.text.trim();
    if (messageText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Message cannot be empty'),
        ),
      );
      return;
    }

    // Dispatch the event to the BLoC
    context.read<CreateConversationBloc>().add(
          CreateAMessageEvent(
            conversationId: widget.conversation.id,
            receiverId: widget.conversation.user,
            text: messageText,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    log('Conversation Object: ${widget.conversation.toString()}');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.primary,
        leading: widget.conversation.userProfile.isNotEmpty
            ? Image.network(
                widget.conversation.userProfile,
                height: 40,
                width: 40,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error, color: Colors.red, size: 40);
                },
              )
            : Icon(
                Icons.person,
                color: Colors.white,
                size: 40,
              ),
        title: Text(
          'Chat with ${widget.conversation.user}',
          style: TextStyle(
            color: AppColor.background,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomeNavigationMenu()),
              );
            },
            icon: Icon(
              Icons.cancel,
              color: AppColor.background,
            ),
          ),
        ],
      ),
      body: BlocListener<CreateConversationBloc, CreateConversationState>(
        listener: (context, state) {
          if (state is CreateMessageSuccessState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Message sent successfully!'),
              ),
            );
            _messageController.clear(); // Clear the message field after sending
          } else if (state is CreateConversationFailState) {
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Failed to send message. Please try again.'),
              ),
            );
          }
        },
        child: BlocBuilder<CreateConversationBloc, CreateConversationState>(
          builder: (context, state) {
            if (state is CreateConversationLoadingState) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is GetAllMessagesSuccessState) {
              Navigator.pop(context);
              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.messages.length,
                      itemBuilder: (context, index) {
                        final message = state.messages[index];
                        return ListTile(
                          title: Text(message.text),
                          //subtitle: Text('Sender: ${message.senderId}, '),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _messageController,
                            decoration: InputDecoration(
                              hintText: 'Type a message',
                              border: OutlineInputBorder(),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.send,
                            color: AppColor.primary,
                          ),
                          onPressed: _sendMessage,
                        ),
                      ],
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: Text('Failed to load messages.'),
              );
            }
          },
        ),
      ),
    );
  }
}
