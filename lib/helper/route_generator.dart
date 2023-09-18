import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/home/add_entry_page.dart';
import 'package:night_diary/presentation/landing_page.dart';
import 'package:night_diary/presentation/quote/generate_quote_page.dart';

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
            return const AddEntryPage();
          },
        ),
        GoRoute(
          name: RouteStrings.quote,
          path: RouteStrings.quote,
          builder: (context, state) {
            final prompt = state.extra as String;
            return GenerateQuotePage(
              text: prompt,
            );
          },
        ),
      ],
    );
  }
}
