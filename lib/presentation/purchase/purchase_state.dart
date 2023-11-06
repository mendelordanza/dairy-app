part of 'purchase_bloc.dart';

@immutable
abstract class PurchaseState extends Equatable {
  const PurchaseState();

  @override
  List<Object?> get props => [];
}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final bool onTrial;
  final bool trialEntitled;
  final bool premiumEntitled;
  final EntitlementInfo? info;

  const PurchaseLoaded({
    this.onTrial = false,
    this.trialEntitled = true,
    this.premiumEntitled = false,
    this.info,
  });

  @override
  List<Object?> get props => [
        onTrial,
        trialEntitled,
        premiumEntitled,
        info,
      ];
}
