import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:night_diary/helper/extensions/date_time.dart';

import '../../domain/models/answer.dart';
import '../quote/bloc/quote_bloc.dart';
import '../quote/bloc/quote_event.dart';
import '../widgets/custom_button.dart';
import 'bloc/entry_bloc.dart';

class EntryPage extends StatelessWidget {
  final Answer answer;
  final EntryBloc bloc;
  final QuoteBloc quoteBloc;

  const EntryPage(
      {required this.quoteBloc,
      required this.bloc,
      required this.answer,
      super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider.value(
          value: bloc,
        ),
        BlocProvider.value(
          value: quoteBloc,
        ),
      ],
      child: EntryView(answer: answer),
    );
  }
}

class EntryView extends HookWidget {
  final Answer answer;
  final _formKey = GlobalKey<FormState>();

  EntryView({required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
    final isEditMode = useState(false);
    final answerTextController = useTextEditingController();

    useEffect(() {
      answerTextController.text = answer.answer ?? "";
      return null;
    }, [isEditMode]);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          DateTime.now().formatDate(pattern: "MMM. dd, yyyy - H:mm a"),
        ),
        actions: [
          IconButton(
            onPressed: () {
              isEditMode.value = !isEditMode.value;
            },
            icon: const Icon(Icons.edit),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                width: double.infinity,
                child: isEditMode.value
                    ? Form(
                        key: _formKey,
                        child: TextFormField(
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
                          validator: (value) {
                            if (value == null) {
                              return "Please add an entry";
                            }
                            return null;
                          },
                        ),
                      )
                    : SelectableText(
                        "${answer.answer}",
                        style: const TextStyle(
                          height: 1.5,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
              ),
            ),
            if (isEditMode.value)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: CustomButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final newAnswer = answer.copyWith(
                        answer: answerTextController.text,
                        updatedAt: DateTime.now(),
                        createdAt: DateTime.now(),
                      );
                      context.read<EntryBloc>().add(EditEntry(newAnswer));
                      context.read<QuoteBloc>().add(ResetQuote());
                    }
                  },
                  child: const Text("Save"),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
