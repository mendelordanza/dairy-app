import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';
import 'package:night_diary/config_reader.dart';
import 'package:night_diary/data/datasources/remote_data_source.dart';
import 'package:night_diary/data/repositories/diary_entry_repository_impl.dart';
import 'package:night_diary/data/repositories/quote_repository_impl.dart';
import 'package:night_diary/data/repositories/supabase_auth_repository_impl.dart';
import 'package:night_diary/domain/repositories/auth_repository.dart';
import 'package:night_diary/domain/repositories/quote_repository.dart';
import 'package:night_diary/helper/shared_prefs.dart';
import 'package:night_diary/presentation/auth/bloc/auth_bloc.dart';
import 'package:night_diary/presentation/auth/bloc/local_auth_cubit.dart';
import 'package:night_diary/presentation/entry/bloc/entry_bloc.dart';
import 'package:night_diary/presentation/onboarding/bloc/onboarding_bloc.dart';
import 'package:night_diary/presentation/purchase/purchase_bloc.dart';
import 'package:night_diary/presentation/quote/bloc/quote_bloc.dart';
import 'package:night_diary/presentation/review/review_cubit.dart';
import 'package:night_diary/presentation/settings/bloc/biometrics_cubit.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'data/datasources/local_data_source.dart';
import 'data/isar_service.dart';
import 'domain/repositories/diary_entry_repository.dart';

final getIt = GetIt.instance;

Future<void> setup() async {
  //Bloc
  getIt.registerFactory(() => AuthBloc(authRepository: getIt()));
  getIt.registerFactory(
    () => EntryBloc(getIt()),
  );
  getIt.registerFactory(
    () => QuoteBloc(quoteRepository: getIt()),
  );
  getIt.registerFactory(
    () => PurchaseBloc(),
  );
  getIt.registerFactory(
    () => OnboardingBloc(sharedPrefs: getIt()),
  );
  getIt.registerFactory(
    () => LocalAuthCubit(
      localAuthentication: getIt(),
      sharedPrefs: getIt(),
    ),
  );
  getIt.registerFactory(
    () => BiometricsCubit(
      sharedPrefs: getIt(),
    ),
  );
  getIt.registerFactory(
    () => ReviewCubit(sharedPrefs: getIt()),
  );

  //Repository
  getIt.registerLazySingleton<AuthRepository>(() => SupabaseAuthRepositoryImpl(
        getIt(),
        getIt(),
      ));
  getIt.registerLazySingleton<DiaryEntryRepository>(
      () => DiaryEntryRepositoryImpl(
            getIt(),
          ));
  getIt.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
        getIt(),
        getIt(),
        getIt(),
      ));

  //Data
  getIt.registerLazySingleton<LocalDataSource>(() => LocalDataSourceImpl(
        getIt(),
      ));
  getIt.registerLazySingleton<RemoteDataSource>(() => RemoteDataSourceImpl(
        getIt(),
      ));
  getIt.registerLazySingleton<IsarService>(() => IsarService());
  getIt.registerLazySingleton<FirebaseFirestore>(
      () => FirebaseFirestore.instance);
  getIt.registerLazySingleton<FirebaseAuth>(() => FirebaseAuth.instance);
  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
  getIt.registerLazySingleton<FlutterAppAuth>(() => FlutterAppAuth());

  getIt.registerLazySingleton<Dio>(() {
    final baseUrl = ConfigReader.getBaseUrl();
    final baseOptions = BaseOptions(baseUrl: baseUrl);
    final dio = Dio(baseOptions);
    dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseBody: true,
        responseHeader: false,
        error: true,
        compact: true,
        maxWidth: 90));
    return dio;
  });

  getIt.registerLazySingleton<SharedPrefs>(() => SharedPrefs());
  getIt.registerLazySingleton<LocalAuthentication>(() => LocalAuthentication());
}
