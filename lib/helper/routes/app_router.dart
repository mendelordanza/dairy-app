import 'package:auto_route/auto_route.dart';

import 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        CustomRoute(
          page: LandingRoute.page,
          initial: true,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        CustomRoute(
          page: BiometricRoute.page,
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
        AutoRoute(page: LoginRoute.page),
        AutoRoute(page: SignUpRoute.page),
        AutoRoute(
          page: OnboardingAddEntryRoute.page,
        ),
        AutoRoute(
          page: OnboardingGenerateQuoteRoute.page,
        ),
        AutoRoute(
          page: SettingsRoute.page,
        ),
        AutoRoute(
          page: SubscribedRoute.page,
        ),
        AutoRoute(
          page: PaywallRoute.page,
        ),
        CustomRoute(
          page: EntryNavigationRoute.page,
          children: [
            AutoRoute(page: HomeRoute.page, initial: true),
            AutoRoute(page: EntryRoute.page),
            AutoRoute(page: AddEntryRoute.page),
            AutoRoute(
              page: GenerateQuoteRoute.page,
            ),
          ],
          transitionsBuilder: TransitionsBuilders.fadeIn,
        ),
      ];
}
