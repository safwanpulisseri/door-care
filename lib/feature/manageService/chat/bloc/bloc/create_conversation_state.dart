part of 'create_conversation_bloc.dart';

sealed class CreateConversationState extends Equatable {
  const CreateConversationState();

  @override
  List<Object> get props => [];
}

final class CreateConversationInitialState extends CreateConversationState {}

final class CreateConversationLoadingState extends CreateConversationState {}

final class CreateConversationSuccessState extends CreateConversationState {
  final ConversationModel conversationModel;
  const CreateConversationSuccessState({
    required this.conversationModel,
  });
}

final class CreateConversationFailState extends CreateConversationState {}

final class CreateMessageSuccessState extends CreateConversationState {}

final class GetAllMessagesSuccessState extends CreateConversationState {
  final List<GetAllMessageModel> messages;
  const GetAllMessagesSuccessState({
    required this.messages,
  });
}
