import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_text_styles.dart';

Widget customButton({required String title,required VoidCallback onPressed,}){
  return  SizedBox(
    height: 48.h,
    width: double.maxFinite,
    child: ElevatedButton(
        style:ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.r)
            )
        ) ,
        onPressed: onPressed, child:Text(title,style: AppTextStyles.robotoBold(color: AppColors.white, fontSize: 16.sp, weight: FontWeight.w600),) ),
  );
}
