// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i16;
import 'package:night_diary/domain/models/answer.dart' as _i15;
import 'package:night_diary/presentation/auth/biometric_page.dart' as _i2;
import 'package:night_diary/presentation/auth/login_page.dart' as _i8;
import 'package:night_diary/presentation/auth/sign_up_page.dart' as _i12;
import 'package:night_diary/presentation/entry/add_entry_page.dart' as _i1;
import 'package:night_diary/presentation/entry/entry_navigation_page.dart'
    as _i3;
import 'package:night_diary/presentation/entry/entry_page.dart' as _i4;
import 'package:night_diary/presentation/entry/home_page.dart' as _i6;
import 'package:night_diary/presentation/landing_page.dart' as _i7;
import 'package:night_diary/presentation/onboarding/onboarding_add_entry_page.dart'
    as _i9;
import 'package:night_diary/presentation/onboarding/onboarding_generate_quote_page.dart'
    as _i10;
import 'package:night_diary/presentation/quote/generate_quote_page.dart' as _i5;
import 'package:night_diary/presentation/settings/settings_page.dart' as _i11;
import 'package:night_diary/presentation/settings/subscribed_page.dart' as _i13;

abstract class $AppRouter extends _i14.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    AddEntryRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.AddEntryPage(),
      );
    },
    BiometricRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i2.BiometricPage(),
      );
    },
    EntryNavigationRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.EntryNavigationPage(),
      );
    },
    EntryRoute.name: (routeData) {
      final args = routeData.argsAs<EntryRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.EntryPage(
          answer: args.answer,
          key: args.key,
        ),
      );
    },
    GenerateQuoteRoute.name: (routeData) {
      final args = routeData.argsAs<GenerateQuoteRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i5.GenerateQuotePage(
          answer: args.answer,
          key: args.key,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HomePage(),
      );
    },
    LandingRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i7.LandingPage(),
      );
    },
    LoginRoute.name: (routeData) {
      final args = routeData.argsAs<LoginRouteArgs>(
          orElse: () => const LoginRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i8.LoginPage(key: args.key),
      );
    },
    OnboardingAddEntryRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.OnboardingAddEntryPage(),
      );
    },
    OnboardingGenerateQuoteRoute.name: (routeData) {
      final args = routeData.argsAs<OnboardingGenerateQuoteRouteArgs>();
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i10.OnboardingGenerateQuotePage(
          text: args.text,
          key: args.key,
        ),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.SettingsPage(),
      );
    },
    SignUpRoute.name: (routeData) {
      final args = routeData.argsAs<SignUpRouteArgs>(
          orElse: () => const SignUpRouteArgs());
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.SignUpPage(key: args.key),
      );
    },
    SubscribedRoute.name: (routeData) {
      return _i14.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SubscribedPage(),
      );
    },
  };
}

/// generated route for
/// [_i1.AddEntryPage]
class AddEntryRoute extends _i14.PageRouteInfo<void> {
  const AddEntryRoute({List<_i14.PageRouteInfo>? children})
      : super(
          AddEntryRoute.name,
          initialChildren: children,
        );

  static const String name = 'AddEntryRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i2.BiometricPage]
class BiometricRoute extends _i14.PageRouteInfo<void> {
  const BiometricRoute({List<_i14.PageRouteInfo>? children})
      : super(
          BiometricRoute.name,
          initialChildren: children,
        );

  static const String name = 'BiometricRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i3.EntryNavigationPage]
class EntryNavigationRoute extends _i14.PageRouteInfo<void> {
  const EntryNavigationRoute({List<_i14.PageRouteInfo>? children})
      : super(
          EntryNavigationRoute.name,
          initialChildren: children,
        );

