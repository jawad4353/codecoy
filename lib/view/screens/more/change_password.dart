import 'package:codecoy/utilis/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../main.dart';
import '../../../utilis/app_colors.dart';
import '../../../utilis/app_images.dart';
import '../../../utilis/app_preferences.dart';
import '../../../utilis/app_text_styles.dart';
import '../../widgets/custom_appbar.dart';

class ChangePassword extends StatefulWidget{
  const ChangePassword({super.key});
  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController currentPassword= TextEditingController();
  TextEditingController newPassword= TextEditingController();
  TextEditingController confirmPassword= TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar:PreferredSize(
          preferredSize: const Size.fromHeight(59.0),
          child: myAppBar(title:AppConstants.changePassword,context:context)),
      body: _body(),
    );
  }

  Widget _body(){
    return SingleChildScrollView(
      child: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
        child: Column(
          children: [
            SizedBox(height: 20.h,),

            PasswordTextField(hintText:'Current Password' ,controller:currentPassword ,),
            SizedBox(height: 10.h,),
            PasswordTextField(hintText:'New Password' ,controller:newPassword ),
            SizedBox(height: 10.h,),
            PasswordTextField(hintText:'Confirm New Password' ,controller:confirmPassword ),
            SizedBox(height: 10.h,),
            SizedBox(
                height: 45.h,
                width: 1.sw*0.93,
                child:  ElevatedButton(

                    style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary,shape:  RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.r)
                    )),
                    onPressed: () async {

                      if(currentPassword.text.replaceAll(' ', '').isEmpty){
                        EasyLoading.showInfo('Current password required !');
                        return;
                      }
                      if(currentPassword.text!=(preferences.getString(AppPrefs.keyPassword))){
                        EasyLoading.showInfo('Incorrect current password !');
                        return;
                      }

                      if(newPassword.text.replaceAll(' ', '').isEmpty){
                        EasyLoading.showInfo('New password required !');
                        return;
                      }
                      if(newPassword.text.replaceAll(' ', '').length<8){
                        EasyLoading.showInfo('Passwords must have eight characters');
                        return;
                      }
                      if(confirmPassword.text.replaceAll(' ', '').isEmpty){
                        EasyLoading.showInfo('Confirm password required !');
                        return;
                      }

                      if(confirmPassword.text!=newPassword.text){
                        EasyLoading.showInfo('Confirm and new passwords are not maching');
                        return;
                      }


                    }, child: Text('Reset',style: AppTextStyles.robotoMedium(color: AppColors.white, fontSize: 15.sp, weight: FontWeight.w400),))),

          ],
        ),
      ),
    );
  }


  // Future<void> resetPassword() async {
  //   try{
  //     EasyLoading.show(status: 'resetting');
  //     ApiResponse response=await NetworkConfig.postApiWithTokenCall(ApiUrls.baseUrl+ApiUrls.apiResetPassword, {Params.newPassword:newPassword.text});
  //     if(response.done??false){
  //       Map map=json.decode(response.responseString??'');
  //       if(map['success']==true){
  //         preferences.setString(AppPrefs.keyPassword, newPassword.text);
  //         EasyLoading.showSuccess(map['message']);
  //         return;
  //       }
  //       else{
  //         EasyLoading.showSuccess(map['message']);
  //       }
  //     }
  //     else{
  //       EasyLoading.showError(response.errorMsg??'');
  //     }
  //   }
  //   catch(e){
  //     EasyLoading.showError(e.toString());
  //   }
  // }

}


class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;

  const PasswordTextField({
    Key? key,
    required this.hintText,
    required this.controller,
  }) : super(key: key);

  @override
  _PasswordTextFieldState createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool showPassword = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextField(
        controller: widget.controller,
        obscureText: !showPassword,
        keyboardType: TextInputType.visiblePassword,
        style:AppTextStyles.robotoMedium(color: AppColors.black0E0F10, fontSize: 17.sp, weight: FontWeight.w200),
        cursorHeight: 24,
        cursorWidth: 3,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                showPassword = !showPassword;
              });
            },
            icon: Icon(
              showPassword ? Icons.visibility : Icons.visibility_off,
              color: AppColors.primary,
            ),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(AppImages.iconPassword,color: AppColors.primary,),
          ),
          hintStyle:AppTextStyles.robotoMedium(color: AppColors.grey0E0F10, fontSize: 15.sp, weight: FontWeight.w200),
          hintText: widget.hintText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide:  BorderSide(color: AppColors.primary, width: 1.0),
          ),
        ),
      ),
    );
  }
}


