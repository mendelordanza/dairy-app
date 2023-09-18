class Message {
  String role;
  String content;

  Message({
    required this.role,
    required this.content,
  });

  factory Message.fromJson(Map<dynamic, dynamic> json) => Message(
    role: json['role'],
    content: json['content'],
  );

  dynamic toJson() => {
    'role': role,
    'content': content,
  };
}
