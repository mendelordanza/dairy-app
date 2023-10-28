import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/presentation/entry/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_bloc.dart';

import '../../injection_container.dart';
import '../quote/bloc/quote_event.dart';
import '../widgets/custom_button.dart';

@RoutePage()
class OnboardingGenerateQuotePage extends StatelessWidget {
  final String text;

  const OnboardingGenerateQuotePage({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<QuoteBloc>(),
      child: OnboardingGenerateQuoteView(
        text: text,
      ),
    );
  }
}

class OnboardingGenerateQuoteView extends StatelessWidget {
  final String text;

  const OnboardingGenerateQuoteView({required this.text, super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Image.asset(
            "assets/background.png",
            fit: BoxFit.fill,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: const Text(
              "Your Affirmation",
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: const IconThemeData(
              color: Colors.white,
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(24.0),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                child: Container(
                  padding: const EdgeInsets.all(24.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24.0),
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.grey.withOpacity(0.5),
                        Colors.grey.withOpacity(0.2),
                      ],
                    ),
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
                              CircularProgressIndicator.adaptive(
                                backgroundColor: Colors.white,
                              ),
                              Text(
                                " Please wait.",
                                style: TextStyle(color: Colors.white),
                              ),
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
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_quote_rounded,
                                color: Colors.white,
                              ),
                              Flexible(
                                child: Text(
                                  " Click here to generate affirmation",
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Icon(
                                Icons.format_quote_rounded,
                                color: Colors.white,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody(BuildContext context, {required String quote}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    quote,
                    textStyle: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w600,
                      height: 1.6,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    speed: const Duration(
                      milliseconds: 50,
                    ),
                  ),
                ],
                totalRepeatCount: 1,
                displayFullTextOnTap: true,
                stopPauseOnTap: true,
              ),
            ],
          ),
        ),
        CustomButton(
          backgroundColor: Colors.black,
          foregroundColor: Colors.white,
          onPressed: () {
            context.router.popUntil((route) => route.isFirst);
            context.read<OnboardingBloc>().add(FinishOnboarding());
          },
          child: const Text(
            "I'm ready to use the app!",
          ),
        ),
      ],
    );
  }
}
