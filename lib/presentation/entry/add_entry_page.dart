import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:night_diary/domain/models/answer.dart';
import 'package:night_diary/helper/extensions/date_time.dart';
import 'package:night_diary/helper/routes/app_router.gr.dart';
import 'package:night_diary/presentation/entry/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_event.dart';
import 'package:night_diary/presentation/widgets/custom_button.dart';

import '../purchase/purchase_bloc.dart';
import '../quote/bloc/quote_bloc.dart';
import '../widgets/show_paywall.dart';

@RoutePage()
class AddEntryPage extends StatelessWidget {
  const AddEntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AddEntryView();
  }
}

class AddEntryView extends HookWidget {
  AddEntryView({super.key});

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final answerTextController = useTextEditingController();
    final focusNode = useFocusNode();

    return BlocConsumer<EntryBloc, EntryState>(
      listener: (context, state) {
        if (state is EntryAdded) {
          context.router.push(GenerateQuoteRoute(answer: state.answer));
          context.read<EntryBloc>().add(LoadEntries());
          context.read<QuoteBloc>().add(ResetQuote());
        }
      },
      builder: (context, state) {
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
                              if (value == null || value.isEmpty) {
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
                      if (_formKey.currentState!.validate()) {
                        final answer = Answer(
                          answer: answerTextController.text,
                          updatedAt: DateTime.now(),
                          createdAt: DateTime.now(),
                        );

                        final purchaseState =
                            context.read<PurchaseBloc>().state;
                        final totalGeneratedQuote =
                            context.read<QuoteBloc>().totalGeneratedQuote;
                        context.read<PurchaseBloc>().add(CheckEntitlement());
                        if ((purchaseState is PurchaseLoaded &&
                                purchaseState.premiumEntitled) ||
                            totalGeneratedQuote == 0) {
                          context.read<EntryBloc>().add(AddEntry(answer));
                          context.read<QuoteBloc>().add(ResetCount());
                        } else {
                          showPaywall(context);
                        }
                      }
                    },
                    child: const Text("Next"),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
