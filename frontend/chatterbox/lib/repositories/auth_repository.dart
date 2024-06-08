import 'package:chatterbox/models/user.dart';
import 'package:chatterbox/service/api_service.dart';

class AuthRepository{
  final ApiService apiService;

  AuthRepository({required this.apiService});

  Future<User>login(String email , String password) async{
    try{
      final response = await apiService.post('/login', {'email' : email, 'password' : password});
      final userData = response.data;
      final user = User.fromJson(userData);
      return user;
    }catch(e){
      throw Exception('Failed to login: $e');
    }
  }

  Future<void> signup(String name, String email , String password) async{
    try{
      await apiService.post('/signup', {
        'name' : name,
        'email' : email,
        'password' : password,
      });
    }catch(e){
      throw Exception('Failed to signup : $e');
    }
  }

}