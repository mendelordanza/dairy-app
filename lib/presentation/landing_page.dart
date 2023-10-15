import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/helper/route_strings.dart';
import 'package:night_diary/presentation/auth/auth_bloc.dart';
import 'package:night_diary/presentation/auth/login_page.dart';
import 'package:night_diary/presentation/home/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state.status == AuthStatus.needConfirmation) {
          context.pop();
          context.push(RouteStrings.confirmation);
        }
      },
      builder: (context, state) {
        if (state.status == AuthStatus.authenticated) {
          return const HomePage();
        }
        return LoginPage();
      },
    );
  }
}
