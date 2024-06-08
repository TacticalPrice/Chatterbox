import 'package:chatterbox/blocs/auth_bloc.dart';
import 'package:chatterbox/repositories/auth_repository.dart';
import 'package:chatterbox/repositories/chat_repository.dart';
import 'package:chatterbox/screens/login_screen.dart';
import 'package:chatterbox/service/api_service.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  final Dio dio = Dio(BaseOptions(baseUrl: 'https://yourapi.com'));
  final ApiService apiService = ApiService(dio: dio);
  final AuthRepository authRepository = AuthRepository(apiService: apiService);
  final ChatRepository chatRepository = ChatRepository(apiService: apiService);

  runApp(MyApp(
    authRepository: authRepository,
    chatRepository: chatRepository,
  ));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;
  final ChatRepository chatRepository;
  const MyApp(
      {super.key, required this.authRepository, required this.chatRepository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<AuthRepository>(
              create: (context) => authRepository),
          RepositoryProvider<ChatRepository>(
              create: (context) => chatRepository),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider<AuthBloc>(
                create: (context) => AuthBloc(authRepository: authRepository)),
          ],
          child: MaterialApp(
            title: 'My Chat App',
            theme: ThemeData(
              primarySwatch: Colors.blue,
            ),
            home: LoginScreen(),
          ),
        ));
  }
}
