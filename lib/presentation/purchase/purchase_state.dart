part of 'purchase_bloc.dart';

abstract class PurchaseState {
  const PurchaseState();
}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final bool entitled;
  final EntitlementInfo info;

  const PurchaseLoaded(
    this.entitled,
    this.info,
  );
}
