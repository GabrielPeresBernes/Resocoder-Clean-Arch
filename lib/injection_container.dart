import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get_it/get_it.dart';
import 'package:resocoder_clean_arch/core/network/network_info.dart';
import 'package:resocoder_clean_arch/core/util/input_converter.dart';
import 'package:resocoder_clean_arch/features/number_trivia/data/datasources/number_trivia_local_data_source.dart';
import 'package:resocoder_clean_arch/features/number_trivia/data/datasources/number_trivia_remote_data_source.dart';
import 'package:resocoder_clean_arch/features/number_trivia/data/repositories/number_trivia_repository_impl.dart';
import 'package:resocoder_clean_arch/features/number_trivia/domain/repositories/number_trivia_repository.dart';
import 'package:resocoder_clean_arch/features/number_trivia/domain/usecases/get_concrete_number_trivia.dart';
import 'package:resocoder_clean_arch/features/number_trivia/domain/usecases/get_random_number_trivia.dart';
import 'package:resocoder_clean_arch/features/number_trivia/presentation/bloc/number_trivia_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  locator.registerFactory(
    () => NumberTriviaBloc(
      getConcreteNumberTrivia: locator(),
      getRandomNumberTrivia: locator(),
      inputConverter: locator(),
    ),
  );

  // Use cases
  locator.registerLazySingleton(() => GetConcreteNumberTrivia(locator()));
  locator.registerLazySingleton(() => GetRandomNumberTrivia(locator()));

  // Repository
  locator.registerLazySingleton<NumberTriviaRepository>(
    () => NumberTriviaRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
      networkInfo: locator(),
    ),
  );

  // Data sources
  locator.registerLazySingleton<NumberTriviaRemoteDataSource>(
    () => NumberTriviaRemoteDataSourceImpl(
      client: locator(),
    ),
  );
  locator.registerLazySingleton<NumberTriviaLocalDataSource>(
      () => NumberTriviaLocalDataSourceImpl(sharedPreferences: locator()));

  //! Core
  locator.registerLazySingleton(() => InputConverter());
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  locator.registerLazySingleton(() => sharedPreferences);
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Connectivity());
}
