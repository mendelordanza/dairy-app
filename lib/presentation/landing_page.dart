import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/helper/routes/app_router.gr.dart';
import 'package:night_diary/presentation/auth/bloc/local_auth_cubit.dart';
import 'package:night_diary/presentation/splash_page.dart';

@RoutePage()
class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LocalAuthCubit, LocalAuthState>(
      listener: (context, state) {
        if (state is LocalAuthSuccess || state is LocalAuthBiometricsDisabled) {
          context.router.replace(const HomeRoute());
        } else {
          context.router.replace(const BiometricRoute());
        }
      },
      builder: (context, state) {
        return const SplashPage();
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
