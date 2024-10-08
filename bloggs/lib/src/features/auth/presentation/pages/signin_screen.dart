import 'package:bloggs/src/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:bloggs/src/core/theme/theme_colors.dart';
import 'package:bloggs/src/core/common/widgets/custom_button.dart';
import '../widgets/signup_icons.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _onSubmitForm() {
    if (_formKey.currentState!.validate()) {
      context.read<AuthBloc>().add(UserLogin(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ));
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 7.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 12.h),
                  Text(
                    "Welcome to Bloggs",
                    style: TextStyle(
                      fontSize: 19.7.sp,
                      fontWeight: FontWeight.w700,
                      fontFamily: "Poppins",
                    ),
                  ),
                  SizedBox(height: 0.8.h),
                  Text(
                    "Lets log you in to get started",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontFamily: "Poppins",
                      fontWeight: FontWeight.w600,
                      fontSize: 15.sp,
                    ),
                  ),
                  SizedBox(height: 5.h),
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 1.h),
                        TextFormField(
                          keyboardType: TextInputType.emailAddress,
                          cursorColor: AppThemeColors.kPrimaryButtonColor,
                          decoration: const InputDecoration(
                              hintText: "Enter your email"),
                          controller: _emailController,
                          validator: (value) {
                            if (value == null || value.trim().isEmpty) {
                              return "Enter an email address";
                            } else if (!RegExp(
                                    r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$')
                                .hasMatch(value)) {
                              return "Enter a valid email address";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 3.h),
                        TextFormField(
                          obscureText: true,
                          cursorColor: AppThemeColors.kPrimaryButtonColor,
                          decoration:
                              const InputDecoration(hintText: "Enter password"),
                          controller: _passwordController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Enter password";
                            } else if (value.length < 7) {
                              return "Password should be more than 6 characters";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 4.h),
                        CustomButton(
                          text: "Login",
                          width: 90.w,
                          onPressed: _onSubmitForm,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        "Sign in with",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w600,
                          fontSize: 15.5.sp,
                        ),
                      ),
                      SizedBox(width: 4.w),
                      const Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SignUpIcons(
                        svgUrl: "assets/svg/google_icon.svg",
                        onTap: () {},
                      ),
                      SizedBox(width: 5.w),
                      SignUpIcons(
                        svgUrl: "assets/svg/facebook_icon.svg",
                        onTap: () {},
                      ),
                      SizedBox(width: 5.w),
                      SignUpIcons(
                        svgUrl: "assets/svg/apple_icon.svg",
                        onTap: () {},
                      ),
                    ],
                  ),
                  SizedBox(height: 6.h),
                  Center(
                    child: RichText(
                      text: TextSpan(
                        text: "Don't have an account? ",
                        style: TextStyle(
                          fontFamily: "Poppins",
                          fontWeight: FontWeight.w400,
                          fontSize: 15.8.sp,
                        ),
                        children: [
                          TextSpan(
                            text: "sign up here",
                            style: TextStyle(
                              fontFamily: "Poppins",
                              color: Colors.blue,
                              fontSize: 15.8.sp,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.pushReplacementNamed(
                                    context, "/signUp");
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    ));
  }
}
