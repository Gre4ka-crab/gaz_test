import 'package:gaz_test/core/api/api.dart';
import 'package:gaz_test/core/network/network_info.dart';
import 'package:gaz_test/data/data_sources/remote_datasources/remote_user_datasources.dart';
import 'package:gaz_test/data/repositories/user_repository_impl.dart';
import 'package:gaz_test/domain/repositories/user_repository.dart';
import 'package:gaz_test/domain/use_cases/sig_in_use_cases.dart';
import 'package:gaz_test/presentation/cubit/auth/auth_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Cubit
  sl.registerFactory(() => AuthCubit(logInUseCase: sl()));

  // UseCases
  sl.registerLazySingleton(() => LogIn(userRepository: sl()));

  // Repository
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(remoteUserDataSources: sl(), networkInfo: sl()));

  // Data Source
  sl.registerLazySingleton<RemoteUserDataSources>(() => RemoteUserDataSourcesImpl());

  // Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));
  sl.registerLazySingleton<Api>(() => Api(urls: {'weather': 'https://api.openweathermap.org/data/2.5/'}));


  // External
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
