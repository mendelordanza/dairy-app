import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_cubit.dart';

class GenerateQuotePage extends StatelessWidget {
  final String text;

  const GenerateQuotePage({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            BlocBuilder<QuoteCubit, QuoteState>(builder: (context, state) {
              if (state is QuoteGenerated) {
                return Text(state.quote);
              }
              if (state is QuoteLoading) {
                return const CircularProgressIndicator.adaptive();
              }
              if (state is QuoteError) {
                return Text(state.message);
              }
              return Container();
            }),
            ElevatedButton(
              onPressed: () {
                context.read<QuoteCubit>().generateQuote(prompt: text);
              },
              child: Text("Generate Quote"),
            )
          ],
        ),
      ),
    );
  }
}
