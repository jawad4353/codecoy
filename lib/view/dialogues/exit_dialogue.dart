import 'package:codecoy/utilis/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_text_styles.dart';

Future<bool> onExit(context)async{
  return (await showDialog(context: context, builder:(context)=>AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    title:  Padding(
      padding:  EdgeInsets.symmetric(vertical: 10.h),
      child: Text(AppConstants.areYouSureExit,style:AppTextStyles.robotoMedium(
        color: AppColors.black191B32,
        fontSize: 19.sp,
        weight: FontWeight.w400,
      )),
    ),
    actions: [
      SizedBox(
        height:35.h,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))
          ),
          child:  Text(AppConstants.exit,style:AppTextStyles.robotoMedium(
            color: AppColors.white,
            fontSize: 14.sp,
            weight: FontWeight.w400,
          )),
        ),
      ),
      SizedBox(
        height:35.h,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))
          ),
          onPressed: () => Navigator.of(context).pop(false),

          child:   Text(AppConstants.cancel,style:AppTextStyles.robotoMedium(
            color: AppColors.white,
            fontSize: 14.sp,
            weight: FontWeight.w400,
          )),
        ),
      ),
    ],
  ))) ?? false;
}