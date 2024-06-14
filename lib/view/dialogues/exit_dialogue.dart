import 'package:flutter/material.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_text_styles.dart';

Future<bool> onExit(context)async{
  return (await showDialog(context: context, builder:(context)=>AlertDialog(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
    title:  Padding(
      padding:  const EdgeInsets.symmetric(vertical: 10),
      child: Text(AppConstants.alreadyHaveAccount,style:AppTextStyles.roboto(
        color: AppColors.black191B32,
        fontSize: 19,
        weight: FontWeight.w400,
      )),
    ),
    actions: [
      SizedBox(
        height:35,
        child: ElevatedButton(
          onPressed: () => Navigator.of(context).pop(true),
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))
          ),
          child:  Text(AppConstants.login,style:AppTextStyles.roboto(
            color: AppColors.white,
            fontSize: 14,
            weight: FontWeight.w400,
          )),
        ),
      ),
      SizedBox(
        height:35,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3))
          ),
          onPressed: () => Navigator.of(context).pop(false),

          child:   Text(AppConstants.session,style:AppTextStyles.roboto(
            color: AppColors.white,
            fontSize: 14,
            weight: FontWeight.w400,
          )),
        ),
      ),
    ],
  ))) ?? false;
}