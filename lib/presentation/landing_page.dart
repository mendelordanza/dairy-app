import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/presentation/auth/biometric_page.dart';
import 'package:night_diary/presentation/auth/bloc/local_auth_cubit.dart';
import 'package:night_diary/presentation/home/home_page.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalAuthCubit, LocalAuthState>(
      builder: (context, state) {
        if (state is LocalAuthSuccess || state is LocalAuthBiometricsDisabled) {
          return const HomePage();
        }
        return const BiometricPage();
      },
    );

    // return BlocConsumer<AuthBloc, AuthState>(
    //   listener: (context, state) {
    //     if (state.status == AuthStatus.needConfirmation) {
    //       context.pop();
    //       context.push(RouteStrings.confirmation);
    //     }
    //   },
    //   builder: (context, state) {
    //     if (state.status == AuthStatus.authenticated) {
    //       return const HomePage();
    //     }
    //     return LoginPage();
    //   },
    // );
  }
}
