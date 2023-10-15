import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/auth/login_page.dart';
import 'package:night_diary/presentation/auth/sign_up_page.dart';
import 'package:night_diary/presentation/auth/confirmation_page.dart';
import 'package:night_diary/presentation/home/add_entry_page.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/home/entry_page.dart';
import 'package:night_diary/presentation/home/home_page.dart';
import 'package:night_diary/presentation/landing_page.dart';
import 'package:night_diary/presentation/main_page.dart';
import 'package:night_diary/presentation/onboarding/onboarding_add_entry_page.dart';
import 'package:night_diary/presentation/onboarding/onboarding_generate_quote_page.dart';
import 'package:night_diary/presentation/quote/generate_quote_page.dart';
import 'package:night_diary/presentation/settings/settings_page.dart';

import '../domain/models/answer.dart';

class RouteGenerator {
  static RouterConfig<Object>? generateRoute() {
    return GoRouter(
      initialLocation: RouteStrings.main,
      routes: [
        GoRoute(
          name: RouteStrings.main,
          path: RouteStrings.main,
          builder: (context, state) {
            return const MainPage();
          },
        ),
        GoRoute(
          name: RouteStrings.landing,
          path: RouteStrings.landing,
          builder: (context, state) {
            return const LandingPage();
          },
        ),
        GoRoute(
          name: RouteStrings.login,
          path: RouteStrings.login,
          builder: (context, state) {
            return LoginPage();
          },
        ),
        GoRoute(
          name: RouteStrings.home,
          path: RouteStrings.home,
          builder: (context, state) {
            return const HomePage();
          },
        ),
        GoRoute(
          name: RouteStrings.addEntry,
          path: RouteStrings.addEntry,
          builder: (context, state) {
            return BlocProvider.value(
              value: state.extra as EntryBloc,
              child: const AddEntryPage(),
            );
          },
        ),
        GoRoute(
          name: RouteStrings.quote,
          path: RouteStrings.quote,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return BlocProvider.value(
              value: args["entryBloc"] as EntryBloc,
              child: GenerateQuotePage(
                answerId: args["answerId"],
                text: args["prompt"],
              ),
            );
          },
        ),
        GoRoute(
          name: RouteStrings.entry,
          path: RouteStrings.entry,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return EntryPage(
              bloc: args["entryBloc"] as EntryBloc,
              answer: args["answer"] as Answer,
            );
          },
        ),
        GoRoute(
          name: RouteStrings.settings,
          path: RouteStrings.settings,
          builder: (context, state) {
            return SettingsPage();
          },
        ),
        GoRoute(
          name: RouteStrings.signUp,
          path: RouteStrings.signUp,
          builder: (context, state) {
            return SignUpPage();
          },
        ),
        GoRoute(
          name: RouteStrings.confirmation,
          path: RouteStrings.confirmation,
          builder: (context, state) {
            return ConfirmationPage();
          },
        ),
        GoRoute(
          name: RouteStrings.onboardingQuote,
          path: RouteStrings.onboardingQuote,
          builder: (context, state) {
            final args = state.extra as Map<String, dynamic>;
            return OnboardingGenerateQuotePage(
              text: args["prompt"],
            );
          },
        ),
        GoRoute(
          name: RouteStrings.onboardingAddEntry,
          path: RouteStrings.onboardingAddEntry,
          builder: (context, state) {
            return OnboardingAddEntryPage();
          },
        ),
      ],
    );
  }
}
