import 'package:bloc/bloc.dart';
import 'package:local_auth/local_auth.dart';
import 'package:meta/meta.dart';
import 'package:night_diary/helper/shared_prefs.dart';

part 'local_auth_state.dart';

class LocalAuthCubit extends Cubit<LocalAuthState> {
  final SharedPrefs sharedPrefs;
  final LocalAuthentication localAuthentication;

  LocalAuthCubit({
    required this.localAuthentication,
    required this.sharedPrefs,
  }) : super(LocalAuthInitial()) {
    checkBiometrics();
  }

  checkBiometrics() {
    final biometricsEnabled = sharedPrefs.getBiometricsEnabled() ?? false;
    if (!biometricsEnabled) {
      emit(LocalAuthBiometricsDisabled());
    }
  }

  enableBiometrics() async {
    final biometricsEnabled = sharedPrefs.getBiometricsEnabled() ?? false;
    await sharedPrefs.setBiometricsEnabled(!biometricsEnabled);
  }

  authenticate() async {
    final availableBiometrics =
        await localAuthentication.getAvailableBiometrics();
    if (availableBiometrics.isNotEmpty) {
      final isAuthenticated = await localAuthentication.authenticate(
        localizedReason: "Authenticate to open the app",
        options: const AuthenticationOptions(
            useErrorDialogs: true, stickyAuth: true),
      );
      if (isAuthenticated) {
        emit(LocalAuthSuccess());
      } else {
        emit(LocalAuthFailure());
      }
    }
  }
}
