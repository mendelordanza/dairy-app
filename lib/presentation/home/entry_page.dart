import 'package:flutter/material.dart';
import 'package:night_diary/helper/extensions/date_time.dart';

import '../../domain/models/answer.dart';

class EntryPage extends StatelessWidget {
  final Answer answer;

  const EntryPage({required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                children: [
                  if (answer.quote != null)
                    Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Text(
                        '" ${answer.quote} "',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          height: 1.3,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: SelectableText(
                        "${answer.answer}",
                        style: const TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
