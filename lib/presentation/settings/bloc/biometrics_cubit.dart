import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../helper/shared_prefs.dart';

part 'biometrics_state.dart';

class BiometricsCubit extends Cubit<BiometricsState> {
  final SharedPrefs sharedPrefs;

  BiometricsCubit({
    required this.sharedPrefs,
  }) : super(BiometricsInitial()) {
    getBiometrics();
  }

  setBiometrics({required bool isEnabled}) {
    sharedPrefs.setBiometricsEnabled(isEnabled);
    emit(BiometricsLoaded(isEnabled));
  }

  getBiometrics() {
    final biometricsEnabled = sharedPrefs.getBiometricsEnabled() ?? false;
    emit(BiometricsLoaded(biometricsEnabled));
  }
}
