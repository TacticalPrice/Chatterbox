import 'package:bloc/bloc.dart';
import 'package:chatterbox/models/message.dart';
import 'package:chatterbox/repositories/chat_repository.dart';

abstract class ChatEvent {}

class FetchMessageEvent extends ChatEvent {
  final String userId;

  FetchMessageEvent(this.userId);
}

abstract class ChatState {}

class InitialChatState extends ChatState {}

class MessagesLoadedState extends ChatState {
  final List<Message>message;

  MessagesLoadedState(this.message);
}

class ChatErrorState extends ChatState {
  final String error;
  ChatErrorState(this.error);
}

class ChatBloc extends Bloc<ChatEvent, ChatState> {
  final ChatRepository chatRepository;

  ChatBloc({required this.chatRepository}) : super(InitialChatState());

  @override 
  Stream<ChatState>mapEventToState(ChatEvent event) async*{
    if(event is FetchMessageEvent){
        try{
          final messages = await chatRepository.fetchMessages(event.userId);
          yield MessagesLoadedState(messages);
        }catch(e){
          yield ChatErrorState('Failed to fetch messages: $e');
        }
    }
  }
}