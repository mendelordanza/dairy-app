import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_cubit.dart';

class GenerateQuotePage extends StatelessWidget {
  final String text;

  const GenerateQuotePage({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: BlocBuilder<QuoteCubit, QuoteState>(
        builder: (context, state) {
          if (state is QuoteGenerated) {
            return _buildBody(context, quote: state.quote);
          }
          if (state is QuoteLoading) {
            return const CircularProgressIndicator.adaptive();
          }
          if (state is QuoteError) {
            return Text(state.message);
          }
          return TextButton(
            onPressed: () {
              context.read<QuoteCubit>().generateQuote(prompt: text);
            },
            child: Text("Generate Quote"),
          );
        },
      ),
    );
  }

  Widget _buildBody(BuildContext context, {required String quote}) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '" $quote "',
                  style: const TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
                TextButton(
                  onPressed: () {},
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.share),
                      Text("Share"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextButton(
                onPressed: () {
                  context.read<QuoteCubit>().generateQuote(prompt: text);
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.refresh),
                    Text("Regenerate"),
                  ],
                ),
              ),
              ElevatedButton(
                onPressed: () {},
                child: Text("Save Quote"),
              ),
            ],
          )
        ],
      ),
    );
  }
}
