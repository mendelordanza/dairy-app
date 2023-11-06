import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:night_diary/helper/routes/app_router.gr.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

showPaywall(BuildContext context) async {
  try {
    final offerings = await Purchases.getOfferings();
    if (context.mounted && offerings.current != null) {
      context.router.push(PaywallRoute(offering: offerings.current!));
    }
  } on PlatformException catch (e) {
    print(e.message);
  }
}
