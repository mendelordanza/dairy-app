import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:night_diary/helper/extensions/date_time.dart';
import 'package:night_diary/helper/routes/app_router.gr.dart';
import 'package:night_diary/presentation/widgets/custom_button.dart';


@RoutePage()
class OnboardingAddEntryPage extends StatelessWidget {
  const OnboardingAddEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return OnboardingAddEntryView();
  }
}

class OnboardingAddEntryView extends HookWidget {
  OnboardingAddEntryView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final answerTextController = useTextEditingController();
    final focusNode = useFocusNode();

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(
          DateTime.now().formatDate(pattern: "MMM. dd, yyyy - H:mm a"),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
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
                    const SizedBox(
                      height: 16.0,
                    ),
                    Form(
                      key: _formKey,
                      child: TextFormField(
                        focusNode: focusNode,
                        controller: answerTextController,
                        maxLines: null,
                        autofocus: true,
                        textCapitalization: TextCapitalization.sentences,
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
                    ),
                  ],
                ),
              ),
              CustomButton(
                onPressed: () {
                  focusNode.unfocus();
                  context.router.push(OnboardingGenerateQuoteRoute(
                      text: answerTextController.text));
                },
                child: const Text("Next"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
