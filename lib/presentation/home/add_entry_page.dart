import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/domain/models/answer.dart';
import 'package:night_diary/domain/models/diary_entry.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';

class AddEntryPage extends HookWidget {
  const AddEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final answerTextController = useTextEditingController();
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Text("How was your day?"),
            TextField(
              controller: answerTextController,
            ),
            ElevatedButton(
              onPressed: () {
                final answer = Answer(
                  question: "How was your day?",
                  answer: answerTextController.text,
                );
                final diaryEntry = DiaryEntry(
                  answers: [answer],
                  updatedAt: DateTime.now(),
                  createdAt: DateTime.now(),
                );
                context.read<EntryBloc>().add(AddEntry(diaryEntry));
                context.pushNamed(
                  RouteStrings.quote,
                  extra: answerTextController.text,
                );
              },
              child: Text("Next"),
            ),
          ],
        ),
      ),
    );
  }
}
