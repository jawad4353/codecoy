import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_routes.dart';
import '../../utilis/app_text_styles.dart';
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
                  _header(),
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
                      _textField(title:AppConstants.email ,hintText:AppConstants.emailHint ,controller: phoneController,icon: AppImages.iconStudent),
                      SizedBox(height: 20.h,),
                      _sendOtpBtn(),
                      SizedBox(height: 20.h,),
                    ],),
                  ),

                  Positioned(
                      bottom: 25.h,
                      left: 0,
                      right: 0,
                      child: _bottom()),

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
                    controller: phoneController,
                    cursorColor: AppColors.primary,
                    cursorWidth: 3,
                    cursorHeight: 16,
                    style: AppTextStyles.robotoMedium(
                      color: AppColors.black191B32,
                      fontSize: 14.sp,
                      weight: FontWeight.w400,
                    ),
                    decoration: InputDecoration(
                      border: InputBorder.none,
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



  Widget _sendOtpBtn(){
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
            if(phoneController.text.replaceAll(' ', '').isEmpty){
              EasyLoading.showInfo('Email registered email');
              return;
            }
            if(phoneController.text.replaceAll(" ", '').length<7){
              EasyLoading.showInfo('Email correct email');
              return;
            }



          }, child:Text(AppConstants.getCode,style: AppTextStyles.robotoBold(color: AppColors.black, fontSize: 16.sp, weight: FontWeight.w600),) ),
    );
  }


  Widget _bottom(){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(AppConstants.alreadyHaveAccount,style: AppTextStyles.robotoMedium(color: AppColors.black191B32, fontSize: 14.sp, weight: FontWeight.w500),),
        InkWell(
            onTap: (){
              Navigator.push(context, MyRoute(const Login()));
            },
            child:  Text(AppConstants.login,style:AppTextStyles.robotoMedium(color: AppColors.primary, fontSize: 16.sp, weight: FontWeight.w600) ,)
        )
      ],);
  }
}
