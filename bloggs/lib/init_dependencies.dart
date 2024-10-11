part of 'init_dependencies_import.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    url: SupabseSecrets.projectUrl,
    anonKey: SupabseSecrets.annonKey,
  );

  final dir = await getApplicationDocumentsDirectory();
  Hive.defaultDirectory = dir.path;

  serviceLocator.registerLazySingleton(() => Hive.box(name: "blogs"));
  serviceLocator.registerLazySingleton(() => supabase.client);
}

void _initAuth() {
  // DataSource
  serviceLocator.registerFactory<AuthRemoteDatasource>(
    () => AuthRemoteDataSourceImpl(
      superbase: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<InternetConnection>(
    () => InternetConnectionImpl(),
  );

  // Repository
  serviceLocator.registerFactory<AuthRespository>(
    () => AuthRepositoryImpl(
      authRemoteDataSource: serviceLocator(),
      internetConnection: serviceLocator(),
    ),
  );

  // Usecases
  serviceLocator.registerFactory(
    () => UserSignUpUsecase(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => UserSignInUsecase(
      authRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => LoggedInUserUsecase(
      authRespository: serviceLocator(),
    ),
  );

  // Blocs and Cubits
  serviceLocator.registerLazySingleton(
    () => AppUserCubit(),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      userSignup: serviceLocator(),
      userLogin: serviceLocator(),
      loggedInUser: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  // DataSources
  serviceLocator.registerFactory<BlogRemoteDatasource>(
    () => BlogRemoteDatasourceImpl(
      serviceLocator(),
    ),
  );

  serviceLocator.registerCachedFactory<BlogLocalDatasource>(
    () => BlogLocalDatasourceImpl(
      box: serviceLocator(),
    ),
  );

  // Repository
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      blogRemoteDatasource: serviceLocator(),
      blogLocalDatasource: serviceLocator(),
      internetConnection: serviceLocator(),
    ),
  );

  // Usecases
  serviceLocator.registerFactory(
    () => UploadBlogUsecase(
      blogRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerFactory(
    () => GetAllBlogsUsecase(
      blogRepository: serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlogUsecase: serviceLocator(),
      getAllBlogsUsecase: serviceLocator(),
    ),
  );
}
