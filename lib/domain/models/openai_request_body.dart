
import 'message.dart';

class OpenAiRequestBody {
  String model;
  List<Message> messages;

  OpenAiRequestBody({
    required this.model,
    required this.messages,
  });

  factory OpenAiRequestBody.fromJson(Map<dynamic, dynamic> json) => OpenAiRequestBody(
    model: json['model'],
    messages: json['messages'],
  );

  dynamic toJson() => {
    'model': model,
    'messages': messages,
  };
}