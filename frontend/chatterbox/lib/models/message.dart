class Message {
  final String id;
  final String senderId;
  final String receiverId;
  final String content;

  Message({required this.id, required this.senderId, required this.receiverId, required this.content});

  factory Message.fromJson(Map<String , dynamic> json){
    return Message(
      id : json['id'],
      senderId: json['senderId'],
      receiverId: json['receiverId'],
      content : json['content'],
    );
  }
}
