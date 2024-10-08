import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bloggs/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloggs/src/core/secrets/supabse_secrets.dart';
import 'package:bloggs/src/core/theme/theme_config.dart';
import 'package:bloggs/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bloggs/src/features/auth/data/repository/auth_repository.dart';
import 'package:bloggs/src/features/auth/domain/usecases/get_logged_in_user.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signin_usecase.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:bloggs/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloggs/src/features/auth/presentation/pages/signin_screen.dart';
import 'package:bloggs/src/features/auth/presentation/pages/signup_screen.dart';

final AppUserCubit appUserCubit = AppUserCubit();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final supabase = await Supabase.initialize(
    url: SupabseSecrets.projectUrl,
    anonKey: SupabseSecrets.annonKey,
  );
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => AppUserCubit(),
        ),
        BlocProvider(
          create: (context) => AuthBloc(
            userSignup: UserSignUpUsecase(
              authRepository: AuthRepositoryImpl(
                authRemoteDataSource: AuthRemoteDataSourceImpl(
                  superbase: supabase.client,
                ),
              ),
            ),
            userLogin: UserSignInUsecase(
              authRepository: AuthRepositoryImpl(
                authRemoteDataSource: AuthRemoteDataSourceImpl(
                  superbase: supabase.client,
                ),
              ),
            ),
            loggedInUser: LoggedInUserUsecase(
              authRespository: AuthRepositoryImpl(
                authRemoteDataSource: AuthRemoteDataSourceImpl(
                  superbase: supabase.client,
                ),
              ),
            ),
            appUserCubit: appUserCubit,
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(LoggedInUser());
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          routes: {
            '/signIn': (context) => const SignInScreen(),
            '/signUp': (context) => const SignUpScreen(),
          },
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeConfig().darkTheme,
          theme: ThemeConfig().lightTheme,
          themeMode: ThemeMode.dark,
          home: BlocSelector<AppUserCubit, UserState, bool>(
            bloc: appUserCubit,
            selector: (state) {
              return state is UserLoggedIn;
            },
            builder: (context, loggedIn) {
              if (loggedIn) {
                return const Scaffold(
                  body: Center(
                    child: Text("LoggedIn"),
                  ),
                );
              }
              return const SignInScreen();
            },
          ),
        );
      },
    );
  }
}
