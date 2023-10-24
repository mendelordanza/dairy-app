import 'package:bloc/bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../helper/constants.dart';

part 'purchase_event.dart';

part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseInitial()) {
    on<CheckEntitlement>(checkEntitlement);
  }

  checkEntitlement(event, emit) async {
    final customerInfo = await Purchases.getCustomerInfo();
    final entitled = (customerInfo.entitlements.active[entitlementId] != null &&
        customerInfo.entitlements.active[entitlementId]!.isSandbox == false);
    emit(PurchaseLoaded(
      entitled,
      customerInfo.entitlements.active[entitlementId] as EntitlementInfo,
    ));
  }
}
