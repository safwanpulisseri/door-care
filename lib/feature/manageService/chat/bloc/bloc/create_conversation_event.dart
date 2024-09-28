part of 'create_conversation_bloc.dart';

sealed class CreateConversationEvent extends Equatable {
  const CreateConversationEvent();

  @override
  List<Object> get props => [];
}

final class CreateAConversationEvent extends CreateConversationEvent {
  final String receiverId;
  const CreateAConversationEvent({
    required this.receiverId,
  });
}

final class CreateAMessageEvent extends CreateConversationEvent {
  final String conversationId;
  final String receiverId;
  final String text;
  const CreateAMessageEvent(
      {required this.conversationId,
      required this.receiverId,
      required this.text});
}

final class GetAllMessageEvent extends CreateConversationEvent {
  final String conversationId;
  const GetAllMessageEvent({
    required this.conversationId,
  });
}
