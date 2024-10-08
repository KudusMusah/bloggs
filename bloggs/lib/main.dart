import 'package:bloggs/src/core/secrets/supabse_secrets.dart';
import 'package:bloggs/src/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:bloggs/src/features/auth/data/repository/auth_repository.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signin_usecase.dart';
import 'package:bloggs/src/features/auth/domain/usecases/signup_usecase.dart';
import 'package:bloggs/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'package:bloggs/src/core/theme/theme_config.dart';
import 'package:bloggs/src/features/auth/presentation/pages/signup_screen.dart';
import 'package:bloggs/src/features/auth/presentation/pages/signin_screen.dart';

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
          ),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => const SignInScreen(),
            '/signUp': (context) => const SignUpScreen(),
          },
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeConfig().darkTheme,
          theme: ThemeConfig().lightTheme,
          themeMode: ThemeMode.dark,
        );
      },
    );
  }
}
