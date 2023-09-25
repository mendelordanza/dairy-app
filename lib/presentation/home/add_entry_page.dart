import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/domain/models/answer.dart';
import 'package:night_diary/helper/extensions/date_time.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';

import '../../helper/route_strings.dart';

class AddEntryPage extends HookWidget {
  const AddEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final answerTextController = useTextEditingController();
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title:
            Text(DateTime.now().formatDate(pattern: "MMM. dd, yyyy - H:mm a")),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    const Text(
                      "How are you today?",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w600,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Expanded(
                      child: TextField(
                        controller: answerTextController,
                        maxLines: null,
                        autofocus: true,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Write your thoughts...',
                        ),
                        style: const TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ElevatedButton(
                onPressed: () {
                  final answer = Answer(
                    answer: answerTextController.text,
                    updatedAt: DateTime.now(),
                    createdAt: DateTime.now(),
                  );
                  context.read<EntryBloc>().add(AddEntry(answer));
                  context.pushReplacementNamed(
                    RouteStrings.quote,
                    extra: answerTextController.text,
                  );
                },
                child: const Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
