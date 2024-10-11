import 'package:bloggs/init_dependencies_import.dart';
import 'package:bloggs/src/features/blogs/presentation/bloc/blog_bloc.dart';
import 'package:bloggs/src/features/blogs/presentation/pages/add_blog.dart';
import 'package:bloggs/src/features/blogs/presentation/pages/blog_detail_page.dart';
import 'package:bloggs/src/features/blogs/presentation/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:bloggs/src/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:bloggs/src/core/theme/theme_config.dart';
import 'package:bloggs/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:bloggs/src/features/auth/presentation/pages/signin_screen.dart';
import 'package:bloggs/src/features/auth/presentation/pages/signup_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => serviceLocator<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<AppUserCubit>(),
        ),
        BlocProvider(
          create: (context) => serviceLocator<BlogBloc>(),
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
            '/homePage': (context) => const HomePage(),
            '/addBlog': (context) => const AddBlog(),
            '/blogDetail': (context) => const BlogDetailPage(),
          },
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeConfig().darkTheme,
          theme: ThemeConfig().lightTheme,
          themeMode: ThemeMode.dark,
          home: BlocSelector<AppUserCubit, UserState, bool>(
            selector: (state) {
              return state is UserLoggedIn;
            },
            builder: (context, loggedIn) {
              if (loggedIn) {
                return const HomePage();
              }
              return const SignInScreen();
            },
          ),
        );
      },
    );
  }
}
