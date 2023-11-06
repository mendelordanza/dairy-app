import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../../helper/constants.dart';

part 'purchase_event.dart';

part 'purchase_state.dart';

class PurchaseBloc extends Bloc<PurchaseEvent, PurchaseState> {
  PurchaseBloc() : super(const PurchaseLoaded()) {
    on<CheckEntitlement>(checkEntitlement);

    init();
  }

  init() {
    add(CheckEntitlement());
  }

  checkEntitlement(CheckEntitlement event, emit) async {
    final customerInfo = await Purchases.getCustomerInfo();
    final onTrial = customerInfo.entitlements.active.values.any((element) =>
        element.identifier == entitlementId &&
        element.periodType == PeriodType.trial &&
        element.isActive &&
        !element.isSandbox);
    final trialEntitled = customerInfo.entitlements.all.values
        .where((element) =>
            element.periodType.name.contains(PeriodType.trial.name))
        .isEmpty;
    final premiumEntitled = customerInfo.entitlements.active.values.any(
        (element) =>
            element.identifier == entitlementId &&
            element.periodType == PeriodType.normal &&
            element.isActive &&
            !element.isSandbox);
    emit(PurchaseLoaded(
      onTrial: onTrial,
      trialEntitled: trialEntitled,
      premiumEntitled: premiumEntitled,
      info: customerInfo.entitlements.active[entitlementId] as EntitlementInfo,
    ));
  }
}
