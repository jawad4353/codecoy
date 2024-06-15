import 'package:codecoy/main.dart';
import 'package:codecoy/utilis/app_preferences.dart';
import 'package:codecoy/view/auth/register.dart';
import 'package:codecoy/view/widgets/custom_button.dart';
import 'package:codecoy/view_model/register_bloc/register_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_text_styles.dart';
import '../widgets/auth_screens_header.dart';
import '../widgets/custom_text_field.dart';


class VerifyOTP extends StatefulWidget {
  const VerifyOTP({Key? key}) : super(key: key);
  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  TextEditingController codeController=new TextEditingController();
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
                        Text(AppConstants.verifyCode,style: AppTextStyles.robotoBold(color: AppColors.white, fontSize: 30.sp, weight: FontWeight.w700),),
                        SizedBox(height: 5.h,),
                        Text(AppConstants.enterOtpCodeSent,style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 14.sp, weight: FontWeight.w500),),

                      ],),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(top: 1.sh*0.28,left: 20.w,right: 20.w),
                    child: Column(children: [
                      customTextField(title:AppConstants.code ,hintText:AppConstants.enterOtpCodeSent ,controller: codeController,icon: AppImages.iconPassword, isPasswordField: false,keyboardType: TextInputType.phone),
                      SizedBox(height: 20.h,),
                      BlocBuilder<RegisterBloc,RegisterUserState>(
                        builder: (context,state) {
                          if(state is RegisterVerifyingState){
                            return customButton(title: AppConstants.verify,onPressed:(){},disabled: true );
                          }
                          return customButton(title: AppConstants.verify, onPressed: (){
                            EasyLoading.show(status: 'verifying');
                            if(codeController.text.isEmpty){
                              EasyLoading.showInfo('Enter code');
                              return;
                            }
                            if(codeController.text!=preferences.getString(AppPrefs.keyOtp)){
                              EasyLoading.showInfo('Entered code is incorrect');
                              return;
                            }
                            context.read<RegisterBloc>().add(RegisterVerifyEmailEvent(context));

                          });
                        }
                      ),
                      SizedBox(height: 20.h,),
                    ],),
                  ),



                ],
              ),
            ],
          ),
        ),
      ),
    );
  }


}
