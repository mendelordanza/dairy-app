import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/helper/route_generator.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:night_diary/injection_container.dart';
import 'package:night_diary/presentation/auth/auth_bloc.dart';
import 'package:night_diary/presentation/home/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_cubit.dart';
import 'config_reader.dart';
import 'firebase_options.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await ConfigReader.initialize();

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
        BlocProvider(
          create: (context) => getIt<QuoteCubit>(),
        ),
      ],
      child: MaterialApp.router(
        title: 'Night Diary',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        routerConfig: RouteGenerator.generateRoute(),
      ),
    );
  }
}
