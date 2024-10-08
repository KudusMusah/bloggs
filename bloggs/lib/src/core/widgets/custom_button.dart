import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:bloggs/src/core/theme/theme_colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.borderColor,
    this.backgroundColor,
    this.textStyle,
    this.verticalPadding,
    this.width,
  });

  final String text;
  final Color? backgroundColor;
  final Color? borderColor;
  final Function() onPressed;
  final TextStyle? textStyle;
  final double? verticalPadding;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      child: Text(
        text,
        style: TextStyle(
          color: AppThemeColors.kWhiteColor,
          fontSize: 16.5.sp,
          fontWeight: FontWeight.w600,
          fontFamily: "Poppins",
        ),
      ),
      style: TextButton.styleFrom(
        fixedSize: width == null ? null : Size(width!, 7.h),
        backgroundColor: backgroundColor ?? AppThemeColors.kPrimaryButtonColor,
        padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 2.1.h),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(7),
          side: BorderSide(
            color: borderColor ?? AppThemeColors.kPrimaryButtonColor,
            width: 0.4,
          ),
        ),
      ),
    );
  }
}
