part of 'purchase_bloc.dart';

abstract class PurchaseEvent {
  const PurchaseEvent();
}

class CheckEntitlement extends PurchaseEvent {
}
