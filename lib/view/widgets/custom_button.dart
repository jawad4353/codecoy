import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_text_styles.dart';

Widget customButton({
  required String title,
  required VoidCallback onPressed,
  bool disabled = false,
}) {
  return SizedBox(
    height: 48.h,
    width: double.maxFinite,
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: disabled ? AppColors.grey0E0F10 : AppColors.primary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.r),
        ),
      ),
      onPressed: disabled ? null : onPressed,
      child: Text(
        title,
        style: AppTextStyles.robotoBold(
          color: disabled ? AppColors.white.withOpacity(0.5) : AppColors.white,
          fontSize: 16.sp,
          weight: FontWeight.w600,
        ),
      ),
    ),
  );
}
