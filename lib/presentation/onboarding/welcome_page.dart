import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:night_diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:night_diary/presentation/widgets/custom_button.dart';

import '../../helper/route_strings.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Welcome to Dairy!",
                      style: TextStyle(
                        fontSize: 30.0,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    const Text(
                      "Your Diary + Affirmations",
                      style: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    SvgPicture.asset(
                      "assets/ic_logo.svg",
                      height: 200.0,
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Text(
                    "Try it here!  ",
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SvgPicture.asset(
                    "assets/ic_swirl_arrow.svg",
                    height: 50,
                    color: Colors.white,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              CustomButton(
                onPressed: () {
                  context.push(RouteStrings.onboardingAddEntry);
                },
                child: const Text("Let's try it first"),
              ),
              SizedBox(
                height: 10.0,
              ),
              CustomButton(
                onPressed: () {
                  context.read<OnboardingBloc>().add(FinishOnboarding());
                },
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                child: const Text("Skip"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
