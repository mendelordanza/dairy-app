import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:night_diary/injection_container.dart';
import 'package:night_diary/presentation/entry/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_bloc.dart';

@RoutePage()
class EntryNavigationPage extends StatelessWidget {
  const EntryNavigationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<EntryBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<QuoteBloc>(),
        ),
      ],
      child: const AutoRouter(),
    );
  }
}
