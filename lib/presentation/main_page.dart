import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/presentation/landing_page.dart';
import 'package:night_diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:night_diary/presentation/onboarding/welcome_page.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingBloc, OnboardingState>(
      builder: (context, state) {
        if (state is OnboardingLoaded && !state.isFinished) {
          return const WelcomePage();
        } else {
          return const LandingPage();
        }
      },
    );
  }
}
