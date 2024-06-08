import 'package:dio/dio.dart';

class ApiService{
  final Dio dio;

  ApiService({required this.dio});

  Future<Response>post(String path , dynamic data) async{
    try{
      final response = await dio.post(path , data : data);
      return response;
    }catch(e){
       throw Exception('Failed to post : $e'); 
    
  }
  }
  Future<Response>get(String path) async{
    try{
      final response = await dio.get(path);
      return response;
    }catch(e){
      throw Exception('Failed to get data : $e');
    }

  }

  
}