import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:night_diary/data/datasources/local_data_source.dart';
import 'package:night_diary/domain/models/answer.dart';
import 'package:night_diary/domain/repositories/quote_repository.dart';
import 'package:night_diary/helper/data_state.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../config_reader.dart';
import '../../domain/models/completion.dart';
import '../../domain/models/message.dart';
import '../../domain/models/openai_request_body.dart';

class QuoteRepositoryImpl extends QuoteRepository {
  final Dio dio;
  final LocalDataSource localDataSource;

  final SupabaseClient supabaseClient;

  QuoteRepositoryImpl(
    this.dio,
    this.supabaseClient,
    this.localDataSource,
  );

  @override
  Future<DataState<Map<String, String>>> generateQuote(
      {required String prompt}) async {
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
              content: "You are a psychologist",
            ),
            Message(
              role: "user",
              content:
                  "Can you give me advice in a form of a quote related on the statement below?"
                  " In JSON format with quote field only. No prose. No author name. "
                  "No toxic positivity. No redundancy. 1-3 lines max. Make sure it is in english - '$prompt'",
            )
          ],
        ).toJson()),
      );
      if (response.statusCode == 200) {
        final completion = Completion.fromJson(response.data);
        final content =
            completion.choices[0].message.content.replaceAll("\n", "");
        final quote = jsonDecode(content)["quote"] as String;
        return DataSuccess({"quote": quote});
      } else {
        return DataFailed(
            error: response.statusMessage ?? "Something went wrong.");
      }
    } on DioException catch (e) {
      return DataFailed(error: e.message ?? "Something went wrong.");
    }
  }

  @override
  Future<void> saveQuote(
      {required Answer answer, required String quote}) async {
    await localDataSource.addAnswer(answer: answer.copyWith(quote: quote));
    // await supabaseClient
    //     .from('answers')
    //     .update({'quote': quote}).eq("id", answerId);
  }
}
