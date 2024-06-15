import 'package:codecoy/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_text_styles.dart';
import '../widgets/auth_screens_header.dart';
import '../widgets/custom_text_field.dart';

class ResetPassword extends StatefulWidget {
  const ResetPassword({Key? key}) : super(key: key);
  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  final TextEditingController newPasswordController= TextEditingController();
  final TextEditingController confirmPasswordController= TextEditingController();
  List<bool> hidePassword=[true,true];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(height:1.sh*0.92,width: 1.sw,color: AppColors.white,),
                  header(),
                  Positioned(
                    top: 36.h,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppConstants.resetPassword,style: AppTextStyles.robotoBold(color: AppColors.white, fontSize: 30.sp, weight: FontWeight.w700),),
                        SizedBox(height: 5.h,),
                        Text(AppConstants.enterNewPassword,style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 14.sp, weight: FontWeight.w500),),
                      ],),
                  ),

                  Padding(
                    padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 1.sh*0.28),
                    child: Column(children: [
                      customTextField(title:AppConstants.newPassword ,hintText:AppConstants.passwordHint ,controller: newPasswordController,icon: AppImages.iconPassword,  isPasswordField: true),
                      SizedBox(height: 10.h,),
                      customTextField(title:AppConstants.confirmPassword ,hintText:AppConstants.passwordHint ,controller: confirmPasswordController,icon: AppImages.iconPassword,isPasswordField: true),
                      SizedBox(height: 20.h,),
                      customButton(title: AppConstants.resetPassword, onPressed: (){})
                    ],),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}
