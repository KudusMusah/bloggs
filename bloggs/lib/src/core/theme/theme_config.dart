import 'package:bloggs/src/core/theme/theme_colors.dart';
import 'package:flutter/material.dart';

import 'package:responsive_sizer/responsive_sizer.dart';

class ThemeConfig {
  ThemeConfig();

  ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      primaryColor: AppThemeColors.kPrimaryButtonColor,
      scaffoldBackgroundColor: AppThemeColors.kPrimaryBackgroundColor,
      appBarTheme: const AppBarTheme(
          backgroundColor: AppThemeColors.kPrimaryBackgroundColor,
          surfaceTintColor: AppThemeColors.kPrimaryBackgroundColor),
      inputDecorationTheme: InputDecorationTheme(
        errorStyle: const TextStyle(color: AppThemeColors.kPrimaryButtonColor),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppThemeColors.kPrimaryButtonColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 1,
            color: AppThemeColors.kPrimaryButtonColor,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        labelStyle: const TextStyle(
          color: AppThemeColors.kWhiteColor,
        ),
        contentPadding: EdgeInsets.all(1.8.h),
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppThemeColors.kWhiteColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppThemeColors.kPrimaryButtonColor,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      buttonTheme: const ButtonThemeData().copyWith(
        buttonColor: AppThemeColors.kPrimaryButtonColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
        ),
      ),

      // textTheme: CustomTextStyles.kDefaultTextTheme(
      //   AppDarkThemeColors.smallTextColorDark,
      // ),
    );
  }

  ThemeData get lightTheme {
    return ThemeData.light();
  }
}
