import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/helper/route_generator.dart';
import 'package:night_diary/helper/shared_prefs.dart';
import 'package:night_diary/helper/theme.dart';
import 'package:night_diary/injection_container.dart';
import 'package:night_diary/presentation/auth/auth_bloc.dart';
import 'package:night_diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:night_diary/presentation/purchase/purchase_bloc.dart';
import 'package:purchases_flutter/purchases_flutter.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config_reader.dart';
import 'firebase_options.dart';
import 'helper/constants.dart';
import 'injection_container.dart' as di;
import 'package:timezone/data/latest.dart' as tzdata;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  tzdata.initializeTimeZones();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ConfigReader.initialize();

  final apiUrl = ConfigReader.getApiUrl();
  final anonKey = ConfigReader.getAnonKey();
  await Supabase.initialize(
    url: apiUrl,
    anonKey: anonKey,
  );

  await di.setup();

  await SharedPrefs.init();

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  initPlatformState() async {
    await Purchases.setLogLevel(LogLevel.debug);
    if (Platform.isAndroid) {
      final configuration = PurchasesConfiguration(googleApiKey);
      await Purchases.configure(configuration);
    } else if (Platform.isIOS) {
      final appleApiKey = ConfigReader.getAppleKey();
      final configuration = PurchasesConfiguration(appleApiKey);
      await Purchases.configure(configuration);
    }
  }

  @override
  void initState() {
    initPlatformState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<PurchaseBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<OnboardingBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Night Diary',
        themeMode: ThemeMode.dark,
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        routerConfig: RouteGenerator.generateRoute(),
      ),
    );
  }
}
