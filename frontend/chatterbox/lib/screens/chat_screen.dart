import 'package:chatterbox/blocs/chat_bloc.dart';
import 'package:chatterbox/models/message.dart';
import 'package:chatterbox/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  final User user;
  const ChatScreen({super.key, required this.user});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat'),
        ),
        body: BlocProvider(
          create: (context) => ChatBloc(
            chatRepository: RepositoryProvider.of(context),
          )..add(FetchMessageEvent(widget.user.id)),
          child: BlocBuilder<ChatBloc, ChatState>(
            builder: (context, state) {
              if(state is MessagesLoadedState){
                final messages = state.message;
                return ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index){
                    final message = messages[index];
                    return ListTile(
                      title: Text(message.content),
                      subtitle: Text(message.senderId == widget.user.id ? 'Me' : message.senderId),
                    );

                });
              }else if(state is ChatErrorState){
                return Center(
                  child: Text(state.error),
                );
              }else{
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ));
  }
}
