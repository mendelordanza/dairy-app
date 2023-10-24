part of 'onboarding_bloc.dart';

@immutable
abstract class OnboardingEvent {}

class LoadOnboardingStatus extends OnboardingEvent {}

class FinishOnboarding extends OnboardingEvent {}

class ToggleOnboarding extends OnboardingEvent {}
