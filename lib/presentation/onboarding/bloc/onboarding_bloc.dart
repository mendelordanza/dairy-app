import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../helper/shared_prefs.dart';

part 'onboarding_event.dart';

part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  final SharedPrefs sharedPrefs;

  OnboardingBloc({
    required this.sharedPrefs,
  }) : super(OnboardingInitial()) {
    on<LoadOnboardingStatus>((event, emit) {
      final isFinished = sharedPrefs.getFinishedOnboarding() ?? false;
      emit(OnboardingLoaded(isFinished));
    });
    on<FinishOnboarding>((event, emit) {
      sharedPrefs.setFinishedOnboarding(true);
      emit(OnboardingLoaded(true));
    });

    add(LoadOnboardingStatus());
  }
}
