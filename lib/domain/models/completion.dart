import 'message.dart';

class Completion {
  String id;
  List<Choice> choices;

  Completion({
    required this.id,
    required this.choices,
  });

  factory Completion.fromJson(Map<dynamic, dynamic> json) => Completion(
    id: json['id'],
    choices: List<Choice>.from(
        json["choices"].map((choice) => Choice.fromJson(choice))),
  );

  dynamic toJson() => {
    'id': id,
    'text': choices,
  };
}

class Choice {
  Message message;

  Choice({
    required this.message,
  });

  factory Choice.fromJson(Map<dynamic, dynamic> json) => Choice(
    message: Message.fromJson(json['message']),
  );

  dynamic toJson() => {
    'message': message,
  };
}