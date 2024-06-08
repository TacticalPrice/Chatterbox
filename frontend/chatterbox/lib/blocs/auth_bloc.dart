import 'package:bloc/bloc.dart';
import 'package:chatterbox/models/user.dart';
import 'package:chatterbox/repositories/auth_repository.dart';

abstract class AuthEvent{}

class LoginEvent extends AuthEvent{
  final String email;
  final String password;

  LoginEvent(this.email, this.password);
}

class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  SignupEvent(this.name,  this.email, this.password);
  
}

//Define states
abstract class AuthState {}
class InitialAuthState extends AuthState {}

class AuthenticatedState extends AuthState{
  final User user;
  AuthenticatedState(this.user);

}

class AuthenticationErrorState extends AuthState {
  final String error;

  AuthenticationErrorState(this.error);
}

class AuthBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository authRepository;

   AuthBloc({required this.authRepository}) : super(InitialAuthState());

   @override
   Stream<AuthState>mapEventToState(AuthEvent event)  async* {
    if(event is LoginEvent) {
      try{
        final user = await authRepository.login(event.email , event.password);
        yield AuthenticatedState(user);
      }catch(e){
        yield AuthenticationErrorState("Login failed: $e");
      }
    }else if(event is SignupEvent){
      try{
        await authRepository.signup(event.name, event.email, event.password);
        yield InitialAuthState();
      }catch(e){
        yield AuthenticationErrorState('Signup failed: $e');
      }
    }
   }
  
  
}