import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/home/add_entry_page.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/home/entry_page.dart';
import 'package:night_diary/presentation/landing_page.dart';
import 'package:night_diary/presentation/quote/generate_quote_page.dart';
import 'package:night_diary/presentation/settings/settings_page.dart';

import '../domain/models/answer.dart';

class RouteGenerator {
  static RouterConfig<Object>? generateRoute() {
    return GoRouter(
      routes: [
        GoRoute(
          name: RouteStrings.landing,
          path: RouteStrings.landing,
          builder: (context, state) {
            return const LandingPage();
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
      ],
    );
  }
}
