import 'package:chatterbox/blocs/auth_bloc.dart';
import 'package:chatterbox/screens/chat_screen.dart';
import 'package:chatterbox/screens/custom_button.dart';
import 'package:chatterbox/screens/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthenticatedState) {
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => ChatScreen(user: state.user)));
          } else if (state is AuthenticationErrorState) {
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.error)));
          }
        },
        builder: (context, state) {
          return Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(labelText: 'Email'),
                ),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(labelText: 'Password'),
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                CustomButton(
                    onPressed: () {
                      final email = emailController.text;
                      final password = passwordController.text;
                      BlocProvider.of<AuthBloc>(context)
                          .add(LoginEvent(email, password));
                    },
                    text: 'Login'),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SignupScreen()));
                    },
                    child: Text('Don\'t have an account? Sign Up'))
              ],
            ),
          );
        },
      ),
    );
  }
}
