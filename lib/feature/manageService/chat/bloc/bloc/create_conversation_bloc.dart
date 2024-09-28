import 'dart:developer';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../data/model/conversation_model.dart';
import '../../data/model/get_all_message_model.dart';
import '../../data/repository/createConversationRepo.dart';
part 'create_conversation_event.dart';
part 'create_conversation_state.dart';

class CreateConversationBloc
    extends Bloc<CreateConversationEvent, CreateConversationState> {
  final Createconversationrepo _createconversationrepo;
  CreateConversationBloc(this._createconversationrepo)
      : super(CreateConversationInitialState()) {
    on<CreateAConversationEvent>((event, emit) async {
      emit(CreateConversationLoadingState());
      try {
        final ConversationModel conversationModel =
            await _createconversationrepo.createConversationWithUser(
          receiverId: event.receiverId,
        );

        emit(CreateConversationSuccessState(
            conversationModel: conversationModel));
      } catch (e) {
        log(e.toString());
        emit(CreateConversationFailState());
      }
    });
    on<CreateAMessageEvent>(
      (event, emit) async {
        emit(CreateConversationLoadingState());
        try {
          var response = await _createconversationrepo.createMessageWithUser(
            conversationId: event.conversationId,
            receiverId: event.receiverId,
            text: event.text,
          );
          if (response.statusCode == 200) {
            emit(CreateMessageSuccessState());
          } else {
            emit(CreateConversationFailState());
            log('createMessageWithUser failed: ${response.statusCode}');
            throw Exception('createMessageWithUserfailed');
          }
        } catch (e) {
          log(e.toString());
          emit(CreateConversationFailState());
        }
      },
    );
    on<GetAllMessageEvent>(
      (event, emit) async {
        emit(CreateConversationLoadingState());
        try {
          final List<GetAllMessageModel> getAllMessageModel =
              await _createconversationrepo.getAllMessage(
            conversationId: event.conversationId,
          );

          emit(GetAllMessagesSuccessState(messages: getAllMessageModel));
        } catch (e) {
          log(e.toString());
          emit(CreateConversationFailState());
        }
      },
    );
  }
}
