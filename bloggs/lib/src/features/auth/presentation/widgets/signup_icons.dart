import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:bloggs/src/core/theme/theme_colors.dart';

class SignUpIcons extends StatelessWidget {
  const SignUpIcons({super.key, required this.svgUrl, required this.onTap});

  final String svgUrl;
  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 9.w,
        height: 9.w,
        decoration: BoxDecoration(
          border: Border.all(color: AppThemeColors.kWhiteColor),
        ),
        child: Center(
          child: SvgPicture.asset(
            svgUrl,
            width: 7.w,
            height: 7.w,
          ),
        ),
      ),
    );
  }
}
