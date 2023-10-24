part of 'biometrics_cubit.dart';

@immutable
abstract class BiometricsState {}

class BiometricsInitial extends BiometricsState {}

class BiometricsLoaded extends BiometricsState {
  final bool isBiometricsEnabled;

  BiometricsLoaded(this.isBiometricsEnabled);
}
