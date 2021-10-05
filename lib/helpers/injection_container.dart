import 'package:adan/initial_app/data/database/initial_app_remote_data_source.dart';
import 'package:adan/initial_app/data/database/initial_app_local_data_source.dart';
import 'package:adan/initial_app/domain/repositories/initial_app_repository.dart';
import 'package:adan/initial_app/data/repositories/search_repository_impl.dart';
import 'package:adan/initial_app/presentation/bloc/initial_app_bloc.dart';
import 'package:adan/initial_app/domain/usecases/get_initial_app.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:adan/repository/calendar_repository.dart';
import 'package:adan/helpers/preference_utils.dart';
import 'package:adan/database/app_database.dart';
import 'package:path_provider/path_provider.dart';
import 'package:adan/cubit/calendar_cubit.dart';
import 'package:adan/network/network_info.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:get_it/get_it.dart';
import 'package:moor/moor.dart';
import 'package:moor/ffi.dart';
import '../main.dart';
import 'app_utils_impl.dart';
import 'app_utils.dart';
import 'dart:io';



final GetIt sl = GetIt.instance;

Future<void> setup() async {
  try {
    await _init();
    await initCalendarPage();
    await initAppPage();
  } catch(e) {
    print('error, setup: $e');
  }
}

///!  init
Future<void> _init() async {
  //! Firebase
  try {

    sl.registerLazySingleton(() => DataConnectionChecker());

    //! Network
    sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

    //! External
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => sharedPreferences);
    sl.registerLazySingleton(() => http.Client());

    //! Preference
    PreferenceUtils instance = await PreferenceUtils.init();
    sl.registerSingleton<PreferenceUtils>(instance);

    //! Database
    // final db = new AppDatabase(openConnection());
    final db = AppDatabase.instance;
    sl.registerLazySingleton(() => db);
    // sl.registerSingleton(new AppDatabase(openConnection()));


    // FirebaseNotifications notifications = await FirebaseNotifications.init();
    // sl.registerSingleton<FirebaseNotifications>(notifications);

    Directory tempDir = await getTemporaryDirectory();
    sl.registerLazySingleton(() => tempDir);
    // sl.registerLazySingleton(() => tempDir.path + '/' + 'audio.m4a');

    //! Dynamic Link
    // DynamicLinkService dynamicLinkService = await DynamicLinkService.handleDynamicLinks();
    // sl.registerLazySingleton(() => dynamicLinkService);
    // sl.registerLazySingleton(() => DynamicLinkService());

    sl.registerSingleton<AppUtils>(
      AppUtilsImpl(preferences: sl(), database: sl(), networkInfo: sl()),
      signalsReady: true,
    );

  } catch(e) {
    print('error, init: $e');
  }
}

///! initSimilarPage
Future<void> initCalendarPage() async {
  //! Bloc
  sl.registerFactory(() => CalendarCubit(calendarRepository: sl()));

  //! Repository
  sl.registerLazySingleton<CalendarRepository>(
        () => CalendarRepositoryImpl(
      networkInfo: sl(),
      client: sl()
    ),
  );

  //! Remote Data
  // sl.registerLazySingleton<SimilarRemoteDataSource>(
  //       () => SimilarRemoteDataSourceImpl(
  //           client: sl(), document: sl(), localDataSource: sl()),
  // );

  //! Data sources
  // sl.registerLazySingleton<SimilarLocalDataSource>(
  //       () => SimilarLocalDataSourceImpl(db: sl(), preferences: sl()),
  // );
}

///! initSimilarPage
Future<void> initAppPage() async {

  //! Bloc
  sl.registerFactory(() => InitialAppBloc(getInitialApp: sl()));

  //! Use cases
  sl.registerLazySingleton(() => GetInitialApp(repository: sl()));

  //! Repository
  sl.registerLazySingleton<InitialAppRepository>(
        () => InitialAppRepositoryImpl(
        networkInfo: sl(),
        localDataSource: sl(),
        remoteDataSource: sl(),
    ),
  );

  //! Remote Data
  sl.registerLazySingleton<InitialAppRemoteDataSource>(
        () => InitialAppRemoteDataSourceImpl(client: sl()),
  );

  //! Data sources
  sl.registerLazySingleton<InitialAppLocalDataSource>(
        () => InitialAppLocalDataSourceImpl(db: sl(), preferences: sl()),
  );
}

