import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_text_styles.dart';

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
                  _header(),
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

                      _textField(title:AppConstants.newPassword ,hintText:'●●●●●●' ,controller: newPasswordController,icon: AppImages.iconPassword, hidePassword: false),
                      SizedBox(height: 10.h,),
                      _textField(title:AppConstants.confirmPassword ,hintText:'●●●●●●' ,controller: confirmPasswordController,icon: AppImages.iconPassword,hidePassword: false),
                      SizedBox(height: 20.h,),
                      _resetButton()
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


  Widget _header(){
    return ClipPath(
      clipper: ProsteBezierCurve(
        position: ClipPosition.bottom,
        list: [
          BezierCurveSection(
            start: const Offset(0, 166),
            top: Offset(1.sw / 4, 190),
            end: Offset(1.sw  / 2, 155),
          ),
          BezierCurveSection(
            start: Offset(1.sw  / 2, 25),
            top: Offset(1.sw / 4 * 3, 100),
            end: Offset(1.sw , 150),
          ),
        ],
      ),
      child: Container(
        height: 1.sh *0.3,
        width: 1.sw ,
        color: AppColors.primary,
        child:  Opacity(opacity: 0.2,
          child: Image.asset(AppImages.imgPattern,fit: BoxFit.cover,color: AppColors.white,),
        ),
      ),
    );
  }


  Widget _textField({
    required TextEditingController controller,
    required String hintText,
    required String title,
    required icon,
    required bool hidePassword,
  }) {
    return Container(
      height: 60.h,
      width: 1.sw,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7.r),
        border: Border.all(color: AppColors.greyB2AFAF, width: 1.1),
      ),
      child: Row(
        children: [
          Container(
            height: 37.h,
            margin: EdgeInsets.symmetric(horizontal: 6.w),
            child: Image.asset(icon, color: AppColors.primary),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
            child: const VerticalDivider(width: 1.2),
          ),
          SizedBox(width: 8.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 6.h),
                  child: Text(
                    title,
                    style: AppTextStyles.robotoMedium(
                      color: AppColors.grey0E0F10,
                      fontSize: 14.sp,
                      weight: FontWeight.w500,
                    ),
                  ),
                ),
                SizedBox(
                  height: 20.h,
                  // Remove the width property
                  child: TextField(
                    onChanged: (a) {},
                    controller: controller,
                    cursorColor: AppColors.primary,
                    cursorWidth: 3,
                    cursorHeight: 16,
                    obscureText:  hidePassword,
                    style: AppTextStyles.robotoMedium(
                      color: AppColors.black191B32,
                      fontSize: 14.sp,
                      weight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      suffixIcon: InkWell(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Image.asset(
                          hidePassword
                              ? AppImages.iconVisibility
                              : AppImages.iconVisibilityOff,
                          color: AppColors.primary,
                          height: 50,
                          width: 50,
                        ),
                      )
                      ,
                      contentPadding: EdgeInsets.only(bottom: 12.h),
                      hintText: hintText,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }


  Widget _resetButton(){
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
          onPressed: (){

            if(newPasswordController.text.replaceAll(' ', '').isEmpty){
              EasyLoading.showInfo('New password required !');
              return;
            }
            if(newPasswordController.text.replaceAll(' ', '').length<8){
              EasyLoading.showInfo('Passwords must have eight characters');
              return;
            }
            if(confirmPasswordController.text.replaceAll(' ', '').isEmpty){
              EasyLoading.showInfo('Confirm password required !');
              return;
            }

            if(confirmPasswordController.text!=newPasswordController.text){
              EasyLoading.showInfo('Confirm and new passwords are not maching');
              return;
            }

          }, child:Text(AppConstants.resetPassword,style: AppTextStyles.robotoBold(color: AppColors.black, fontSize: 16.sp, weight: FontWeight.w600),) ),
    );
  }




}
