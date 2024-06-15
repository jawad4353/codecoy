import 'package:codecoy/utilis/app_routes.dart';
import 'package:codecoy/view/auth/forget_password.dart';
import 'package:codecoy/view/auth/register.dart';
import 'package:codecoy/view/screens/bottom_screen.dart';
import 'package:codecoy/view/widgets/custom_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../main.dart';
import '../../network_config/firebase_service.dart';
import '../../utilis/app_colors.dart';
import '../../utilis/app_constants.dart';
import '../../utilis/app_images.dart';
import '../../utilis/app_preferences.dart';
import '../../utilis/app_text_styles.dart';
import '../../view_model/login_bloc/login_bloc.dart';
import '../widgets/auth_screens_header.dart';
import '../widgets/custom_footer.dart';
import '../widgets/custom_text_field.dart';


class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController _email= TextEditingController();
  final TextEditingController _password= TextEditingController();
  bool rememberMe=true,hidePassword=true;

  @override
  initState(){
    super.initState();
    if(preferences.getBool(AppPrefs.keyRememberMe)==true){
      _email.text=preferences.getString(AppPrefs.keyEmail)??"";
      _password.text=preferences.getString(AppPrefs.keyPassword)??"";
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(height:1.sh*0.92,width: 1.sw,color: AppColors.white,),
                  header(),
                  Positioned(
                    top: 38.h,
                    left: 0,
                    right: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(AppConstants.welcomeBack,style: AppTextStyles.robotoBold(color: AppColors.white, fontSize: 30.sp, weight: FontWeight.w700),),
                        SizedBox(height: 5.h,),
                        Text(AppConstants.enterUsernamePassword,style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 14.sp, weight: FontWeight.w500),),

                      ],),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: 20.w,right: 20.w,top: 1.sh*0.28),
                    child: Column(children: [
                      customTextField(isPasswordField:false ,title:AppConstants.email ,hintText:AppConstants.emailHint ,controller: _email,icon: AppImages.iconEmail,inputFormatter: AppConstants.emailFormatter),
                      SizedBox(height: 20.h,),
                      customTextField(isPasswordField: true,title:AppConstants.password ,hintText:AppConstants.passwordHint ,controller: _password,icon: AppImages.iconPassword,keyboardType: TextInputType.visiblePassword),
                      SizedBox(height: 3.h,),
                      _forgetRememberMe(),
                      SizedBox(height: 3.h,),
                      BlocBuilder<LoginBloc,LoginState>(
                        builder: (context,state) {
                          if(state is LoginLodedState){
                            return customButton(title: AppConstants.login, onPressed: (){},disabled: true);
                                }
                          return customButton(title: AppConstants.login, onPressed: () async {
                            if(_email.text.replaceAll(' ', '').isEmpty){
                              EasyLoading.showInfo('Email required');
                              return;
                            }
                            if(_email.text.replaceAll(' ', '').length<5){
                              EasyLoading.showInfo('Invalid email');
                              return;
                            }
                            if(_password.text.replaceAll(' ', '').isEmpty){
                              EasyLoading.showInfo('Password required');
                              return;
                            }
                            context.read<LoginBloc>().add(LoginApiEvent(_email.text,_password.text, context, rememberMe));
                          });
                        }
                      ),
                    ],),
                  ),
                  Positioned(
                      bottom: 15.h,
                      left: 0,
                      right: 0,
                      child: customFooter(title: AppConstants.dontHaveAccount, clickableText: AppConstants.signUp, callback: () {
                        Navigator.push(context, MyRoute(const Register()));
                      })),

                ],
              ),
            ],
          ),
        ),
      ),
    );
  }



  Widget _forgetRememberMe(){
    return Row(children: [
      Checkbox.adaptive(
          fillColor: MaterialStateProperty.resolveWith((states) => AppColors.primary),
          checkColor:AppColors.black,
          activeColor: AppColors.white,
          overlayColor: MaterialStateProperty.resolveWith((states) => AppColors.white) ,
          value: rememberMe, onChanged: (a){
        setState(() {
          rememberMe=a!;
        });
      }),
      Text(AppConstants.rememberMe,style: AppTextStyles.robotoMedium(color: AppColors.black191B32, fontSize: 14.sp, weight: FontWeight.w500)),
      const Spacer(),
      TextButton(onPressed: (){
        Navigator.push(context, MyRoute(const ForgotPassword()));
      }, child: Text(AppConstants.forgotPassword,style: AppTextStyles.robotoMedium(color: AppColors.primary, fontSize: 14.sp, weight: FontWeight.bold)))
    ],);
  }


}