  static const String name = 'EntryNavigationRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i4.EntryPage]
class EntryRoute extends _i14.PageRouteInfo<EntryRouteArgs> {
  EntryRoute({
    required _i15.Answer answer,
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          EntryRoute.name,
          args: EntryRouteArgs(
            answer: answer,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'EntryRoute';

  static const _i14.PageInfo<EntryRouteArgs> page =
      _i14.PageInfo<EntryRouteArgs>(name);
}

class EntryRouteArgs {
  const EntryRouteArgs({
    required this.answer,
    this.key,
  });

  final _i15.Answer answer;

  final _i16.Key? key;

  @override
  String toString() {
    return 'EntryRouteArgs{answer: $answer, key: $key}';
  }
}

/// generated route for
/// [_i5.GenerateQuotePage]
class GenerateQuoteRoute extends _i14.PageRouteInfo<GenerateQuoteRouteArgs> {
  GenerateQuoteRoute({
    required _i15.Answer answer,
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          GenerateQuoteRoute.name,
          args: GenerateQuoteRouteArgs(
            answer: answer,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'GenerateQuoteRoute';

  static const _i14.PageInfo<GenerateQuoteRouteArgs> page =
      _i14.PageInfo<GenerateQuoteRouteArgs>(name);
}

class GenerateQuoteRouteArgs {
  const GenerateQuoteRouteArgs({
    required this.answer,
    this.key,
  });

  final _i15.Answer answer;

  final _i16.Key? key;

  @override
  String toString() {
    return 'GenerateQuoteRouteArgs{answer: $answer, key: $key}';
  }
}

/// generated route for
/// [_i6.HomePage]
class HomeRoute extends _i14.PageRouteInfo<void> {
  const HomeRoute({List<_i14.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LandingPage]
class LandingRoute extends _i14.PageRouteInfo<void> {
  const LandingRoute({List<_i14.PageRouteInfo>? children})
      : super(
          LandingRoute.name,
          initialChildren: children,
        );

  static const String name = 'LandingRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LoginPage]
class LoginRoute extends _i14.PageRouteInfo<LoginRouteArgs> {
  LoginRoute({
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          LoginRoute.name,
          args: LoginRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'LoginRoute';

  static const _i14.PageInfo<LoginRouteArgs> page =
      _i14.PageInfo<LoginRouteArgs>(name);
}

class LoginRouteArgs {
  const LoginRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'LoginRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.OnboardingAddEntryPage]
class OnboardingAddEntryRoute extends _i14.PageRouteInfo<void> {
  const OnboardingAddEntryRoute({List<_i14.PageRouteInfo>? children})
      : super(
          OnboardingAddEntryRoute.name,
          initialChildren: children,
        );

  static const String name = 'OnboardingAddEntryRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i10.OnboardingGenerateQuotePage]
class OnboardingGenerateQuoteRoute
    extends _i14.PageRouteInfo<OnboardingGenerateQuoteRouteArgs> {
  OnboardingGenerateQuoteRoute({
    required String text,
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          OnboardingGenerateQuoteRoute.name,
          args: OnboardingGenerateQuoteRouteArgs(
            text: text,
            key: key,
          ),
          initialChildren: children,
        );

  static const String name = 'OnboardingGenerateQuoteRoute';

  static const _i14.PageInfo<OnboardingGenerateQuoteRouteArgs> page =
      _i14.PageInfo<OnboardingGenerateQuoteRouteArgs>(name);
}

class OnboardingGenerateQuoteRouteArgs {
  const OnboardingGenerateQuoteRouteArgs({
    required this.text,
    this.key,
  });

  final String text;

  final _i16.Key? key;

  @override
  String toString() {
    return 'OnboardingGenerateQuoteRouteArgs{text: $text, key: $key}';
  }
}

/// generated route for
/// [_i11.SettingsPage]
class SettingsRoute extends _i14.PageRouteInfo<void> {
  const SettingsRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SignUpPage]
class SignUpRoute extends _i14.PageRouteInfo<SignUpRouteArgs> {
  SignUpRoute({
    _i16.Key? key,
    List<_i14.PageRouteInfo>? children,
  }) : super(
          SignUpRoute.name,
          args: SignUpRouteArgs(key: key),
          initialChildren: children,
        );

  static const String name = 'SignUpRoute';

  static const _i14.PageInfo<SignUpRouteArgs> page =
      _i14.PageInfo<SignUpRouteArgs>(name);
}

class SignUpRouteArgs {
  const SignUpRouteArgs({this.key});

  final _i16.Key? key;

  @override
  String toString() {
    return 'SignUpRouteArgs{key: $key}';
  }
}

/// generated route for
/// [_i13.SubscribedPage]
class SubscribedRoute extends _i14.PageRouteInfo<void> {
  const SubscribedRoute({List<_i14.PageRouteInfo>? children})
      : super(
          SubscribedRoute.name,
          initialChildren: children,
        );

  static const String name = 'SubscribedRoute';

  static const _i14.PageInfo<void> page = _i14.PageInfo<void>(name);
}
