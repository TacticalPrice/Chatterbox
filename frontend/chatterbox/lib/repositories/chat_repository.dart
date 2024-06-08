import 'package:chatterbox/models/message.dart';
import 'package:chatterbox/service/api_service.dart';

class ChatRepository{
  final ApiService apiService;

  ChatRepository({required this.apiService});

  Future<List<Message>>fetchMessages(String userId) async{
    try{
      final response = await apiService.get('/messages?userId=$userId');
      final messageData = response.data;
      final List<Message> messages = messageData.map<Message>((data) => Message.fromJson(data)).toList();
      return messages;
    }catch(e){
      throw Exception('Failed to fetch messages: $e');
    }
  }
}