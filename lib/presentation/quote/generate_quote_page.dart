import 'dart:io';
import 'dart:ui';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:auto_route/annotations.dart';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/presentation/entry/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/purchase/purchase_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_bloc.dart';
import 'package:night_diary/presentation/widgets/screenshot_widget.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';

import '../../domain/models/answer.dart';
import '../widgets/share_sheet.dart';
import '../widgets/show_paywall.dart';
import 'bloc/quote_event.dart';

@RoutePage()
class GenerateQuotePage extends StatelessWidget {
  final Answer answer;

  const GenerateQuotePage({required this.answer, super.key});

  @override
  Widget build(BuildContext context) {
    return GenerateQuoteView(
      answer: answer,
    );
  }
}

class GenerateQuoteView extends StatelessWidget {
  final Answer answer;

  final screenshotController = ScreenshotController();

  GenerateQuoteView({required this.answer, super.key});

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
                        context.router.popUntil((route) => route.isFirst);
                      }
                    },
                    builder: (context, state) {
                      if (state is QuoteGenerated) {
                        return _buildBody(
                          context,
                          quote: state.quote,
                          author: state.author,
                        );
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
                            context
                                .read<PurchaseBloc>()
                                .add(CheckEntitlement());
                            final purchaseState =
                                context.read<PurchaseBloc>().state;
                            final totalCount =
                                context.read<QuoteBloc>().totalGeneratedQuote;
                            if ((purchaseState is PurchaseLoaded &&
                                    purchaseState.premiumEntitled) ||
                                totalCount == 0) {
                              context
                                  .read<QuoteBloc>()
                                  .add(GenerateQuote(answer.answer ?? ""));
                            } else {
                              showPaywall(context);
                            }
                          },
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.format_quote_rounded,
                              ),
                              Flexible(
                                child: Text(
                                  "Click here to generate affirmation",
                                  textAlign: TextAlign.center,
                                ),
                              ),
                              Icon(
                                Icons.format_quote_rounded,
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

  Widget _buildBody(
    BuildContext context, {
    required String quote,
    required String author,
  }) {
    final totalGeneratedQuote = context.read<QuoteBloc>().totalGeneratedQuote;
    return Column(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Icon(
                    Icons.format_quote_rounded,
                  ),
                  AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        quote,
                        textStyle: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w600,
                          height: 1.6,
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
                  const Icon(
                    Icons.format_quote_rounded,
                  ),
                ],
              ),
              const SizedBox(
                height: 16.0,
              ),
              TextButton(
                onPressed: () {
                  screenshotController
                      .captureFromWidget((ScreenshotWidget(
                    quote: quote,
                    author: author,
                  )))
                      .then((image) async {
                    final tempDir = await getTemporaryDirectory();
                    File file =
                        await File('${tempDir.path}/image.png').create();
                    file.writeAsBytesSync(image);

                    if (context.mounted) {
                      showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return ShareSheet(
                              imagePath: file.path,
                            );
                          });
                    }
                  });
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.share,
                    ),
                    Text(
                      " Share",
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            BlocConsumer<PurchaseBloc, PurchaseState>(
              listener: (context, state) {
                if ((state is PurchaseLoaded && !state.premiumEntitled) &&
                    totalGeneratedQuote == 1) {
                  showPaywall(context);
                }
              },
              builder: (context, state) {
                return TextButton(
                  onPressed: () async {
                    context.read<PurchaseBloc>().add(CheckEntitlement());
                    if ((state is PurchaseLoaded && state.premiumEntitled) ||
                        totalGeneratedQuote == 0) {
                      context
                          .read<QuoteBloc>()
                          .add(GenerateQuote(answer.answer ?? ""));
                    } else {
                      showPaywall(context);
                    }
                  },
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.refresh,
                      ),
                      Text(
                        " Regenerate",
                      ),
                    ],
                  ),
                );
              },
            ),
            TextButton(
              onPressed: () {
                context.read<QuoteBloc>().add(
                      SaveQuote(
                        answer,
                        quote,
                      ),
                    );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.save,
                  ),
                  Text(
                    " Save",
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
