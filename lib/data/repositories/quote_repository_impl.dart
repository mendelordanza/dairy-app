import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:night_diary/domain/repositories/quote_repository.dart';
import 'package:night_diary/helper/data_state.dart';

import '../../config_reader.dart';
import '../../domain/models/completion.dart';
import '../../domain/models/message.dart';
import '../../domain/models/openai_request_body.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final Dio dio;

  QuoteRepositoryImpl(this.dio);

  @override
  Future<DataState<String>> generateQuote({required String prompt}) async {
    try {
      final openAiApiKey = ConfigReader.getOpenAIKey();
      String basicAuth = 'Bearer $openAiApiKey';
      var headers = {
        'Content-Type': 'application/json',
        'Authorization': '$basicAuth'
      };
      final response = await dio.post(
        '/chat/completions',
        options: Options(headers: headers),
        data: jsonEncode(OpenAiRequestBody(
          model: "gpt-4",
          messages: [
            Message(
              role: "system",
              content: "You are a motiviational speaker.",
            ),
            Message(
              role: "user",
              content:
                  "Can you give me advice through a quote that resonates with this"
                  " feeling? In JSON format with quote field only. No prose. No author name."
                  " No redundancy. Translate to english - '$prompt'",
            )
          ],
        ).toJson()),
      );
      if (response.statusCode == 200) {
        final completion = Completion.fromJson(response.data);
        final content =
            completion.choices[0].message.content.replaceAll("\n", "");
        final quote = jsonDecode(content)["quote"] as String;
        return DataSuccess(quote);
      } else {
        return DataFailed(
            error: response.statusMessage ?? "Something went wrong.");
      }
    } on DioException catch (e) {
      return DataFailed(error: e.message ?? "Something went wrong.");
    }
  }
}
