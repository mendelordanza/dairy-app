import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:night_diary/helper/routes/app_router.gr.dart';
import 'package:night_diary/presentation/auth/bloc/auth_bloc.dart';
import 'package:night_diary/presentation/auth/bloc/local_auth_cubit.dart';
import 'package:night_diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:night_diary/presentation/purchase/purchase_bloc.dart';
import 'package:night_diary/presentation/settings/bloc/biometrics_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/show_paywall.dart';

@RoutePage()
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
                                onTap: () {
                                  if (state is PurchaseLoaded &&
                                      state.premiumEntitled) {
                                    context.router
                                        .push(const SubscribedRoute());
                                  } else {
                                    showPaywall(context);
                                  }
                                },
                                icon: SvgPicture.asset("assets/ic_logo.svg"),
                                iconBackgroundColor: const Color(0xFF666666),
                                label: (state is PurchaseLoaded &&
                                        state.premiumEntitled)
                                    ? "You are subscribed to Dairy Premium!"
                                    : (state is PurchaseLoaded && state.onTrial)
                                        ? "You are currently on 7-day free trial"
                                        : "Unlock Dairy Premium",
                                subtitle: "Enjoy unlimited affirmations!",
                              ),
                            ],
                          );
                        },
                      ),
                      BlocBuilder<BiometricsCubit, BiometricsState>(
                          builder: (context, state) {
                        if (state is BiometricsLoaded) {
                          return SettingsContainer(
                            label: "App",
                            settingItems: [
                              SettingItem(
                                onTap: () async {},
                                icon: const Icon(
                                  Icons.fingerprint,
                                  color: Colors.white,
                                ),
                                iconBackgroundColor: const Color(0xFFFFC700),
                                label: "Biometrics",
                                suffix: Switch(
                                  value: state.isBiometricsEnabled,
                                  onChanged: (value) {
                                    context
                                        .read<BiometricsCubit>()
                                        .setBiometrics(
                                            isEnabled:
                                                !state.isBiometricsEnabled);
                                    context
                                        .read<LocalAuthCubit>()
                                        .authenticate();
                                  },
                                ),
                              ),
                            ],
                          );
                        }
                        return Container();
                      }),
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
                                  "https://www.notion.so/dairyapp/Dairy-Terms-and-Conditions-0bb60f6f72d44af89be4db736e852533?pvs=4");
                            },
                            icon: const Center(
                              child: Icon(
                                Icons.book,
                                size: 15,
                                color: Colors.white,
                              ),
                            ),
                            iconBackgroundColor: const Color(0xFFff7a7a),
                            label: "Terms and Conditions",
                          ),
                          const Divider(),
                          SettingItem(
                            onTap: () {
                              _launchUrl(
                                  "https://www.notion.so/dairyapp/Dairy-Privacy-Policy-eba39361b5944b85918840a56bb6cd5f?pvs=4");
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
                          if (kDebugMode)
                            SettingItem(
                              onTap: () {
                                context
                                    .read<OnboardingBloc>()
                                    .add(ToggleOnboarding());
                              },
                              icon: const Center(
                                child: Icon(
                                  Icons.shield,
                                  size: 15,
                                  color: Colors.white,
                                ),
                              ),
                              iconBackgroundColor: const Color(0xFF42a68a),
                              label: "Set Onboarding",
                            ),
                        ],
                      ),
                      SettingsContainer(
                        settingItems: [
                          SettingItem(
                            onTap: () {
                              context.read<AuthBloc>().add(LogoutRequest());
                              context.router.pop();
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
