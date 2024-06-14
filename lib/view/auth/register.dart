import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_routes.dart';
import '../../utilis/app_text_styles.dart';
import 'login.dart';

class Register extends StatefulWidget {
  const Register({Key? key}) : super(key: key);

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  TextEditingController name= TextEditingController();
  TextEditingController email= TextEditingController();
  TextEditingController password= TextEditingController();



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.white,
        body:ListView(
          children: [
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 22.w),
              child: Stack(
                children: [
                  Container(height:1.sh*0.92,width: 1.sw,color: AppColors.white,),
                  Column(
                    children: [
                      SizedBox(height: 1.sh*0.04,),
                      _header(),
                      SizedBox(height: 30.h,),
                      _textField(title:AppConstants.name ,hintText:AppConstants.nameHint ,controller: name,icon: AppImages.iconStudent),
                      SizedBox(height: 20.h,),
                      _textField(title:AppConstants.email ,hintText:AppConstants.emailHint ,controller: email,icon: AppImages.iconEmail),
                      SizedBox(height: 20.h,),
                      _textField(title:AppConstants.password ,hintText:AppConstants.passwordHint ,controller: password,icon: AppImages.iconPassword),
                      SizedBox(height: 40.h,),
                      _registerButton(),
                    ],
                  ),
                  Positioned(
                      bottom: 15.h,
                      left: 0,
                      right: 0,
                      child: _bottom()),
                ],
              ),
            ),
          ],
        ) ,
      ),
    );
  }



  Widget _header(){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(AppConstants.signUp,style: AppTextStyles.robotoBold(color: AppColors.black191B32, fontSize: 30.sp, weight: FontWeight.w700),),
        SizedBox(height: 5.h,),
        Text(AppConstants.enterRealInformation,style: AppTextStyles.robotoMedium(color: AppColors.grey0E0F10, fontSize: 14.sp, weight: FontWeight.w500),),

      ],);
  }


  Widget _textField({required TextEditingController controller,required String hintText,required String title,required icon}){
    return Container(
      height: 60.h,
      width: 1.sw*0.85,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7.r),
          border: Border.all(color: AppColors.greyB2AFAF,width: 1.1)
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
              height: 37.h,
              margin: EdgeInsets.symmetric(horizontal: 6.w),
              child: Image.asset(icon,color: AppColors.primary,)),
          Padding(
            padding:  EdgeInsets.symmetric(vertical: 16.h,horizontal: 2.w),
            child: const VerticalDivider(width: 1.2,),
          ),
          SizedBox(width: 8.w,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  margin:EdgeInsets.symmetric(vertical: 6.h),
                  child: Text(title,style: AppTextStyles.robotoMedium(color: AppColors.grey0E0F10, fontSize: 14.sp, weight: FontWeight.w500),)),
              SizedBox(
                height: 20.h,
                width: 1.sw*0.66,
                child: TextField(
                  cursorHeight: 16,
                  controller: controller,
                  cursorColor: AppColors.primary,
                  cursorWidth: 3,
                  onChanged: (a){},
                  style: AppTextStyles.robotoMedium(color: AppColors.black191B32, fontSize: 14.sp, weight: FontWeight.w400),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.only(bottom: 12.h),
                      hintText: hintText
                  ),
                ),
              )
            ],),
        ],
      ),
    );
  }


  Widget _registerButton(){
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
            if(email.text.replaceAll(" ", '').isEmpty){
              EasyLoading.showInfo('Email required !');
              return;
            }
            if(password.text.replaceAll(" ", '').isEmpty){
              EasyLoading.showInfo('Password required !');
              return;
            }
            if(password.text.replaceAll(" ", '').length<8){
              EasyLoading.showInfo('Password must have eight characters');
              return;
            }

          }, child:Text(AppConstants.signUp,style: AppTextStyles.robotoBold(color: AppColors.black, fontSize: 16.sp, weight: FontWeight.w600),) ),
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
            child: Text(AppConstants.login,style:AppTextStyles.robotoMedium(color: AppColors.primary, fontSize: 16.sp, weight: FontWeight.w600) ,)
        )
      ],);
  }
}
