import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:night_diary/presentation/auth/auth_bloc.dart';
import 'package:night_diary/presentation/purchase/purchase_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../paywall/paywall_page.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  _launchUrl(String url) async {
    if (!await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      BlocBuilder<PurchaseBloc, PurchaseState>(
                        builder: (context, state) {
                          return SettingsContainer(
                            padding: const EdgeInsets.only(
                              bottom: 16.0,
                            ),
                            settingItems: [
                              SettingItem(
                                onTap: () async {
                                  showPaywall(context);
                                },
                                icon: SvgPicture.asset("assets/ic_logo.svg"),
                                iconBackgroundColor: const Color(0xFF666666),
                                label:
                                    (state is PurchaseLoaded && state.entitled)
                                        ? "You are subscribed to Dairy Premium!"
                                        : "Unlock Dairy Premium",
                                subtitle:
                                    (state is PurchaseLoaded && state.entitled)
                                        ? null
                                        : "Enjoy unlimited quotes!",
                              ),
                            ],
                          );
                        },
                      ),
                      SettingsContainer(
                        label: "General",
                        settingItems: [
                          SettingItem(
                            onTap: () async {
                              final InAppReview inAppReview =
                                  InAppReview.instance;
                              inAppReview.openStoreListing(
                                appStoreId: "6450363173",
                              );
                            },
                            icon: const Icon(
                              Icons.star,
                              color: Colors.white,
                            ),
                            iconBackgroundColor: const Color(0xFFFFC700),
                            label: "Rate the app",
                          ),
                          const Divider(),
                          SettingItem(
                            onTap: () {
                              _launchUrl(
                                  "https://budgetup.notion.site/BudgetUp-Terms-of-Service-0f0bf474649646eb94f39d562cf9d366?pvs=4");
                            },
                            icon: const Center(
                              child: Icon(
                                Icons.book,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            iconBackgroundColor: const Color(0xFFff7a7a),
                            label: "Terms of Service",
                          ),
                          const Divider(),
                          SettingItem(
                            onTap: () {
                              _launchUrl(
                                  "https://budgetup.notion.site/BudgetUp-Privacy-Policy-e3cf48a7d2ba4661be89963696363918?pvs=4");
                            },
                            icon: const Center(
                              child: Icon(
                                Icons.shield,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            iconBackgroundColor: const Color(0xFF42a68a),
                            label: "Privacy Policy",
                          ),
                        ],
                      ),
                      SettingsContainer(
                        settingItems: [
                          SettingItem(
                            onTap: () {
                              context.read<AuthBloc>().add(LogoutRequest());
                              context.pop();
                            },
                            icon: const Center(
                              child: Icon(
                                Icons.logout,
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                            iconBackgroundColor: Colors.deepOrangeAccent,
                            label: "Logout",
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                "Dairy v1.0.0",
                style: TextStyle(fontSize: 12.0),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}

class SettingsContainer extends StatelessWidget {
  final String? label;
  final List<Widget> settingItems;
  final EdgeInsetsGeometry padding;

  SettingsContainer({
    this.label,
    required this.settingItems,
    this.padding = const EdgeInsets.only(
      bottom: 16.0,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (label != null)
            Text(
              label!,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          const SizedBox(
            height: 10,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                16.0,
              ),
              color: Theme.of(context).cardColor,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: settingItems,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final Function() onTap;
  final Widget? icon;
  final String? iconSize;
  final Color? iconBackgroundColor;
  final String label;
  final String? subtitle;
  final Widget? suffix;

  SettingItem({
    required this.onTap,
    this.icon,
    this.iconSize,
    this.iconBackgroundColor,
    required this.label,
    this.subtitle,
    this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: Row(
          children: [
            if (icon != null && iconBackgroundColor != null)
              Container(
                height: 30.0,
                width: 30.0,
                child: icon,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4.0),
                  color: iconBackgroundColor,
                ),
              ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    label,
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: const TextStyle(
                        fontSize: 12.0,
                      ),
                    ),
                ],
              ),
            ),
            if (suffix != null) suffix!,
          ],
        ),
      ),
    );
  }
}
