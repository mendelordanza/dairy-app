import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_bloc.dart';

import '../../injection_container.dart';
import 'bloc/quote_event.dart';

class GenerateQuotePage extends StatelessWidget {
  final int answerId;
  final String text;

  const GenerateQuotePage(
      {required this.answerId, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<QuoteBloc>(),
        ),
      ],
      child: GenerateQuoteView(
        answerId: answerId,
        text: text,
      ),
    );
  }
}

class GenerateQuoteView extends StatelessWidget {
  final int answerId;
  final String text;

  const GenerateQuoteView(
      {required this.answerId, required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Text("Your Quote"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Container(
          padding: const EdgeInsets.all(24.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(24.0),
            color: Theme.of(context).cardColor,
          ),
          child: BlocConsumer<QuoteBloc, QuoteState>(
            listener: (context, state) {
              if (state is QuoteSaved) {
                context.read<EntryBloc>().add(LoadEntries());
              }
            },
            builder: (context, state) {
              if (state is QuoteGenerated) {
                return _buildBody(context, quote: state.quote);
              }
              if (state is QuoteLoading) {
                return const Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircularProgressIndicator.adaptive(),
                      Text(" Please wait."),
                    ],
                  ),
                );
              }
              if (state is QuoteError) {
                return Text(state.message);
              }
              return Center(
                child: TextButton(
                  onPressed: () {
                    context.read<QuoteBloc>().add(GenerateQuote(text));
                  },
                  child: const Text("Generate Quote"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context, {required String quote}) {
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '" $quote "',
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextButton(
                onPressed: () {},
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.share),
                    Text(" Share"),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            TextButton(
              onPressed: () {
                context.read<QuoteBloc>().add(GenerateQuote(text));
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.refresh),
                  Text(" Regenerate"),
                ],
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<QuoteBloc>().add(
                      SaveQuote(
                        answerId,
                        quote,
                      ),
                    );
                context.go(RouteStrings.landing);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.save),
                  Text(" Save"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
