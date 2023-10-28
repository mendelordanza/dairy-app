import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

import '../paywall/paywall_page.dart';

showPaywall(BuildContext context) async {
  try {
    final offerings = await Purchases.getOfferings();
    if (context.mounted && offerings.current != null) {
      await showModalBottomSheet(
        isDismissible: true,
        isScrollControlled: true,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
        ),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
              builder: (BuildContext context, StateSetter setModalState) {
            return PaywallPage(
              offering: offerings.current!,
            );
          });
        },
      );
    }
  } on PlatformException catch (e) {
    print(e.message);
  }
}
