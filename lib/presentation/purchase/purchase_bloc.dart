import 'package:bloc/bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../helper/constants.dart';

part 'purchase_event.dart';

part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(PurchaseInitial()) {
    on<CheckEntitlement>(checkEntitlement);

    add(CheckEntitlement());
  }

  checkEntitlement(event, emit) async {
    final customerInfo = await Purchases.getCustomerInfo();
    final onTrial = customerInfo.entitlements.active.values
        .any((element) => element.periodType == PeriodType.trial);
    final trialEntitled = customerInfo.entitlements.all.values
        .any((element) => element.periodType != PeriodType.trial);
    final premiumEntitled = (customerInfo.entitlements.active[entitlementId] !=
            null &&
        customerInfo.entitlements.active[entitlementId]!.isSandbox == false);
    emit(PurchaseLoaded(
      onTrial,
      trialEntitled,
      premiumEntitled,
      customerInfo.entitlements.active[entitlementId] as EntitlementInfo,
    ));
  }
}
