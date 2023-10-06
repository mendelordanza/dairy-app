part of 'purchase_bloc.dart';

abstract class PurchaseState {
  const PurchaseState();
}

class PurchaseInitial extends PurchaseState {}

class PurchaseLoaded extends PurchaseState {
  final bool entitled;

  const PurchaseLoaded(this.entitled);
}
