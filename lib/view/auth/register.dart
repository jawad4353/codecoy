import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_routes.dart';
import '../../utilis/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_footer.dart';
import '../widgets/custom_text_field.dart';
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
                      customTextField(title:AppConstants.name ,hintText:AppConstants.nameHint ,controller: name,icon: AppImages.iconStudent, isPasswordField: false),
                      SizedBox(height: 20.h,),
                      customTextField(title:AppConstants.email ,hintText:AppConstants.emailHint ,controller: email,icon: AppImages.iconEmail,isPasswordField: false),
                      SizedBox(height: 20.h,),
                      customTextField(title:AppConstants.password ,hintText:AppConstants.passwordHint ,controller: password,icon: AppImages.iconPassword, isPasswordField: true),
                      SizedBox(height: 40.h,),
                      customButton(title: AppConstants.signUp, onPressed: () {  }),
                    ],
                  ),
                  Positioned(
                      bottom: 15.h,
                      left: 0,
                      right: 0,
                      child: customFooter(title: AppConstants.alreadyHaveAccount, clickableText: AppConstants.logIn, callback: () {
                        Navigator.pushReplacement(context, MyRoute(const Login()));
                      })),
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



}
