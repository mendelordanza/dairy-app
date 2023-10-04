import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/helper/route_generator.dart';
import 'package:night_diary/helper/theme.dart';
import 'package:night_diary/injection_container.dart';
import 'package:night_diary/presentation/auth/auth_bloc.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'config_reader.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<EntryBloc>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Night Diary',
        theme: MyThemes.lightTheme,
        darkTheme: MyThemes.darkTheme,
        routerConfig: RouteGenerator.generateRoute(),
      ),
    );
  }
}
