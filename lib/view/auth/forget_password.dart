import 'package:codecoy/view/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_routes.dart';
import '../../utilis/app_text_styles.dart';
import '../widgets/auth_screens_header.dart';
import '../widgets/custom_footer.dart';
import '../widgets/custom_text_field.dart';
import 'login.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({Key? key}) : super(key: key);
  @override
  State<ForgotPassword> createState() => _ForgetPasswordState();
}

class _ForgetPasswordState extends State<ForgotPassword> {
  TextEditingController phoneController=new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body:  SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(height:1.sh*0.95,width: 1.sw,color: AppColors.white,),
                  header(),
                  Positioned(
                    top: 36.h,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppConstants.forgetPassword,style: AppTextStyles.robotoBold(color: AppColors.white, fontSize: 30.sp, weight: FontWeight.w700),),
                        SizedBox(height: 5.h,),
                        Text(AppConstants.enterPhoneNumber,style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 14.sp, weight: FontWeight.w500),),

                      ],),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 1.sh*0.28,left: 20.w,right: 20.w),
                    child: Column(children: [
                      customTextField(title:AppConstants.email ,hintText:AppConstants.emailHint ,controller: phoneController,icon: AppImages.iconEmail, isPasswordField: false),
                      SizedBox(height: 20.h,),
                      customButton(title: AppConstants.getCode, onPressed: (){}),
                      SizedBox(height: 20.h,),
                    ],),
                  ),

                  Positioned(
                      bottom: 25.h,
                      left: 0,
                      right: 0,
                      child: customFooter(title: AppConstants.alreadyHaveAccount, clickableText: AppConstants.logIn, callback: () {
                        Navigator.push(context, MyRoute(const Login()));
                      })),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
